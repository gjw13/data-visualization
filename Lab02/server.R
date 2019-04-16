library(shiny)

# Define server logic required to draw a bubbleplot
shinyServer(function(input, output) {
   
  output$bubblePlot <- renderPlot({
    
    plot_data <- filter(full_data,Year==input$Year)
    
    xlimits <- c(1, max(full_data[,input$xVar],na.rm=T))
    ylimits <- c(1, max(full_data[,input$yVar],na.rm=T))
    midpoint <- c(mean(xlimits),mean(ylimits))
    
    
    g <- ggplot(plot_data) + 
      annotate(geom="text",
               x=midpoint[1],
               y=midpoint[2],
               label=input$Year,
               color="grey50",
               size=20)+
      geom_point(aes_string(x=input$xVar,
                     y=input$yVar,
                     size="Population",
                     color="region"))+
      scale_size_area(guide=F,max_size=input$maxSize)+
      scale_color_discrete(name=element_blank())+
      theme_minimal()#+
      #scale_x_continuous(limits=xlimits)+
      #scale_y_continuous(limits=ylimits)
    
    if(input$line){
      g <- g+geom_smooth(method="lm",aes_string(x=input$xVar,
                                                y=input$yVar),
                         se=F)
    }
    
    if(input$xLog & input$xPercent){
      g <- g + scale_x_continuous(trans="log2",
                                  limits=xlimits,
                                  labels=scales::percent_format(scale=1, accuracy = 1),
                                  name=input$xLabel)
    } else if(input$xLog & !input$xPercent) {
      g <- g + scale_x_continuous(trans="log2",
                                  limits=xlimits,
                                  labels=scales::comma,
                                  name=input$xLabel)
    } else if(!input$xLog & input$xPercent){
      g <- g + scale_x_continuous(limits=xlimits,
                                  labels=scales::percent_format(scale=1, accuracy = 1),
                                  name=input$xLabel)
    } else {
      g <- g + scale_x_continuous(limits=xlimits,
                                  labels=scales::comma,
                                  name=input$xLabel)
    }
    
    if(input$yLog & input$yPercent){
      g <- g + scale_y_continuous(trans="log2",
                                  limits=ylimits,
                                  labels=scales::percent_format(scale = 1, accuracy = 1),
                                  name=input$yLabel)
    } else if(input$yLog & !input$yPercent) {
      g <- g + scale_y_continuous(trans="log2",
                                  limits=ylimits,
                                  labels=scales::comma,
                                  name=input$yLabel)
    } else if(!input$yLog & input$yPercent){
      g <- g + scale_y_continuous(limits=ylimits,
                                  labels=scales::percent_format(scale=1, accuracy = 1),
                                  name=input$yLabel)
    } else {
      g <- g + scale_y_continuous(limits=ylimits,
                                  labels=scales::comma,
                                  name=input$yLabel)
    }
    
    g
  })
  
})
