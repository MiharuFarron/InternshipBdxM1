library(DT)
library(shiny)
library(shinyWidgets)
library(UpSetR)
library(naniar)
library(jsonlite)

shinyServer(function(input,output,session){
  output$selectfile <- renderUI({
    if(is.null(input$dataFile)){return()}
    list(hr(
      helpText("Select files to analyse"),
      selectInput("Select",label=NULL,choices=input$dataFile$name)
    ))
  })
  data <- reactiveValues()
  observeEvent(input$actBtnVisualisation, {
    if(!is.null(input$dataFile$datapath)){
      data$table = read.csv(file=input$dataFile$datapath[input$dataFile$name==input$Select],
                            header = as.logical(input$header),
                            sep = input$sep,
                            quote = input$quote)
      updateTabItems(session, "tabs", selected = "AnalyseData")}})
  output$table <- DT::renderDataTable(data$table)
  output$summary <- renderPrint({
    summary(data$table)
  })
  output$UpsetR  <- renderPlot({
    if(input$selectplot == "Upset"){
      upset(data$table,nsets=input$num,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller")}
    else if(input$selectplot == "GGMissPlot"){
      gg_miss_upset(data$table,nsets=input$num,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller")}
  })
  observeEvent(c(input$rawlink,input$name,input$sep,input$header2,input$skip,input$start,input$end,input$format),{ 
    df <- reactiveValues(x="")
    meta <- reactiveValues(loop=NULL)
    sets <- reactiveValues()
    observeEvent(input$ActMeta,{
      meta$loop <- append(meta$loop,list(list(type=input$select,index=input$num2,name=input$name3)))})
    observeEvent(input$ActStets,{
      sets$loop <- append(sets$loop,list(list(format=input$format,start=input$start,end=input$end)))})
    observe({df$x <- toJSON(list(file = input$rawlink,
                                 name=input$name,header=input$header2,separator=input$sep,skip=input$skip,
                                 meta=meta$loop,
                                 sets=sets$loop),
                            pretty=TRUE, auto_unbox=TRUE)
    observe({output$dowDATA <- downloadHandler(
      filename = function(){paste("test.json")},
      content = function(filename){
        write(df$x,filename)})})})
  })
})

