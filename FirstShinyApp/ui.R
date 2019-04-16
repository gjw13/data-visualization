library(shiny)

# Define UI for application that draws a bubble plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("GapMinder Imitation Plot"),
  
  # Sidebar with a slider input for current year 
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "Current Year",
                  min = 1800,
                  max = 2018,
                  value = 1800,
                  sep="",
                  animate=animationOptions(interval=200)),
      selectInput("xVar","Select an X Variable",c("Population" = "population","Per Capita Income" = "income", "Life Expectancy"="expectancy","Child Mortality"="mortality")),
      selectInput("yVar","Select a Y Variable",c("Population" = "population","Per Capita Income" = "income", "Life Expectancy"="expectancy","Child Mortality"="mortality")),
      checkboxInput("xLog","Plot X-Axis on Logarithmic Scale?"),
      checkboxInput("yLog","Plot Y-Axis on Logarithmic Scale?"),
      checkboxInput("xDollar","Label X-Axis as Dollar Amount?"),
      checkboxInput("yDollar","Label Y-Axis as Dollar Amount?"),
      textInput("xLabel","Provide a Label for the X-Axis","X-Axis Label"),
      textInput("yLabel","Provide a Label for the Y-Axis","Y-Axis Label"),
      checkboxInput("line","Display Linear Trend?"),
      numericInput("maxSize","Set Size Scale for Points",25,1,50)
    ),
    
    # Show a bubble plot of selected year
    mainPanel(
      plotOutput("bubblePlot")
    )
  )
))
