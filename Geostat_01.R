

######################### potrzebne pakiety ###########################

pakiety <- c(
  "caret", "corrplot", "dismo", "fields", "ggplot2", "gridExtra",
  "gstat", "pgirmess", "raster", "rasterVis", "rgdal", "rgeos", "sp"
)

install.packages(pakiety)


library(devtools)

devtools::install_github("nowosad/geostatbook")


library(geostatbook)

