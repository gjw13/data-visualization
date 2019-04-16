library(tidyverse)
crime <- read_csv("CrimeStatebyState.csv")

crime_2013 <- filter(crime,Year==2013, State!="United States-Total")
all_states <- map_data("state")

crime_2013 <- rename(crime_2013,region=State) # State and region columns in datasets
crime_2013 <- mutate(crime_2013, region=tolower(region))
head(crime_2013)

stateData <- left_join(all_states,crime_2013,by="region")

ggplot()+
  geom_polygon(data=stateData,
               aes(x=long, y=lat, group = group, fill=`Motor vehicle theft rate`),
               color="grey50")+
  scale_fill_gradient2(low="blue",high="red",mid="white",midpoint=200)+ #gradient 2 indicates 2 gradients
  coord_map()

RColorBrewer::display.brewer.all() #diplays all the named pallettes, only works with discrete variables

ggplot()+
  geom_polygon(data=stateData,
               aes(x=long, y=lat, group = group, fill=`Motor vehicle theft rate`),
               color="grey50")+
  scale_fill_distiller(palette="Purples")+ #distiller works with continuous variables
  coord_map()  

ggplot()+
  geom_polygon(data=stateData,
               aes(x=long,
                   y=lat,
                   group = group,
                   fill=`Motor vehicle theft rate`),
               color="grey50")+
  scale_fill_distiller(palette="Purples",direction=1)+
  coord_map()

library(treemap)
treemap(crime_2013,index="region",
        vSize="Population",
        vColor="Motor vehicle theft rate",
        type="value",palette="Oranges")


crime_2013 <- filter(crime,Year==2013, State!="United States-Total")

northeast_states<- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont", "New Jersey", "New York", "Pennsylvania")
midwest_states <- c("Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota")
south_states <- c("Delaware", "Florida", "Georgia", "Maryland", "North Carolina", "South Carolina", "Virginia", "District of Columbia", "West Virginia", "Alabama", "Kentucky", "Mississippi", "Tennessee", "Arkansas", "Louisiana", "Oklahoma", "Texas")
west_states <- c("Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", "Wyoming", "Alaska", "California", "Hawaii", "Oregon", "Washington")

crime_2013 <- mutate(crime_2013, region=ifelse(State %in% northeast_states, "Northeast",
                                                 ifelse(State %in% midwest_states, "Midwest",
                                                        ifelse(State %in% south_states, "South",
                                                               ifelse(State %in% west_states, "West","NA")))))



ggplot(crime_2013)+geom_point(aes(x=`Motor vehicle theft rate`,
                                  y=`Burglary rate`,
                                  color=region,
                                  shape=region))+
  scale_shape_manual(values=c("Midwest"=1,"Northeast"=16,"South"=3,"West"=15))
