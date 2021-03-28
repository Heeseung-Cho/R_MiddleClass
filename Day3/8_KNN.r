library(class)
data(iris)
set.seed(43)

## 1. Classification
# Preprocessing
summary(iris$Species)
idx = sample(1:nrow(iris), size = 100)
train = iris[idx,]
test = iris[-idx,]
X_train = train[,c(1,2,3,4)]
y_train = train[,5]
X_test = test[,c(1,2,3,4)]
y_test = test[,5]

## Training
fit = knn(train = X_train, test = X_test, cl = y_train,  k = 3)
table(y_test, fit)

## Try another K values!
fit = knn(train = X_train, test = X_test, cl = y_train,  k = 10)
table(y_test, fit)

### Caravan example
library(ISLR)
data(Caravan)
summary(Caravan$Purchase)

##Preprocessing
# Standardize
standardized.X = scale(Caravan[, -86])
idx = sample(1:nrow(Caravan), size = 1000)

# Split train, test
train.X = standardized.X[-idx,]
train.Y = Caravan$Purchase[-idx]
test.X = standardized.X[idx,]
test.Y = Caravan$Purchase[idx]

## Training
knn.pred = knn(train.X, test.X, train.Y, k = 1)
table(knn.pred ,test.Y)

## Try another K value!
knn.pred = knn(train.X, test.X, train.Y, k = 10)
table(knn.pred ,test.Y)


### 2.Regression
data(mtcars)
model = lm(disp~cyl+hp+wt, data=mtcars)
summary(model)

lm_pred = predict(model, X_test)

idx = sample(1:nrow(mtcars), size = nrow(mtcars)*.7)
train = mtcars[idx,]
test = mtcars[-idx,]
X_train = train[,c('cyl','hp','wt')]
y_train = train[,'disp']
X_test = test[,c('cyl','hp','wt')]
y_test = test[,'disp']

## Training
fit = knn(train = X_train, test = X_test, cl = y_train,  k = 15)
num_knn = as.numeric(levels(fit))
knn_ = c()
for(ele in fit){
  knn_ = append(knn_,num_knn[num_knn == ele])
}
rsq <- function (x, y) cor(x, y) ^ 2

rsq(y_test, knn_)
rsq(y_test, lm_pred)

####################################
#### Plotting, Not lecture Note ####
####################################

### Ploting
x = runif(100,0,pi)
e = rnorm(100,0,0.1)
y = sin(x)+e
grid2=data.frame(x)
knn10 = knn(x,grid2, y, k = 10)
num_knn10 = as.numeric(levels(knn10))
knn_10 = c()
for(ele in knn10){
  knn_10 = append(knn_10,num_knn10[num_knn10 == ele])
}
knn3 = knn(x,grid2, y, k = 3)
num_knn3 = as.numeric(levels(knn3))
knn_3 = c()
for(ele in knn3){
  knn_3 = append(knn_3,num_knn3[num_knn3 == ele])
}

par(mfrow = c(1,1))
plot(x,y, xlab = '', ylab = '', main = 'KNN in Regression')
ORD = order(grid2$x)
lines(grid2$x[ORD],knn_10[ORD], xlab = '', ylab = '', col = 'blue', lty = 4)
lines(grid2$x[ORD],knn_3[ORD], xlab = '', ylab = '', col = 'red', lty = 3)
legend(2.5,1.2,c("K = 10","K = 3"), lty = c(4,3), col = c('blue', 'red'))
