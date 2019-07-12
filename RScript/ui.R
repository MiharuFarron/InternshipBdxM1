library(shiny)
library(shinydashboard)


shinyUI(dashboardPage(
  dashboardHeader(title="InternshipM1"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
      menuItem("Data", tabName = "readData", icon = icon("readme")),
      menuItem("Analyse",tabName = "AnalyseData", icon = icon("poll"))
    )
  ),
  dashboardBody(
      # Read data
    tabItems(
      tabItem(tabName = "readData",
              h1("Lecture des données"),
              fileInput("dataFile",label = NULL,
                        multiple=TRUE,
                        buttonLabel = "Browse...",
                        placeholder = "No file selected"),
                        
              fluidRow(
                column(12,
                       h3("Parameters"),
                       
                       # Input: Checkbox if file has header
                       radioButtons(inputId = "header", 
                                    label = "Header",
                                    choices = c("Yes" = TRUE,
                                                "No" = FALSE),
                                    selected = TRUE, inline=T),
                       
                       # Input: Select separator ----
                       radioButtons(inputId = "sep", 
                                    label = "Separator",
                                    choices = c(Comma = ",",
                                                Semicolon = ";",
                                                Tab = "\t"),
                                    selected = "t", inline=T),
                       
                       # Input: Select quotes ----
                       radioButtons(inputId = "quote", 
                                    label= "Quote",
                                    choices = c(None = "",
                                                "Double Quote" = '"',
                                                "Single Quote" = "'"),
                                    selected = "", inline=T),
                       tags$br(),
                       uiOutput("selectfile"),
                       div(actionButton(inputId = "actBtnVisualisation", label = "Visualisation",icon = icon("play") ))
                )
              )
              
      ),
      tabItem(tabName = "AnalyseData",
              h1("Analyse des données"),
              tabBox(
                title="Analyses",
                id="TabAnal",height="800px",width="12",
                tabPanel("Table", dataTableOutput(outputId="table")),
                tabPanel("Summary",verbatimTextOutput("summary")),
                tabPanel("Plot",div(selectInput("selectplot",label=NULL,choices=c("Upset","GGMissPlot"))), 
                         numericInput("num",label=h5("Number of Intersections"),value=9),
                         plotOutput("UpsetR"),
                         div(id="dowUPSET",h4("Creation of the JSON FILE"),
                             textInput("rawlink",label="Insert raw link github of the csv file",value="https://raw.githubusercontent.com/User/folder/file.csv"),
                             sliderInput("slider",label=h4("First column/Last column"),min=0,max=25,value=c(1,9)),
                             downloadButton("dowDATA","Download"),uiOutput("linkupset")))
              ))
  )),
  skin = "black"
))