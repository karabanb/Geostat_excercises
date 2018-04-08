
## biblioteki

library(sp)
library(ggplot2)
library(corrplot)
library(geostatbook)

## dane

data(punkty)
data(granica)

### EDA ###

str(punkty) # sprawdzenie zawartości obiektu klasy `SpatialPointsDataFrame`
str(punkty@data) #Sprawdzenie tabeli atrybutów dla zbioru punktów

punkty$temp # dostep do wybranej kolumny w 1 sposob
punkty@data$temp # dostep do wybranej kolumny w 2 sposob

plot(punkty)
plot(granica, add = TRUE) # sprawdzenie czy punkty znajduja sie w obrebie granicy

### Statystki opisowe ###

summary(punkty@data) #kwantyle
sd(punkty$temp) #odchylenie standardowe

ggplot(punkty@data, aes(temp)) + geom_histogram() #histogram

ggplot(punkty@data, aes(temp)) + geom_density() # rozklad gestosci
plot(density(punkty$temp)) #tez rozklad gestosci ale z base graphics

ggplot(punkty@data, aes(sample = temp)) + stat_qq() # wykres qqplot
qqnorm(punkty$temp) #alternatywnie z base graphics






