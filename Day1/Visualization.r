## Import library ggplot2
library(ggplot2)

head(iris)

#Plot1
plot(iris$Species)
#Plot2
plot(iris$Sepal.Length, main = 'Sepal.Length')
#Plot3
plot(iris$Species, iris$Sepal.Length, main = 'Specis VS Sep.Len', xlab = 'Specis', ylab = 'Sep.Len')
#Plot4
plot(iris$Petal.Length, iris$Sepal.Length, main = 'Pet.Len VS Sep.Len', xlab = 'Pet.Len', ylab = 'Sep.Len')

#Plot function
#Sine
plot(sin, -pi, 2*pi, main = "Sin", col = 'red')
#Cosine
plot(cos, -pi, 2*pi, main = "Cos", type = "p")
#Exponential
plot(exp, -1, 3, main = "Exp", lty = 2)
#Custom
curve = function(x){x^2}
plot(curve, -3, 3, main = "y=x^2",ylab = 'y', col = 'blue', lty = 3)

#Ploting two graph
plot(sin, -pi, 2*pi, main = "Sin VS Cos", ylab = "", type = "o")
par(new = TRUE)
plot(cos, -pi, 2*pi, ylab = "", lty = 4)
legend(4, 0.5, c("Sin", "Cos"), lty = c(1,3))
par(new = FALSE)

#Subplot
par(mfrow = c(2,2))
boxplot(iris$Sepal.Length)  #plot1
hist(iris$Sepal.Width)      #plot2
wid_mean = aggregate(Sepal.Width~Species,data = iris, mean)
barplot(Sepal.Width~Species, data = wid_mean) #plot3
pie(wid_mean$Sepal.Width,wid_mean$Species, radius = 2) #plot4
par(mfrow = c(1,1))


