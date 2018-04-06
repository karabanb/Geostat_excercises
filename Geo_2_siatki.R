
library(sp)
library(ggplot2)
library(corrplot)
library(geostatbook)
library(rgdal)

data(punkty)
data(granica)


####### tworzenie siatki #########

## okreslenie granic dla punktow

bbox(punkty)

## tworzenie siatki
siatka <- expand.grid(x = seq(min(siatka$x), max(siatka$x), length.out = 100),
                      y = seq(min(siatka$y), max(siatka$y), length.out = 100))


coordinates(siatka) <- ~x + y  ## nadanie wspolrzednych
gridded(siatka) <- TRUE ## potwierdzenie, ze dane maja byc siatka
proj4string(siatka) <- proj4string(punkty) ## nadanie ukladu wspolrzednych ze zrodla

### podejscie alternatywne, tworzenie siatki o okreslonej rozdzielczosci 

siatka2 <- makegrid(punkty, cellsize = 500)
names(siatka2) <- c("x", "y")
coordinates(siatka2) <- ~x + y
gridded(siatka2) <- TRUE
proj4string(siatka2) <- proj4string(punkty)

### siatki regularne 

plot(siatka)
points(punkty, pch = 1)

plot(siatka2)
points(punkty, pch = 2)

### siatki nieregularne rastrowe


granica <- readOGR(".", layer = "granica") # przyklad zaczytania pliku shp, prj, bdf, czy shx

plot(granica)

siatka_n <- 



