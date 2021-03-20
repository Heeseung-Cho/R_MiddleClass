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



## ggplot2

# Import library ggplot2
library(ggplot2)

base1 = ggplot(data = iris, mapping = aes(x = Sepal.Width, y = Sepal.Length)) +
  theme(text = element_text(size=25))
#1
base1 + geom_point() + ggtitle("Scatter")            #산점도
#2
base1 + geom_line()  + ggtitle("Line")               #선 그래프
#3
base1 + geom_point() + geom_line() + ggtitle("Both") #동시에
#4
base1 + geom_point() + ggtitle("Scatter with hline") +
  geom_hline(yintercept = mean(iris$Sepal.Length)) #수평선 추가
#5
base2 = ggplot(data = iris, mapping = aes(y = Species, x = Sepal.Width))+
  theme(text = element_text(size=25))
base2 + geom_boxplot(notch = TRUE) + ggtitle("Box")  #박스 그래프
base2 + geom_violin() + ggtitle("Violin")            #바이올린 그래프
#6
base3 = ggplot(data = iris, mapping = aes(x = Petal.Length))+
  theme(text = element_text(size=25))
base3 + geom_histogram(binwidth = 1) +ggtitle("Histogram") #히스토그램                            

## Stat
#1
ggplot(data.frame(x = c(-pi,pi)), aes(x=x)) +
  stat_function(fun = sin, size = 1) + ggtitle("Sine") +
  theme(text = element_text(size=25))                      #Sine Function
#2
curve = function(x){return(x^2)}
ggplot(data.frame(x = c(-3,3)), aes(x=x)) + 
  stat_function(fun = curve, size = 1) + ggtitle("y=x^2") + 
  theme(text = element_text(size=25))                      #y=x^2 function
#3
base1 + geom_point() + stat_summary(fun = "mean", colour = "red", size = 2, geom = "point")
#4
base2 + stat_summary(aes(y = Sepal.Width), fun = "mean", geom = "bar") +
  ggtitle("Mean of Sepal.Length")
#5
base4 = ggplot(data = iris, mapping = aes(x = Sepal.Width, y = Sepal.Length , z= Petal.Width)) +
  theme(text = element_text(size=25))
base4 + stat_summary_2d() + ggtitle("Heatmap")              #Heatmap
#6
base5 = ggplot(data = iris, mapping = aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
  theme(text = element_text(size=25))
base5 + geom_point() + stat_ellipse() + ggtitle("Cluster by Species")


## Scale
install.packages("patchwork")
library(patchwork)

base1 + geom_point() + ggtitle("Remove Labels") +  #Label 제거
  xlab("") + ylab("") + theme(text = element_text(size=20))
base1 + geom_point() + ggtitle("Your Labels") +    #Labe 변경
  xlab("Width") + ylab("Length")
base1 + geom_point() + ggtitle("Limited") +        #범위 변경
  xlim(c(2.5,4.0)) + ylim(c(5,7))
base1 + geom_point(aes(alpha = Species)) + ggtitle("Alpha")+ #Species마다 진하기 변경
  base1 + geom_point(aes(alpha = Species)) + ggtitle("Alpha <0.3")+ #색상 진하기 변경
  scale_alpha_discrete(range = c(0.1,0.3))
base1 + geom_point(aes(colour = Species)) + ggtitle("Color")+
  scale_colour_hue()

## Coordinate
base1 + geom_point() + coord_cartesian() + ggtitle("Cartesian") #직교좌표계
base1 + geom_point() + coord_polar() + ggtitle("Polar")         #극좌표계
