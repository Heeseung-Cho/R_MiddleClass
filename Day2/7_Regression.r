## 0. Import Libraries
library(ggplot2)
library(MASS)

## 1. Single-variate Linear Regression
data(cars)
ggplot(cars, aes(speed,dist))+ theme(text = element_text(size=20)) +
  geom_point()+
  geom_smooth(method="lm")

data(cars)
result1 = lm(dist ~ speed, data = cars)
summary(result1)
par(mfrow = c(2,2))
plot(result1)

## 2. Multi-variate Linear Regression
data(mtcars)
result2 = lm(disp~cyl+hp+wt, data=mtcars)
summary(result2)
par(mfrow = c(2,2))
plot(result2)

# Forward selection
step(lm(disp~1,data=mtcars),direction="forward", scope=(~cyl+hp+wt))
# Backward selection
step(lm(disp~cyl+hp+wt,data=mtcars),direction="backward")
# Mixed selection
step(lm(disp~1,data=mtcars),direction="both", scope=(~cyl+hp+wt))

## 3. Logistic Regression
data(biopsy)
str(biopsy)
prep_biopsy = na.omit(biopsy)[,-1] #Preprocessing

result3 = glm(class ~ V1+V2+V4+V6+V7, data = prep_biopsy, family = 'binomial')
summary(result3)

logit.probs = predict(result3,prep_biopsy, type = "response")
logit.pred = ifelse(logit.probs > .5, 'malignant','benign')
table(logit.pred, prep_biopsy$class)

plot(result3)

## 시각적으로 차이를 알아보자.
ggplot(data = prep_biopsy, aes(V6, logit.probs)) + theme(text = element_text(size=20)) +
  geom_point(alpha = .15) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  geom_smooth(method = "lm", color = 'red') +
  ggtitle("Linear(Red) VS Logistic regression(Blue)") +
  xlab("V6") +
  ylab("Probability of Default")
