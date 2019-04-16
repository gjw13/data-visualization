library(tidyverse)
library(lubridate)
library(maps)

#Read in data and clean up
gridded_data <- read_csv("gridded_data.csv",col_names =F)
number_of_months <- nrow(gridded_data)/37
monthly_data <- vector("list",number_of_months)

for(i in 1:number_of_months){
  monthly_data[[i]] <- gridded_data[((i-1)*37+2):(i*37),] #extract and store temperature anomalies
  
  integer_date <- gridded_data[((i-1)*37+1),2]*100+gridded_data[((i-1)*37+1),1] #get date for current month in yyyymm format
  
  current_date <- ymd(integer_date ,truncated=1)  #convert to Date class
  
  current_month <- month(current_date, label=T) #extract named month
  current_year <- year(current_date) #extract year
  
  names(monthly_data)[i] <- paste(current_month, current_year) #paste together named month and year to name data
}

current_data <- monthly_data[["Apr 1975"]]
latitudes <- rev(seq(from=-87.5, to=87.5, by=5))
current_data$latitude <- latitudes
longitudes <- seq(from=-177.5, to=177.5, by=5)
colnames(current_data)[1:72] <- longitudes
current_data <- gather(current_data, key="longitude", value="TempAnom", -latitude)


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

remove(current_data)
