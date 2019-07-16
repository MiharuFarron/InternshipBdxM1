library(shiny)
library(shinyWidgets)
library(DT)
library(UpSetR)
library(naniar)
library(jsonlite)
library(glue)

##########
#Domitille COQ--ETCHEGARAY
#June/July2019
##########


shinyServer(function(input,output,session){
  data <- reactiveValues()
  # Event Button Visualisation
  observeEvent(input$actBtnVisualisation, {
    if(!is.null(input$dataFile$datapath)){
      # Read input file
      data$table = read.csv(file=input$dataFile$datapath[input$dataFile$name==input$Select],
                            header = as.logical(input$header),
                            sep = input$sep,
                            quote = input$quote)
      # Change Tab
      updateTabItems(session, "tabs", selected = "AnalyseData")}})
  # Output DataTable
  output$table <- DT::renderDataTable(data$table)
  # Output Summary
  output$summary <- renderPrint({
    summary(data$table)
  })
  # Event Selection of files
  output$selectfile <- renderUI({
    if(is.null(input$dataFile)){return()}
    list(hr(
      helpText("Select files to analyse"),
      selectInput("Select",label=NULL,choices=input$dataFile$name)
    ))
  })
  # Output Plot
  output$UpsetR  <- renderPlot({
    if(input$selectplot == "Upset"){
      upset(data$table,nsets=input$num,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller")}
    else if(input$selectplot == "GGMissPlot"){
      gg_miss_upset(data$table,nsets=input$num,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller")}
  })
  
  # Multiple Events for creation of Json file
  observeEvent(c(input$rawlink,input$name,input$sep,input$header2,input$skip,input$format),{ 
    df <- reactiveValues(x="")
    meta <- reactiveValues(loop=NULL)
    sets <- reactiveValues()
    # Update Meta information each time the button MetaData is clicked
    observeEvent(input$ActMeta,{
      meta$loop <- append(meta$loop,list(list(type=input$select,index=input$num2,name=input$name3)))
      sendSweetAlert(
        session=session,
        title="Add",
        text=glue("Add to the file the meta data : {input$name3}"),
        type="success"
        
      )})
    # Update Sets information each time the button Sets is clicked
    observeEvent(input$ActStets,{
      sets$loop <- append(sets$loop,list(list(format=input$format,start=input$start,end=input$end)))
      sendSweetAlert(
        session=session,
        title="Add",
        text=glue("Add to the file the sets data : Column {input$start} to Column {input$end}"),
        type="success"
        
      )})
    # Creation of the Json Object
    observe({df$x <- toJSON(list(file = input$rawlink,
                                 name=input$name,header=input$header2,separator=input$sep,skip=input$skip,
                                 meta=meta$loop,
                                 sets=sets$loop),
                            pretty=TRUE, auto_unbox=TRUE)
    # Download the Json file with the Json Object df$x
    observe({output$dowDATA <- downloadHandler(
      filename = function(){paste("UpsetInput.json")},
      content = function(filename){
        write(df$x,filename)})})})
  })
})

