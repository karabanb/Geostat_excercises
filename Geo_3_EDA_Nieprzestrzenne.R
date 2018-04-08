
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

### Statystki opisowe, podstawowe wykresy, korelacje ###

summary(punkty@data) #kwantyle
sd(punkty$temp) #odchylenie standardowe

ggplot(punkty@data, aes(temp)) + geom_histogram() #histogram

ggplot(punkty@data, aes(temp)) + geom_density() # rozklad gestosci
plot(density(punkty$temp)) #tez rozklad gestosci ale z base graphics

ggplot(punkty@data, aes(sample = temp)) + stat_qq() # wykres qqplot
qqnorm(punkty$temp) #alternatywnie z base graphics

ggplot(punkty@data, aes(temp)) + stat_ecdf() # dystrubuanta empiryczna
graphics::plot(ecdf(punkty$temp),pch = ".") #alternatywnie z base graphics

pairs.default(punkty@data, pch =".") # wykresy rozrzutu

cor_matrix <- cor(punkty@data) #macierz korelacji
cor_matrix
corrplot(cor_matrix)

cor.test(punkty$ndvi, punkty$savi) # testowanie istotnosci korelacji

punkty$clc <- as.factor(punkty$clc)
ggplot(punkty@data, aes(clc, temp)) + geom_boxplot() #klasyczny boxplot

punkty$clc <- as.factor(punkty$clc) # ANOVA sprawdzenie istotnosci roznic miedzy srednimi
aov_test <- aov(temp~clc, data = punkty)
summary(aov_test)

tukey <- TukeyHSD(aov_test, "clc")
plot(tukey) #wizualizacja ronznic z przedzialami ufnosci


