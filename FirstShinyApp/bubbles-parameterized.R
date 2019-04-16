library(tidyverse)

income_wide <- read_csv("income.csv")
expectancy_wide <- read_csv("life_expectancy_years.csv")
population_wide <- read_csv("population_total.csv")
child_mortality_wide <- read_csv("child_mortality.csv")
regions <- read_csv("regions.csv")

income_tall <- gather(income_wide,key="year",value="income",-country)
income_tall <- mutate(income_tall,year=as.numeric(year))

child_mortality_tall <- gather(child_mortality_wide,key="year",value="mortality",-country)
child_mortality_tall <- mutate(child_mortality_tall,year=as.numeric(year))

expectancy_tall <- gather(expectancy_wide,key="year",value="expectancy",-country)
expectancy_tall <- mutate(expectancy_tall,year=as.numeric(year))

population_tall <- gather(population_wide,key="year",value="population",-country)
population_tall <- mutate(population_tall,year=as.numeric(year))

regions <- select(regions, country=name, region)

full_data <- full_join(income_tall,expectancy_tall,by=c("country","year"))
full_data <- full_join(full_data,population_tall,by=c("country","year"))
full_data <- full_join(full_data,child_mortality_tall,by=c("country","year"))
full_data <- left_join(full_data,regions,by="country")

#####parameterization##############
selectedYear <- 1810
xVar <- "mortality"
yVar <- "income"
xLabel <- "Child Mortality\n(Number of 0-5 year olds died per 1000 births)"
yLabel <- "GDP per Capita"
xTrans <- "identity"
yTrans <- "log2"
xDollar <- F
yDollar <- T
###################################

plot_data <- filter(full_data,year==selectedYear)

g <- ggplot(plot_data) + 
  geom_point(aes_string(x=xVar,
                 y=yVar,
                 size="population",
                 color="region"))+
  scale_size_area(guide=F,max_size=25)+
  scale_color_discrete(name=element_blank())+
  theme_minimal()

if(xDollar){
  g <- g + scale_x_continuous(labels=scales::dollar,
                         name=xLabel,
                         trans=xTrans)
} else{
  g <- g + scale_x_continuous(name=xLabel,
                         trans=xTrans)
}

if(yDollar){
  g <- g + scale_y_continuous(labels=scales::dollar,
                         name=yLabel,
                         trans=yTrans)
} else{
  g <- g + scale_y_continuous(name=yLabel,
                         trans=yTrans)
}

g

