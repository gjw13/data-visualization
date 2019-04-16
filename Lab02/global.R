library(tidyverse)

#Read in data and clean up
crime <- read_csv("CrimeStatebyState.csv")
urbanization <- read_csv("urbanization.csv")

urbanization_long <- gather(urbanization,key="Year",value="urban_rate",-Region)

names(urbanization_long)[1] <- "State"

state_urb <- filter(urbanization_long,State!="UnitedStates",State!="Midwest",State!="Northeast",State!="West", State!= "South", Year >= 1970)

state_urb$Year <- as.numeric(as.character(state_urb$Year))
state_urb$urban_rate <- as.numeric(as.character(state_urb$urban_rate))
state_urb$State[state_urb$State == "Washington, D.C."] <- "District of Columbia"

property_crime <- select(crime,Year,State,Population,`Property crime total`,`Property crime rate`)
property_crime_decade <- filter(property_crime,Year %in% seq(1970,2010,by=10),State!="United States-Total")

full_data <- full_join(property_crime_decade,state_urb,by=c("State","Year"))

#now set regions

northeast_states<- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island",
                     "Vermont", "New Jersey", "New York", "Pennsylvania")
midwest_states <- c("Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas",
                    "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota")
south_states <- c("Delaware", "Florida", "Georgia", "Maryland", "North Carolina", "South Carolina",
                  "Virginia", "District of Columbia", "West Virginia", "Alabama", "Kentucky",
                  "Mississippi", "Tennessee", "Arkansas", "Louisiana", "Oklahoma", "Texas")
west_states <- c("Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", 
                 "Wyoming", "Alaska", "California", "Hawaii", "Oregon", "Washington")

full_data <- mutate(full_data, region=ifelse(State %in% northeast_states, "Northeast",
                                                 ifelse(State %in% midwest_states, "Midwest",
                                                        ifelse(State %in% south_states, "South",
                                                               ifelse(State %in% west_states, 
                                                                      "West","NA")))))
#rename to a "safe" variable
names(full_data)[5] <- "property_crime_rate"

#To avoid "missing value" error due to small percentage decimals
full_data$urban_rate <- full_data$urban_rate*100

