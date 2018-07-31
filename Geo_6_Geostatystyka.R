
#### biblioteki ################################################################################

library("gstat")
library("sp")
library("pgirmess")
library("ggplot2")
library("raster")
library("rasterVis")
library("geostatbook")

#### data ######################################################################################

data(punkty)
data(siatka)
data(granica)
load("data/some_district.Rdata")

#### przygotowanie danych ######################################################################

dochody <- prepared_data[, c("x", "y", "dochod_bud_pra", "dystans_bankomat")]

n <- 300
dochody_sample <- prepared_data[sample(x = 1:nrow(prepared_data), n, replace = FALSE ), c("x", "y", "dochod_bud_pra")]

coordinates(dochody) <- ~x + y
proj4string(dochody) <- "+proj=longlat +ellps=WGS84 +units=m"

#### wykres rozrzutu jednej zmiennej z przesunieciem (h-scattergram) ###########################

lagged_scatterplot <- hscat(dochod_bud_pra~1, dochody, breaks = seq(0, 0.1, 0.01), pch = ".")

#### kowariogram ###############################################################################

covariogram <- variogram(dochod_bud_pra~1, dochody, covariogram = TRUE)
plot(covariogram)

#### autokorelacja przestrzenna ################################################################

i <- 1

for (n in seq(11000, 22000, 2000)) {
  dochody_sample <- prepared_data[sample(x = 1:nrow(prepared_data), n, replace = FALSE ), c("x", "y", "dochod_bud_pra")]
  coordinates(dochody_sample) <- ~x + y
  proj4string(dochody_sample) <- "+proj=longlat +ellps=WGS84 +units=m"  
  wsp <- coordinates(dochody_sample)
  kor_mor <- pgirmess::correlog(coords = wsp, z = dochody_sample$dochod_bud_pra, method = "Moran")
  assign(paste0("kor_mor","_",n), kor_mor)
  save(list = paste0("kor_mor","_",n), file = paste0("kor_mor","_",n,".Rdata"))
  print(paste(i, " iteration"))
  i <- i + 1
}




wsp <- coordinates(dochody_sample)
kor_n6k <- pgirmess::correlog(coords = wsp, z = dochody_sample$dochod_bud_pra, method = "Moran", nbclass = 40)




