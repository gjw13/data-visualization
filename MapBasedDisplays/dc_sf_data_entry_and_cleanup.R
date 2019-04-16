library(tidyverse)
library(lubridate)
library(broom)
library(rgeos)
library(rgdal)
library(maptools)
library(mapproj)

# loading data files
sf_data <- read_csv("sf.csv")
sf_data_2017 <- read_csv("sf2017.csv")

# bind them together
sf_data <- rbind(sf_data,sf_data_2017)

# remove isolated 2017 data
remove(sf_data_2017)

# putting data into more legible categories
sf_data <- mutate(sf_data, date = mdy(Report_taken_date_EST),
                  Type=as.factor(`Data Type`),
                  Gender=as.factor(Subject_Sex),
                  Ethnicity=as.factor(Subject_Ethnicity),
                  Race=as.factor(Subject_Race),
                  District=as.factor(`Incident Location District`),
                  PSA=as.factor(`Incident Location PSA`),
                  Year=as.factor(Year)
)

# if age is juvenile or unknown = NA, otherwise age as numerical value
sf_data <- mutate(sf_data, num_age = 
                    ifelse(Age=="Juvenile"|Age=="Unknown",
                           NA,as.numeric(Age)))

# cutting age into 10-year groups
sf_data <- mutate(sf_data, cat_age = cut(num_age, 
                                         breaks=c(17,27,37,47,57,67,77,87),
                                         labels=c("18-27","28-37","38-47",
                                                  "48-57","58-67","68-77",
                                                  "78-87")))

# add "Juvenile" and "Unknown" into categorical age variable
sf_data <- mutate(sf_data, cat_age = ifelse(Age=="Juvenile"|Age=="Unknown",Age,
                                            as.character(cat_age)))

# rename categorical age variable to Age_binned, coerce to factor
# Make "Juvenile" the first level of that factor
sf_data <- mutate(sf_data, Age_binned=as.factor(cat_age))
sf_data <- mutate(sf_data, Age=fct_relevel(Age,"Juvenile"),
                  Age_binned=fct_relevel(Age_binned,"Juvenile"))

# create Month variable
sf_data <- mutate(sf_data, Month=month(date,label=T,abbr=F))

# import geospatial data about Police Districts
districts <- readOGR("Police_Districts.shp",layer="Police_Districts")

# defining districts as "id" variable
names(districts@data)[1] <- "id"

# extracting the lat/long coordinates of district boundary points
# telling the tidy function that the region value can be found in the "id" variable
districts.points <- tidy(districts, region="id")

# combine lat/long coordinates of district boundary points with data about districts
districts.cart <- full_join(districts.points, districts@data, by="id")

# import geospatial data about Police Service Areas
psas <- readOGR("Police_Service_Areas.shp",layer="Police_Service_Areas")

# extracting the lat/long coordinates of PSA boundary points
# telling the tidy function that the region value can be found in the "PSA" variable
psas.points <- tidy(psas, region="PSA")

# combine lat/long coordinates of district boundary points with data about districts
# tell join function that "id" in psas.points corresponds to "PSA" in psas@data
psas.cart <- full_join(psas.points, psas@data, by=c("id" = "PSA"))

