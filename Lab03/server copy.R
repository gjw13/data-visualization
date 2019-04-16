## ------------------------------------------------------------------------
## GRAPH 1 - Global Temperatures from 1880 to 2017
## ------------------------------------------------------------------------

shinyServer(function(input, output) { 
  output$linePlot <- renderPlot({
    current_year <- input$current_year
    current_data <- filter(monthly_temps, year <= current_year)
    
   
    
    graph1 <- ggplot(current_data)+
      geom_line(aes(x=month,y=temperature_anomaly,group=year,
                    color=yearly_temp,
                    size=record_year))+
      scale_color_distiller(palette="RdBu",guide=F, 
                            limits=c(min(monthly_temps$temperature_anomaly),
                                     max(monthly_temps$temperature_anomaly)))+
      scale_y_continuous(limits=c(min(monthly_temps$temperature_anomaly),
                                  max(monthly_temps$temperature_anomaly)),
                           name=NULL,
                          breaks=c(-1,-.5,0,.5,1),
                         labels=c(
                           expression(-1~degree*C),
                           expression(-0.5~degree*C),
                           "20th Century \nAverage",
                           expression(+0.5~degree*C),
                           expression(+1~degree*C))
                         )+
      scale_x_discrete(name=NULL)+
      scale_size_manual(values=c("TRUE"=2.0,"FALSE"=0.5,guide=F))+
      labs(title=paste("Historical Temperature Anomalies by Month 
           \n From 1880 to", input$current_year))+
      theme_classic()
    
    if(input$record){
      record_data <- filter(current_data, 
                            yearly_temp == max(current_data$yearly_temp),
                            month =="Jan")
      
      graph1 + geom_segment(data=record_data,
                       aes(x=1,xend=12,y=yearly_temp,yend=yearly_temp,
                           color=yearly_temp),
                           linetype=2,size=1.5)+theme(legend.position="none")+
        geom_text(data=record_data,aes(x=12.2,y=yearly_temp,label=year,
                                       color=yearly_temp))+
        geom_text(data=record_data,aes(x=1.1,y=yearly_temp,label=yearly_temp,
                                       color=yearly_temp))
    } else {
        graph1
      }
  })
  
  output$columnPlot <- renderPlot({
    current_year <- input$current_year
    current_data <- filter(yearly_temps, year <= current_year)
    ggplot(data=current_data)+
      geom_col(aes(x=year,y=yearly_temp,fill=yearly_temp))+
      geom_text(x=1870,y=0,label="1880")+
      geom_text(x=2027,y=0,label="2017")+
      scale_fill_distiller(palette="RdBu",guide=F,
                           limits=c(min(monthly_temps$temperature_anomaly),
                                    max(monthly_temps$temperature_anomaly)))+
      scale_x_continuous(limits=c(1860,2037))+
      scale_y_continuous(limits=c(min(monthly_temps$temperature_anomaly),
                                  max(monthly_temps$temperature_anomaly)))+
      theme_void()
  })
  
  ## ------------------------------------------------------------------------
  ## GRAPH 2 - Map Graph of Temperature Anomalies by Year - ge05
  ## ------------------------------------------------------------------------
  
  output$mapPlot <- renderPlot({
    
    # plotdata <- data.frame(drugVar = dfa[,input$drugVar], demoVar =dadf[,input$demoVar])
    
    #drugVarName <- names(drugEverVariables)[which(drugEverVariables == input$drugVar)]
    #demoVarName <- names(demographicVariables)[which(demographicVariables == input$demoVar)]
    
    #xlimits <- c(min(monthly_data[,input$longitude]), max(monthly_data[,input$longitude]),na.rm=T)
    #ylimits <- c(min(monthly_data[,input$latitude]), max(monthly_data[,input$latitude]),na.rm=T)
    
    # Default Graph
    if (input$mapProjection == "Default") {
      
      mapPlot <- ggplot()+
        geom_tile(data=dec_data,
                  aes(x=longitude, y=latitude, fill=TempAnom),
                  width=5, height=5,alpha=.5)+
        scale_fill_distiller(palette="RdBu")+
        theme_void()
      
      mapPlot <- mapPlot + geom_path(data = world, aes(x = long, y = lat, group = group))
      
      mapPlot <- mapPlot + coord_map(xlim=c(-180,180),ylim=c(-90,90)) #2D Regular
      
    }
    
    # Gilbert Graph
    if (input$mapProjection == "Gilbert") {
      mapPlot <- ggplot()+
        geom_tile(data=dec_data,
                  aes(x=longitude, y=latitude, fill=TempAnom),
                  width=5, height=5,alpha=.5)+
        scale_fill_distiller(palette="RdBu")+
        theme_void()
      
      mapPlot <- mapPlot + geom_path(data = world, aes(x = long, y = lat, group = group))
      
      mapPlot <- mapPlot + coord_map("gilbert",xlim=c(-180,180),ylim=c(-90,90)) # 3D globe circular
    }
    
    # Globular Graph
    if (input$mapProjection == "Globular") {
      mapPlot <- ggplot()+
        geom_tile(data=dec_data,
                  aes(x=longitude, y=latitude, fill=TempAnom),
                  width=5, height=5,alpha=.5)+
        scale_fill_distiller(palette="RdBu")+
        theme_void()
      
      mapPlot <- mapPlot + geom_path(data = world, aes(x = long, y = lat, group = group))
      
      mapPlot <- mapPlot + coord_map("globular",xlim=c(-180,180),ylim=c(-90,90)) # 3D globe 2 circles
    }
    
    # Ortho Graph
    if (input$mapProjection == "Ortho") {
      mapPlot <- ggplot()+
        geom_tile(data=dec_data,
                  aes(x=longitude, y=latitude, fill=TempAnom),
                  width=5, height=5,alpha=.5)+
        scale_fill_distiller(palette="RdBu")+
        theme_void()
      
      mapPlot <- mapPlot + geom_path(data = world, aes(x = long, y = lat, group = group))
      
      mapPlot <- mapPlot + coord_map("ortho", orientation = c(25, 5, 0)) #example of orientation output
    }
    
    mapPlot
    
  })
  
})

