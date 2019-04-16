library(shiny)

# Define UI for application that draws a bubble plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Urbanization and Property Crime"),
  
  # Sidebar with a slider input for current year 
  sidebarLayout(
    sidebarPanel(
      sliderInput("Year",
                  "Current Year",
                  min = 1970,
                  max = 2010,
                  value = 1970,
                  step = 10,
                  sep="",
                  animate=animationOptions(interval=800)),  #interval is generating one frame every 200 miliseconds, if it grays out, make animation slower, put the number to 800
      ##in selectInput below, viewer sees "Per Capita Income" on the left, the data is "come" on the right
      selectInput("xVar","Select an X Variable",c("Urbanization Rate (%)" = "urban_rate","Property Crime Rate (per 100,000)" = "property_crime_rate")),
      selectInput("yVar","Select a Y Variable",c("Urbanization Rate (%)" = "urban_rate","Property Crime Rate (per 100,000)" = "property_crime_rate")),
      checkboxInput("xLog","Plot X-Axis on Logarithmic Scale?"), ## first argument for every Input fn must be an ID name
      checkboxInput("yLog","Plot Y-Axis on Logarithmic Scale?"),
      checkboxInput("xPercent","Label X-Axis as Percentage?"),
      checkboxInput("yPercent","Label Y-Axis as Percentage?"),
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