
library(sp)
library(ggplot2)
library(corrplot)
library(geostatbook)
library(rgdal)
library(raster)
library(rasterVis)

data(punkty)
data(granica)


####### tworzenie siatki #########

bbox(punkty) # okreslenie granic dla punktow

## tworzenie siatki
siatka <- expand.grid(x = seq(min(punkty$x), max(punkty$x), length.out = 10),
                      y = seq(min(punkty$y), max(punkty$y), length.out = 10))


coordinates(siatka) <- ~x + y  ## nadanie wspolrzednych
gridded(siatka) <- TRUE ## potwierdzenie, ze dane maja byc siatka
proj4string(siatka) <- proj4string(punkty) ## nadanie ukladu wspolrzednych ze zrodla

### podejscie alternatywne, tworzenie siatki o okreslonej rozdzielczosci 

siatka2 <- makegrid(punkty, cellsize = 500)
names(siatka2) <- c("x", "y")
coordinates(siatka2) <- ~x + y
gridded(siatka2) <- TRUE
proj4string(siatka2) <- proj4string(punkty)

### siatki regularne ####

plot(siatka)
points(punkty, pch = 1)

plot(siatka2)
points(punkty, pch = ".")

### siatki nieregularne - klasa RasterLayer ####


# granica <- readOGR(".", layer = "granica") # przyklad zaczytania pliku shp, prj, bdf, czy shx

plot(granica)

siatka_n <- raster(extent(granica))
res(siatka_n) <- c(250, 250)    # okreslanie rozdzielczosci siatki
siatka_n[] <- 0  # ustalenie wszystkich oczek siatki na 0
proj4string(siatka_n) <- proj4string(granica)  #ujednolicenie ukladu wspolrzednych
siatka_n <- mask(siatka_n, granica) # przyciecie siatki do granicy

levelplot(siatka_n, margin = FALSE)

## siatki nieregularne - klasa SpatialPixelsDataFrame ####

siatka_n <- as(siatka_n, "SpatialPointsDataFrame") # przetworzenie do odpowiedniej klasy
siatka_n <- siatka_n[!is.na(siatka_n@data$layer), ]
gridded(siatka_n) <- TRUE
plot(siatka_n)

