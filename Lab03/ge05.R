## ------------------------------------------------------------------------
library(tidyverse)
library(lubridate)
gridded_data <- read_csv("gridded_data.csv",col_names =F)
head(gridded_data)

## ------------------------------------------------------------------------
number_of_months <- nrow(gridded_data)/37

## ------------------------------------------------------------------------
monthly_data <- vector("list",number_of_months)

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
current_data <- monthly_data[["Apr 1975"]]

## ------------------------------------------------------------------------
latitudes <- rev(seq(from=-87.5, to=87.5, by=5))
current_data$latitude <- latitudes

## ------------------------------------------------------------------------
longitudes <- seq(from=-177.5, to=177.5, by=5)

## ------------------------------------------------------------------------
colnames(current_data)[1:72] <- longitudes

## ------------------------------------------------------------------------
current_data <- gather(current_data, key="longitude", value="TempAnom", -latitude)
head(current_data)

## ------------------------------------------------------------------------
class(current_data$latitude)
class(current_data$longitude)

## ------------------------------------------------------------------------
current_data$longitude <- as.numeric(current_data$longitude)

## ------------------------------------------------------------------------
current_data <- mutate(current_data,
                       TempAnom = ifelse(TempAnom==-9999, NA, TempAnom/100))
head(current_data)

## ------------------------------------------------------------------------
ggplot(current_data,aes(x=longitude, y=latitude, fill=TempAnom))+
  geom_tile(width=5, height=5)+scale_fill_gradient2(low="blue",mid="white",high="red")+
  coord_fixed()+theme_void()

## ------------------------------------------------------------------------
library(maps)
world <- map_data("world")

g<-ggplot()+
  geom_tile(data=current_data,
            aes(x=longitude, y=latitude, fill=TempAnom),
            width=5, height=5,alpha=.5)+
  scale_fill_distiller(palette="RdBu")+
  theme_void()

g <- g+geom_path(data = world, aes(x = long, y = lat, group = group))

g + coord_map(xlim=c(-180,180),ylim=c(-90,90))

## ------------------------------------------------------------------------
g + coord_map("gilbert",xlim=c(-180,180),ylim=c(-90,90))
g + coord_map("globular",xlim=c(-180,180),ylim=c(-90,90))
g + coord_map("ortho", orientation = c(25, 5, 0)) # orientation = c(latitude, longitude, rotation)
g + coord_map("ortho", orientation = c(-25, -25, 30)) # orientation = c(latitude, longitude, rotation)

## ---- eval=F-------------------------------------------------------------
## current_data$latitude <- latitudes
## colnames(current_data)[1:72] <- longitudes
## current_data <- gather(current_data, key="longitude", value="TempAnom", -latitude)
## current_data$longitude <- as.numeric(current_data$longitude)
## current_data <- mutate(current_data,
##                        TempAnom = ifelse(TempAnom==-9999, NA, TempAnom/100))

## ---- echo=F-------------------------------------------------------------
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

g<-ggplot()+
  geom_tile(data=current_data,
            aes(x=longitude, y=latitude, fill=TempAnom),
            width=5, height=5,alpha=.5)+
  scale_fill_gradient2(low="blue",mid="white",high="red",midpoint=0)+
  theme_void()+labs(title=current_name)

g <- g+geom_path(data = world, aes(x = long, y = lat, group = group))

g + coord_quickmap()
g + coord_map("albers",parameters=c(0,0))
g + coord_map("ortho", orientation = c(25, 5, 0))

## ---- eval=F-------------------------------------------------------------
## save(x,y,z,file="alpha.RData")

