##install.packages('e1071')
library(e1071)
library(dplyr)
library(ggplot2)

### Support Vector Machine 
## 1. Make example data
set.seed(43)
x=matrix(rnorm(200*2), ncol=2)
x[1:100,]=x[1:100,]+2
x[101:150,]=x[101:150,]-2
y=c(rep(1,150),rep(2,50))
dat=data.frame(x=x,y=as.factor(y))
plot(x, col=y)

# Preprocessing, split train:test = 7:3
train=sample(1:nrow(x),nrow(x)*.7)

## 2.Model
svmfit=svm(y~., data=dat[train,], kernel="radial",  gamma=1, cost=1)
# Check Cost and support vector:
summary(svmfit)

# X: support vectors, remaining observations as zeros
svmfit$index
# Check SVM's non-linear boundary
plot(svmfit, dat[train,])


# Change parameter : Cost
# As larger the cost, smaller # of support vectors
svmfit=svm(y~., data=dat[train,], kernel="radial",gamma=1,cost=1e4)
plot(svmfit,dat[train,])
summary(svmfit)

# Change parameter : Gamma
# As larger the gamma, larger # of support vectors
svmfit=svm(y~., data=dat[train,], kernel="radial",gamma=10,cost=1)
plot(svmfit,dat[train,])
summary(svmfit)

# 3. Tuning: use tune() to perform cross validation
set.seed(43)
tune.out=tune(svm, y~., data=dat[train,], kernel="radial",
              ranges=list(cost=c(0.1,1,10,100,1000)))
summary(tune.out)

## Check the best model
bestmod = tune.out$best.model
summary(bestmod)

## 4. Evaluate
newdata=dat[-train,]
ypred = predict(bestmod,newdata)

conf_mat = table(truth = newdata$y, predict = ypred)
accuracy = (conf_mat[1,1]+conf_mat[2,2])/sum(conf_mat)


### iris Data, Multi Class

# Preprocessing
set.seed(43)
train_idx = sample(1:nrow(iris), nrow(iris)*.7)
IRIS = iris[train_idx,]

# SVM linear Code = SVC
svmfit_linear = svm(Species ~ ., data = IRIS, 
                    kernel = 'linear', cost = 0.1, gamma = 0.5)
summary(svmfit_linear)
plot(svmfit_linear, data=IRIS,
     Petal.Width~Petal.Length,
     slice = list(Sepal.Width=3, Sepal.Length=4) 
)

# SVM radial Code
svmfit_radial = svm(Species ~ ., data = IRIS, 
                    kernel = 'radial', cost = 0.1, gamma = 0.5)
summary(svmfit_radial)
plot(svmfit_radial, data=IRIS,
     Petal.Width~Petal.Length,
     slice = list(Sepal.Width=3, Sepal.Length=4) 
)

# SVM polynomial Code
svmfit_poly = svm(Species ~ ., data = IRIS, 
                   kernel = 'poly', cost = 0.1, gamma = 0.5)
summary(svmfit_poly)
plot(svmfit_poly, data=IRIS,
     Petal.Width~Petal.Length,
     slice = list(Sepal.Width=3, Sepal.Length=4) 
)

## Choose your model!
my_model = ??  #linear or poly or radial

## Tune your model, and evaluate!
set.seed(43)
tune.out=tune(svm, Species ~ ., data = IRIS,  kernel=my_model,
              ranges=list(cost=c(0.1,1,10,100,1000), gamma = c(0.5,1,2,3,4)))
bestmod = tune.out$best.model

IRIS_test =iris[-train_idx,]
ypred = predict(bestmod,IRIS_test)

conf_mat = table(truth = IRIS_test$Species, predict = ypred)
accuracy = (conf_mat[1,1]+conf_mat[2,2]+conf_mat[3,3])/sum(conf_mat)
accuracy


# SVR: Support Vector Machine Regression
svmfit_reg = svm(Petal.Length ~ Sepal.Length + Sepal.Length, data = IRIS, 
                    kernel = 'linear', cost = 0.1, gamma = 0.5)
summary(svmfit_reg)

ypred = predict(svmfit_reg,IRIS_test)
rsq <- function (x, y) cor(x, y) ^ 2
rsq(IRIS_test$Petal.Length,ypred)




####################################
#### Plotting, Not lecture Note ####
####################################

# Affine Plane
IRIS = iris %>% filter(Species != 'setosa')
IRIS

summary(IRIS)
curve = function(x,a,b){
  return(a*x+b)
}
ggplot(IRIS, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point()+ theme(text = element_text(size=20)) +
 stat_function(fun = curve, size = 1,args=list(a = 0.8, b = 0), color = 'black', lty = 1) +
 stat_function(fun = curve, size = 1,args=list(a = 0.5, b = 2), color = 'grey', lty = 2) +
 stat_function(fun = curve, size = 1,args=list(a = 1, b = -1.5), color = 'red', lty = 3) +
 xlim(c(4.9,7.9)) + ylim(c(3.0,6.9)) + ggtitle("Affine Plane")

# Maximum Margin classifier 
ggplot(IRIS, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point()+ theme(text = element_text(size=20)) +
  stat_function(fun = curve, size = 1,args=list(a = 0.8, b = 0), color = 'black') +
  stat_function(fun = curve, size = 1,args=list(a = 0.8, b = 0.1), color = 'black', lty = 2) +
  stat_function(fun = curve, size = 1,args=list(a = 0.8, b = -0.1), color = 'black', lty = 2) +
  ggtitle("C = 0.1")
