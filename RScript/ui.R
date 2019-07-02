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
                       div(selectInput("selectplot",label=NULL,choices=c("Upset","GGMissPlot"))),
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
                tabPanel("Plot", "UpsetR or GgMissUpset",plotOutput("UpsetR"))
              ))
  )),
  skin = "black"
))