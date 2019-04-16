library(tidyverse)

income_wide <- read_csv("income.csv")
expectancy_wide <- read_csv("life_expectancy_years.csv")
population_wide <- read_csv("population_total.csv")
regions <- read_csv("regions.csv")

income_tall <- gather(income_wide,key="year",value="income",-country)
income_tall <- mutate(income_tall,year=as.numeric(year))

expectancy_tall <- gather(expectancy_wide,key="year",value="expectancy",-country)
expectancy_tall <- mutate(expectancy_tall,year=as.numeric(year))

population_tall <- gather(population_wide,key="year",value="population",-country)
population_tall <- mutate(population_tall,year=as.numeric(year))

regions <- select(regions, country=name, region)

full_data <- inner_join(income_tall,expectancy_tall,by=c("country","year"))
full_data <- inner_join(full_data,population_tall,by=c("country","year"))
full_data <- left_join(full_data,regions,by="country")

plot_data <- filter(full_data,year==1996)

ggplot(plot_data) + 
  geom_point(aes(x=income,
                 y=expectancy,
                 size=population,
                 color=region))+
  scale_size_area(guide=F,max_size=20)+
  scale_color_discrete(name=element_blank())+
  theme_minimal()+
  scale_x_continuous(labels=scales::dollar,
                     trans="log2",
                     name="Per Capita Income",
                     breaks=1000*2^seq(1:7))+
  scale_y_continuous(name="Life Expectancy")
