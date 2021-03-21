### Single-variate Linear Regression
data(cars)
library(ggplot2)
ggplot(cars, aes(speed,dist))+ theme(text = element_text(size=20)) +
  geom_point()+
  geom_smooth(method="lm")

#Linear regression code
cars
result = lm(dist ~ speed, data = cars)
summary(result)

par(mfrow = c(2,2))
plot(lm(dist ~ speed, data = cars))

