library(shiny)

# Define UI for application that draws a bubble plot
shinyUI(fluidPage(
  
  titlePanel("Climate Data Project"),
  p("The following shiny application displays three graphs pertaining to global cimate data. 
    The user can interact with each graph to display the data in a variety of ways. The first graph
    is a line graph that displays global temperatures anomalies from 1880 to 2016. The second graph is a map
    that shows temperature anomalies in December 2017. The third graph is a bar graph that displays 
    global carbon emissions (in tonnes)."),
  
  p("The data used for this project was taken from the following websites:"),
  p("•	Carbon Emission Data:https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions"),
  p("•	Global Temperature Anomalies: https://www.ncdc.noaa.gov/"),
  p("•	Model graph: https://www.bloomberg.com/graphics/hottest-year-on-record/"),
  
  titlePanel("Global Temperatures from 1880 to 2016"),
  # Sidebar with a slider input for current year 
  sidebarLayout(
    sidebarPanel(sliderInput("current_year",label="Select Year",
                             min=1880,max=2016,value=1880,step=5,sep="",
                             animate = animationOptions(interval=500,loop=T)),
                 checkboxInput("record",label="Show Record Year")),
    mainPanel(
      plotOutput("linePlot",height="300px"),
      plotOutput("columnPlot",height="50px"),
      p("We chose to replicate the Bloomberg line graph that shows the global 
        temperature anomalies as a line graph and is animated to show the progression 
        from 1880 to 2016. The user can also use their mouse to drag the slider to choose 
        how much information is displayed. The display will show which years were considered 
        record years by either the a dotted line if that option is selected or through a thick 
        line if the dotted line box is not selected. It will also show where the graph is chronologically via a 
        bar graph below the line graph.The best feature of this display is that 
        it can show the record year in two ways while also being animated. The weakest aspect of this
        display is that it lags. The unclear aspect of the display is that the user cannot see exactly which line
        corresponds to which year. I would have liked ot have been able to add a feature where hovering over
        a particular line would give the temperature anomaly value.")
      )
      ),
  
  ## ------------------------------------------------------------------------
  ## GRAPH 2 - Map Graph of Temperature Anomalies in December 2017
  ## ------------------------------------------------------------------------
  
  titlePanel("Global Temperature Anomalies in December 2017"),
  
  # Sidebar with a slider input for current year 
  sidebarLayout(
    sidebarPanel(
      selectInput("mapProjection", "Select a Map Projection", graphTypes)
    ),
    
    # Show a Map plot of selected year
    mainPanel(
      plotOutput("mapPlot")
    )
  ),
  
  p("Unclear aspects of your data and visualizations:"),
  p(" - The map graph does not have country labels or latitude or longitude labels."),
  p("How does this application work?"),
  p(" - This application takes temperature anomaly data from December of 2017 and projects the data onto a map of the world. 
    The temperature anomaly is represented by the color of the area. 
    Red indicates a warmer temperature, while blue indicates a cooler temperature."),
  p("Why did you choose to display this data in the way that you did?"),
  p(" - We chose to display the temperature data with a map graph so people can see what 
    geographical areas experience the strongest temperature anomalies. 
    We used color to represent temperature because people commonly associate temperature with color."),
  p("What do you consider to be the strongest features of your application?"),
  p(" - I consider the ability to select a map projection to be the strongest feature of the graph."),
  p("What do you consider to be the weakest features of your application?"),
  p(" - I would like to be able to change month and year. However, adding this feature complicates the graph enormously."),
  p("Were there any features that you would have liked to implement but were unable to do so?"),
  p(" - Yes, I would have liked to add a feature to change month and/or year."),
  
  ## ------------------------------------------------------------------------
  ## GRAPH 3 - Bar Graph - Carbon Emissions by Year
  ## ------------------------------------------------------------------------
  
  titlePanel("Global CO2 Emissions from 1800 to 2016"),
  
  # Sidebar with a slider input for current year 
  sidebarLayout(
    sidebarPanel(
      sliderInput("Year","Current Year",
                  min = 1800,max = 2016,value = 1800,
                  step = 5,sep="",
                  animate=animationOptions(interval=800,loop=T))
    ),
    # Show a Bar plot of selected year
    mainPanel(
      plotOutput("barPlot")
    )
  ),
  p("Unclear aspects of your data and visualizations:"),
  p(" - The bar graph becomes unclear when the minimum year approaches the maximum year of 2016."),
  p("How does this application work?"),
  p(" - This application takes global carbon emissions data from 1880 to 2016 and projects the data onto a bar graph. 
    The cumulative CO2 data is represented by the color of the bar. 
    Red indicates a higher CO2 output for the year, while blue indicates a lower CO2 output for the year."),
  p("Why did you choose to display this data in the way that you did?"),
  p(" - We chose to display the temperature data with a bar graph so that people can see the sheer increase
    increase in CO2 emissions since the 1800s, and the stedy climb we have been on since. 
    We used color to represent emissions because higher emissions can be dangerous for our atmosphere.
    The color red is commonly associated with danger."),
  p("What do you consider to be the strongest features of your application?"),
  p(" - I consider the ability to select a specific year and see the increase in CO2 emissions since that year to be
    the strongest part of the bar graph."),
  p("What do you consider to be the weakest features of your application?"),
  p(" - I would like to avoid having on singular bar when the graph nears the maximum year 2016."),
  p("Were there any features that you would have liked to implement but were unable to do so?"),
  p(" - Yes, I would have liked to add a linear regression line to emphasize the trend over the years 
    but I couldn't get it to work.")
))