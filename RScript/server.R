library(shiny)
library(shinyWidgets)
library(DT)
library(UpSetR)
library(naniar)

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
      data$table = read.csv(file=input$dataFile$datapath[input$dataFile$name==input$Select],
                            header = as.logical(input$header),
                            sep = input$sep,
                            quote = input$quote)
      updateTabItems(session, "tabs", selected = "AnalyseData")})
    output$table <- DT::renderDataTable(data$table)
    output$summary <- renderPrint({
      summary(data$table)
    })
    output$UpsetR  <- renderPlot({
      if(input$selectplot == "Upset"){
        upset(data$table,nsets=10,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller",empty.intersections = "on")}
      else if(input$selectplot == "GGMissPlot"){
        gg_miss_upset(data$table,nsets=10,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller",empty.intersections = "on")}
    })
})

