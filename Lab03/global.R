
# Lab 03 - Climate Data Application
# Group 11: Eric Yu, Greg Wills, Josh Gatcke

# 3 Graphs
# ge04 Line Graph of Temperature Anomalies
# ge05 Map Projection with changing year via text entry
# ge04 Bar Graph Co2 emissions

library(tidyverse)
library(lubridate)
library(maps)
library(mapproj)


## ------------------------------------------------------------------------
## GRAPH 1 - Global Temperatures from 1880 to 2017
## ------------------------------------------------------------------------

monthly_temps <- read.csv("monthly_global_land_and_ocean_temperature_anomalies.csv")

#mutates the monthly_temps object so that it converts the YearMonth variable to year-month-date format, and truncated=1 indicates that the date is missing, ultimately converts it from an int to Date class
monthly_temps <- mutate(monthly_temps, 
                        date = ymd(YearMonth, truncated=1)) 
# Extract Year and Month
monthly_temps <- mutate(monthly_temps,
                        year=year(date),
                        month=month(date,label=TRUE))

#renames the "Value" variable as "temperature_anomaly"
monthly_temps <- rename(monthly_temps, temperature_anomaly = Value)

#gets rid of the YearMonth variable
monthly_temps <- select(monthly_temps, -YearMonth) 


#make yearly_temps object

yearly_temps <- summarize(group_by(monthly_temps,year),
                          yearly_temp = mean(temperature_anomaly))

yearly_temps$record_year <- rep(NA,nrow(yearly_temps))

for(i in 1:nrow(yearly_temps)){
  current_temp <- yearly_temps[i,2]
  comparison_temps <- yearly_temps[1:i,2]
  yearly_temps$record_year[i] <- ifelse(
    current_temp == max(comparison_temps),T,F)
}

monthly_temps <- left_join(monthly_temps, yearly_temps)

## ------------------------------------------------------------------------
## DATA ENTRY FOR TEMP ANOMALIES - MAP GRAPH ge05
## ------------------------------------------------------------------------

gridded_data <- read_csv("gridded_data.csv",col_names =F)
number_of_months <- nrow(gridded_data)/37
monthly_data <- vector("list",number_of_months)
world <- map_data("world")

graphTypes <- list("Default", "Gilbert","Globular","Ortho")

## ------------------------------------------------------------------------
for(i in 1:number_of_months){
  monthly_data[[i]] <- gridded_data[((i-1)*37+2):(i*37),] #extract and store temperature anomalies
  
  integer_date <- gridded_data[((i-1)*37+1),2]*100+gridded_data[((i-1)*37+1),1] #get date for current month in yyyymm format
  
  current_date <- ymd(integer_date ,truncated=1)  #convert to Date class
  
  current_month <- month(current_date, label=T) #extract named month
  current_year <- year(current_date) #extract year
  
  names(monthly_data)[i] <- paste(current_month, current_year) #paste together named month and year to name data
}

## ------------------------------------------------------------------------
current_data <- monthly_data[["Dec 2017"]]

## ------------------------------------------------------------------------
latitudes <- rev(seq(from=-87.5, to=87.5, by=5))
current_data$latitude <- latitudes

## ------------------------------------------------------------------------
longitudes <- seq(from=-177.5, to=177.5, by=5)

## ------------------------------------------------------------------------
colnames(current_data)[1:72] <- longitudes

## ------------------------------------------------------------------------
current_data <- gather(current_data, key="longitude", value="TempAnom", -latitude)

## ------------------------------------------------------------------------
current_data$longitude <- as.numeric(current_data$longitude)

## ------------------------------------------------------------------------
current_data <- mutate(current_data,
                       TempAnom = ifelse(TempAnom==-9999, NA, TempAnom/100))

for(i in 1:number_of_months){
  current_data <- monthly_data[[i]]
  
  current_data$latitude <- latitudes
  colnames(current_data)[1:72] <- longitudes
  current_data <- gather(current_data, key="longitude",
                         value="TempAnom", -latitude)
  current_data$longitude <- as.numeric(current_data$longitude)
  current_data <- mutate(current_data,
                         TempAnom = ifelse(TempAnom==-9999, NA, TempAnom/100))
  
  monthly_data[[i]] <- current_data
}

## ------------------------------------------------------------------------
current_month <- "Dec 2017"
current_data <- monthly_data[[current_month]]
current_name <- names(monthly_data[current_month])
dec_data <- current_data
remove(current_data)

