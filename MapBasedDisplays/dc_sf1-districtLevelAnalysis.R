#Racial analysis by District

plot_data <- filter(sf_data,!is.na(District))

levels(plot_data$District) <- c("First District","Second District",
                                "Third District","Fourth District",
                                "Fifth District","Sixth District",
                                "Seventh District")

all_cats <- expand(plot_data,District,Race)

plot_data <- summarize(group_by(plot_data, District,Race,Gender),reports=n())

plot_data <- full_join(plot_data,all_cats,by=c("District","Race"))

#plot_data <- mutate(plot_data,reports=replace_na(reports,0))

names(plot_data)[1] <- "NAME"

mapdata <- full_join(plot_data,districts.cart,by="NAME")

g <- ggplot() +
  geom_polygon(data=mapdata,
               aes(x=long, y=lat, group=group,fill=reports),color="black") +
  coord_map()+
  theme_void()

g+facet_wrap(~Race+Gender)+
  scale_fill_distiller(palette="Spectral", name="Number of Reports",na.value="white")
