#Yearly analysis by PSA

plot_data <- filter(sf_data,!is.na(PSA))

all_cats <- expand(plot_data,PSA,Year)

plot_data <- summarize(group_by(plot_data, PSA,Year),reports=n())

plot_data <- full_join(plot_data,all_cats,by=c("PSA","Year"))

plot_data <- mutate(plot_data,reports=replace_na(reports,0))

names(plot_data)[1] <- "NAME"

mapdata <- full_join(plot_data,psas.cart,by="NAME")

g <- ggplot() +
  geom_polygon(data=drop_na(mapdata), aes(x=long, y=lat, group=group,fill=reports),color="black") +
  coord_map()+
  theme_void()
g+facet_wrap(~Year)+
  scale_fill_distiller(palette="Spectral", name="Number of Reports")
