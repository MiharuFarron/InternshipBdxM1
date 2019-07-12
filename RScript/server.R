library(shiny)
library(shinyWidgets)
library(DT)
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
    observeEvent(c(input$slider,input$rawlink),{ 
      df <- reactiveValues(x="")
      df$x <- toJSON(list(file = input$rawlink,
                        name="SNPFile",header=0,separator="\t",skip=0,
                        meta=list(list(type="id",index=0,name="POS"),list(type="string",index=1,name="REF"),list(type="string",index=2,name="ALT")),
                        sets=list(list(format="binary",start=input$slider[1],end=input$slider[2]))),
                     pretty=TRUE, auto_unbox=TRUE)
      output$dowDATA <- downloadHandler(
        filename = function(){paste("test.json")},
        content = function(filename){
          write(df$x,filename)})
    })
    url <- a("Upset WebSite", href="https://vcg.github.io/upset/")
    output$linkupset <- renderUI({tagList("Push the Json on your Github account and use the raw link to import your dataset in UpSet WebSite and visualize your result : ",url)})
      
})

