library(tidyverse)

crimeDot <- read.csv("CrimeStatebyState.csv")
crimeUnder <- read_csv("CrimeStatebyState.csv")

crime <- crimeUnder

names(crime)


state_crime <- filter(crime,State != "United States-Total")
us_rate_2013 <- filter(crime,State == "United States-Total", Year==2013)$`Violent Crime rate`

us_data <- filter(crime,State == "United States-Total")

ggplot(us_data, aes(x=Year, y=`Violent Crime rate`)) + 
  geom_line() + 
  labs(title="Violent Crime in the United States",y="Crimes per 100,000 residents") +
  theme_classic()

ggplot(crime, aes(x=Year, y=`Violent Crime rate`)) + 
  geom_line(aes(group=State,color=State)) + 
  labs(title="Violent Crime in the United States",y="Crimes per 100,000 residents") +
  theme_classic()

northeast_states<- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont", "New Jersey", "New York", "Pennsylvania")
midwest_states <- c("Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota")
south_states <- c("Delaware", "Florida", "Georgia", "Maryland", "North Carolina", "South Carolina", "Virginia", "District of Columbia", "West Virginia", "Alabama", "Kentucky", "Mississippi", "Tennessee", "Arkansas", "Louisiana", "Oklahoma", "Texas")
west_states <- c("Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", "Wyoming", "Alaska", "California", "Hawaii", "Oregon", "Washington")

state_crime <- mutate(state_crime, region=ifelse(State %in% northeast_states, "Northeast",
                                                 ifelse(State %in% midwest_states, "Midwest",
                                                        ifelse(State %in% south_states, "South",
                                                               ifelse(State %in% west_states, "West","NA")))))

# tail(select(state_crime,State,region))

regional_rates <- summarize(group_by(state_crime, region,Year),
                            violent_rate = sum(`Violent crime total`)/sum(Population)*100000,
                            murder_rate = sum(`Murder and nonnegligent Manslaughter`)/sum(Population)*100000,
                            rape_rate = sum(`Legacy rape /1`)/sum(Population)*100000,
                            assault_rate = sum(`Aggravated assault`)/sum(Population)*100000,
                            robbery_rate = sum(`Robbery`)/sum(Population)*100000)
head(regional_rates)

ggplot(regional_rates, aes(x=Year,y=violent_rate))+geom_line(aes(group=region,color=region))

state_crime_2013 <- filter(state_crime, Year==2013)

#strip charts
ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_point(aes(y=0))

ggplot(state_crime_2013,aes(x=`Violent Crime rate`,color=region))+
  geom_jitter(aes(y=0),width=0,height=.1)+
  theme(axis.title.y=element_blank(),axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+geom_vline(xintercept=us_rate_2013)

stripchart(state_crime_2013$`Violent Crime rate`)
stripchart(state_crime_2013$`Violent Crime rate`,method="jitter")
stripchart(round(state_crime_2013$`Violent Crime rate`),method="stack")
stripchart(round(state_crime_2013$`Violent Crime rate`,-1),method="stack")

#stem and leaf
stem(state_crime_2013$`Violent Crime rate`)

#boxplots
boxplot(state_crime_2013$`Violent Crime rate`)
ggplot(state_crime_2013)+geom_boxplot(aes(x=`Violent Crime rate`))
ggplot(state_crime_2013)+geom_boxplot(aes(x=region, y=`Violent Crime rate`))

ggplot(state_crime_2013,aes(x=region, y=`Violent Crime rate`))+
  geom_boxplot()+geom_point()

ggplot(state_crime_2013,aes(x=region, y=`Violent Crime rate`))+
  geom_boxplot()+geom_jitter()

ggplot(state_crime_2013,aes(x=region, y=`Violent Crime rate`))+geom_boxplot()+
  geom_jitter(height=0,width=.1)

ggplot(state_crime_2013,aes(x=region, y=`Violent Crime rate`))+
  geom_boxplot(outlier.alpha=0)+geom_jitter(height=0,width=.1)

state_crime_recent <- filter(state_crime, Year > 2009)

state_crime_recent$region <- as.factor(state_crime_recent$region)
state_crime_recent$Year <- as.factor(state_crime_recent$Year)

ggplot(state_crime_recent,aes(x=Year, y=`Violent Crime rate`,color=region))+
  geom_boxplot()

# histograms

ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_histogram()
ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_histogram(bins=15)
ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_histogram(bins=5)
ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_histogram(binwidth=10)
ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_histogram(binwidth=30)
ggplot(state_crime_2013,aes(x=`Violent Crime rate`))+geom_histogram(binwidth=30)+
  geom_vline(xintercept=us_rate_2013)

# density plots

ggplot(state_crime_2013, aes(x=`Violent Crime rate`))+geom_density()

states_only_crime_2013 <- filter(state_crime_2013, State != "District of Columbia")

ggplot(states_only_crime_2013, aes(x=`Violent Crime rate`))+geom_density()

ggplot(states_only_crime_2013, aes(x=`Violent Crime rate`, color=region))+
  geom_density()

ggplot(states_only_crime_2013, aes(x=`Violent Crime rate`, color=region, fill=region))+
  geom_density()

ggplot(states_only_crime_2013, aes(x=`Violent Crime rate`, color=region, fill=region))+
  geom_density(alpha=.3)

ggplot(states_only_crime_2013, aes(x=`Violent Crime rate`, color=region, fill=region))+
  geom_density(alpha=.2,size=2)+xlim(0,900)

# violin plot

ggplot(states_only_crime_2013, aes(x=region, y=`Violent Crime rate`))+geom_violin()
ggplot(states_only_crime_2013, aes(x=region, y=`Violent Crime rate`))+
  geom_violin(trim=FALSE)
ggplot(states_only_crime_2013, aes(x=region, y=`Violent Crime rate`, fill=region))+
  geom_violin(trim=FALSE,draw_quantiles = c(.25,.5,.75))

ggplot(states_only_crime_2013, aes(x=region, y=`Violent Crime rate`, fill=region))+
  geom_violin(trim=FALSE,draw_quantiles = c(.25,.5,.75),adjust=.5)

ggplot(states_only_crime_2013, aes(x=region, y=`Violent Crime rate`, fill=region))+
  geom_violin(trim=FALSE,draw_quantiles = c(.25,.5,.75),adjust=.5,alpha=.5)+
  geom_jitter(width=.1,height=0,aes(color=region))

# time series plot
south_crime <- filter(state_crime, region=="South")
ggplot(south_crime, aes(x=Year, y=`Violent Crime rate`))+
  geom_line(aes(group=State, color=State))


dc_crime <- filter(state_crime, State=="District of Columbia")

ggplot(dc_crime, aes(x=Year))+
         geom_line(aes(y=`Murder and nonnegligent manslaughter rate`,color="Murder"))+
         geom_line(aes(y=`Legacy rape rate /1`,color="Rape"))+
         geom_line(aes(y=`Robbery rate`,color="Robbery"))+
         geom_line(aes(y=`Aggravated assault rate`,color="Assault"))+
  scale_color_manual(name="Legend",
                     values = c("Murder" = "Red", "Rape" = "Orange",
                                "Robbery" = "Blue","Assault"="Green"))+
  theme_classic()

library(aplpack)

crime2013 <- filter(crime, Year==2013)
crime2013 <- crime2013[,c(2,15,17,18,19,20,21,22,23)]

faces(crime2013[,2:9],labels=str_sub(crime2013$State,1,4))
