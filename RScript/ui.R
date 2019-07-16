library(shiny)
library(shinydashboard)

##########
#Domitille COQ--ETCHEGARAY
#June/July2019
##########


shinyUI(dashboardPage(
  dashboardHeader(titleWidth = 400,
                  title="Tools Comparator for SNP Prediction"),
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
              h1("Data Reading"),
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
                       # Input: Select file of interest ----
                       uiOutput("selectfile"),
                       div(actionButton(inputId = "actBtnVisualisation", label = "Visualisation",icon = icon("play") ))
                )
              )
              
      ),
      # Analyse data
      tabItem(tabName = "AnalyseData",
              h1("Data Analyses"),
              tabBox(
                title="Analyses",
                id="TabAnalyse",height="800px",width="12",
                # TabPanel with DataTable Output
                tabPanel("Table", dataTableOutput(outputId="table")),
                # TabPanel with Summary Output
                tabPanel("Summary",verbatimTextOutput("summary")),
                # TabPanel with Plot Output
                tabPanel("Plot",div(
                  # Selection between two types of plot
                  selectInput("selectplot",label=NULL,choices=c("Upset","GGMissPlot"))), 
                  # Input Number of Intersection for UpSet Plot 
                  numericInput("num",label=h5("Number of Intersections"),value=9),
                  plotOutput("UpsetR")),
                # TabPanel for Creation of the Json file
                tabPanel("Upset JSON File",
                         div(id="dowUPSET",h4("Creation of the JSON FILE : Push the Json on your Github account and use the raw link to import your dataset in UpSet WebSite and visualize your result :",tags$a(href="https://vcg.github.io/upset/","Upset Website"))),
                         box(
                           title="Upset Input File",status="primary",solidHeader = TRUE,
                           # Input of the different parameters of the file
                           fluidRow(column(4,
                                           textInput("rawlink",label="Insert raw link github of the csv file",value="https://raw.githubusercontent.com/MiharuFarron/InternshipBdxM1/master/OutputData/test_multi_data_PACov.csv"),
                                           textInput("name",label="Name for Upset",value="SNPFile")),
                                    (column(6,
                                            radioButtons(inputId = "header2", label = "Header",choices = c("0" = 0,"1" = 1),selected = 0, inline=T),
                                            radioButtons(inputId = "skip", label = "Skip",choices = c("0" = 0,"1" = 1),selected = 0, inline=T)))),
                           div(id="meta",fluidRow(column(4,
                                                         textInput("name3",label="Name of the column",value="ID")),
                                                  column(4,
                                                         numericInput("num2",label="Index",value=0,width=100)),
                                                  column(4,
                                                         selectInput("select", label = h5("Select type"), 
                                                                     choices = list("ID" = "id", "String" = "string", "Integer" = "integer","Float"="float"), 
                                                                     selected = "id",width = 100)),
                                                  
                                                  column(2,
                                                         actionButton(inputId = "ActMeta", label = "Add Meta Data",icon = icon("play"))))),
                           div(id="sets",fluidRow(column(4,
                                                         textInput("format",label="Format",value="binary")),
                                                  column(4,
                                                         numericInput("start",label="First Column",value=0,width=100)),
                                                  column(4,
                                                         numericInput("end",label="Last Column",value=0,width=100)),
                                                  column(2,
                                                         actionButton(inputId = "ActStets", label = "Add Set Data",icon = icon("play"))))),
                           br(),
                           # Output download file
                           downloadButton("dowDATA","Download")),
                         # Help for the creation of the Json File
                         box(
                           title="Help",status = "primary",solidHeader = TRUE,
                           h4(div('{ "file": "https://raw.githubusercontent.com/User/Folder/../file",',br(),
                                  '"name": "SNPFile",',br(),
                                  '"header": 0,',br(),
                                  '"separator": ";",',br(),
                                  '"skip": 0,',br(),
                                  '"meta": [ {"type": "id","index": 0,"name": "ID"} ]',br(),
                                  '"sets": [ {"format": "binary","start": 1,"end": 9} ] }')),
                           h5(div(
                             tags$b("file"), "describes the path to the data file. This path typically should be a globally accessible URL, unless you run UpSet locally, in which case you can use relative paths.",br(),
                             tags$b("name"), "is a custom name that you can give to your dataset. The name will then be shown in UpSet.",br(),
                             tags$b("header"), "defines the row in the dataset where your column IDs are stored (the sets and the attributes). Notice that both columns and rows are addressed using indices starting at 0!",br(),
                             tags$b("separator"), "defines which symbols are used to separate the cells in the matrix. Common symbols used are semicolon ;, colon ,, and tab \t. Here we use ;.",br(),
                             tags$b("skip"), "is currently not in use but will provide the ability to skip rows at the beginning of the file, to exclude, for example, comments.",br(),
                             tags$b("meta"), "is an array of metadata that specifies the id column and attribute columns. The above example defines the first column in the file (the column with index 0) to contain the identifiers for the elements. The name of the identifiers is 'Name'. meta is also used for attributes, which we will discussed later. Notice that identifiers have to be unique.",br(),
                             tags$b("sets"), "defines the sets in the dataset. They are specified in an array to allow multiple ranges of sets within a file. Here only one range of sets is defined, from the start index 1 (the second column) to the end index 3 (the fourth column). UpSet currently only supports binary format, other formats will be added in the future."
                           )),
                           h6("Information takes from",tags$a(href="https://github.com/VCG/upset/wiki","Upset Website Wiki")),height=500)
                ))
      )))
))