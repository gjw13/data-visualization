# Guided Exercise 4

# loading packages tidyverse and lubridate
library(tidyverse)
library(lubridate)

# load the temperature anomalies data from the csv
monthly_temps <- read_csv("monthly_global_land_and_ocean_temperature_anomalies.csv")
# add column called month_number to monthly_temps making the values equal to their row number
monthly_temps <- mutate(monthly_temps, month_number = row_number())
# makes the existing column YearMonth and turns it into a date value
# if day value doesn't exist, fill in with 1
monthly_temps <- mutate(monthly_temps, date = ymd(YearMonth, truncated=1))
# converts date column into year and month column, where month is equal to its abbrevation
monthly_temps <- mutate(monthly_temps,
                        year=year(date),
                        month=month(date,label=TRUE))
# changes name of column from Value to temperature_anomaly
monthly_temps <- rename(monthly_temps, temperature_anomaly = Value)
# delete the column YearMonth as it is not necessary any longer
monthly_temps <- select(monthly_temps, -YearMonth)

# generate line graph
ggplot(monthly_temps, 
       aes(x=month, 
           y=temperature_anomaly,
           group=year,
           color=temperature_anomaly))+
  geom_line()+
  labs(title="Historical Temperature Anomalies\n Since 1880 by Month",
       y="Temperature Anomaly in Degrees Celsius",x=element_blank())+
  scale_color_gradientn(colors=rev(rainbow(2)), guide=FALSE)+
  scale_x_discrete(breaks=c("Feb","Apr","Jun","Aug","Oct","Dec"))+
  theme_minimal()

# generate polar coordinate graph
ggplot(monthly_temps, 
       aes(x=month, 
           y=temperature_anomaly,
           group=year,
           color=temperature_anomaly))+
  geom_line()+
  labs(title="Historical Temperature Anomalies\n Since 1880 by Month",
       y="Temperature Anomaly in Degrees Celsius",x=element_blank())+
  scale_color_gradientn(colors=rev(rainbow(2)), guide=FALSE)+
  scale_x_discrete(breaks=c("Feb","Apr","Jun","Aug","Oct","Dec"),expand=c(0,0))+
  scale_y_continuous(breaks=NULL)+
  coord_polar(theta="x",start=0)+
  theme_minimal()


# save modified data to an .RData file after writing the information out to a CSV
write_csv(monthly_temps, "modified_monthly_temps.csv")
save(monthly_temps, file="monthly_data.RData")
