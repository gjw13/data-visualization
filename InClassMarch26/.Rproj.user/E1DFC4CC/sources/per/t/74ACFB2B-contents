library(tidyverse)

head(mpg)
q <- ggplot(mpg,aes(x=displ, y=cty))

q + geom_point() #scatter plot

q + geom_jitter() #jittered scatter plot

q + geom_jitter(alpha=.5) #semi-transparent jittered scatter plot

q + geom_bin2d() # tile plot displaying 2D density

q + geom_bin2d(bins=c(10,10)) #controlling binning in tile plot
q + geom_bin2d(bins=c(2,2)) + geom_jitter(color="green") #overlaying points to tile plot


q + geom_density2d() # contour plot
q + geom_density2d() + 
  scale_x_continuous(lim=c(1,7)) +
  scale_y_continuous(lim=c(8,36))

q + stat_density2d()
q + stat_density2d(aes(color=..level..))+scale_color_gradientn(colors=topo.colors(5))
q + stat_density2d(geom="polygon",aes(fill=..level..)) + scale_fill_gradientn(colors=terrain.colors(5)) + xlim(1,7)+ylim(8,36) #contour/level plot
q + stat_density2d(geom = "raster", aes(fill = ..density..), contour = FALSE) #level plot without contours

q + geom_point()
q + geom_count(alpha=.5) #bubble plot
q + geom_count(aes(size=..prop..),alpha=.5) #bubble plot
q + geom_count(aes(size=..prop.., color=as.factor(cyl)),alpha=.5) #bubble plot
q + geom_count(aes(color=as.factor(cyl)),alpha=.5) #bubble plot

q + geom_jitter(aes(color=as.factor(cyl),alpha=.5)) +
                  geom_text(aes(label=model)) #text labels

small.mpg <- mpg[sample(nrow(mpg),15),] #random subset

q + geom_point(aes(color=as.factor(cyl),alpha=.5)) +
  geom_text(data=small.mpg,aes(label=model)) #textual labels

q + geom_point(aes(color=as.factor(cyl),alpha=.5)) +
  geom_label(data=small.mpg,aes(label=model)) #textual labels

library("ggrepel")

q + geom_point(aes(color=as.factor(cyl),alpha=.5)) +
  geom_label_repel(data=small.mpg,aes(label=model)) #repeled textual labels

#smoothing/curves of best fit
q + geom_jitter() + geom_smooth(method="lm",se=T,level=.99)
q + geom_jitter() + geom_smooth(method="lm",se=T,level=.5)
q + geom_jitter() + geom_smooth(method="lm",formula=y~x)
q + geom_jitter() + geom_smooth(method="lm",formula=y~poly(x,2))
q + geom_jitter() + geom_smooth(method="lm",formula=y~poly(x,3))
q + geom_jitter() + geom_smooth(method="lm",formula=y~poly(x,4))

g <- ggplot(mpg,aes(x=displ, y=cty,color=as.factor(cyl))) +
  geom_jitter() + geom_smooth(method="lm",formula=y~poly(x,2))

g

g + facet_wrap(~cyl)

ggplot(mpg,aes(x=displ, y=cty)) +
  geom_jitter(aes(color=as.factor(cyl))) +
  geom_smooth(method="lm",formula=y~poly(x,2),color="red") +
  facet_wrap(~cyl)

###
mpg <- mutate(mpg, hwy_cut = cut(hwy,5))

ggplot(mpg) +
  geom_point(aes(x=displ, y=cty, color = hwy_cut))+
  scale_color_brewer(palette="Set1",name = "Highway Fuel Economy")


### flat displays
library(MASS)
library(tidyverse)

mydata <- data.frame(x=mpg$displ, y=mpg$cty)

my_density_estimate <- kde2d(mydata$x, mydata$y)

filled.contour(my_density_estimate,color=heat.colors)
contour(my_density_estimate)

image(my_density_estimate,col=terrain.colors(20))
contour(my_density_estimate,add=T)

####RGL - 3d manipulatable displays
library(rgl)
library(MASS)

plot3d(rnorm(10),rnorm(10),rnorm(10),col=1,size=6,pch=16)

spheres3d(rnorm(10),rnorm(10),rnorm(10),radius=runif(10),color=rainbow(10))

density.mpg<-kde2d(mpg$displ,mpg$cty)
persp3d(density.mpg)
persp3d(density.mpg,col="purple")

density.location<-kde2d(quakes$lat,quakes$long)
persp3d(density.location,col="lightblue")

plot3d(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length,
       size=as.numeric(iris$Petal.Width),
       type="s", col=as.numeric(iris$Species))

# static 3d displays
library(MASS)
library(tidyverse)
library(fields)

mydata <- data.frame(x=mpg$displ, y=mpg$cty)

my_density_estimate <- kde2d(mydata$x, mydata$y)

filled.contour(my_density_estimate,color=terrain.colors)
contour(my_density_estimate)

image(my_density_estimate,col=terrain.colors(100))
contour(my_density_estimate,add=T)

persp(my_density_estimate, col=terrain.colors(100))

color <- terrain.colors(100)
zmat <- my_density_estimate$z

zfacet <- (zmat[-1,-1]+zmat[-1,-ncol(zmat)] + zmat[-nrow(zmat),-1] + zmat[-nrow(zmat),-ncol(zmat)])/4
facetcol <- cut(zfacet,100)
persp(my_density_estimate$x,
      my_density_estimate$y,
      zmat,
      theta = 0,phi = 15, r=sqrt(3), d=1,
      col=color[facetcol])

image.plot(legend.only=T, zlim=range(zfacet), col=color)