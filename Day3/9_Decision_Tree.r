###install.packages("tree")
library(ggplot2)
library(tree)
library(MASS)
library(ISLR)


### 1. Classification Tree
library(ISLR)
library(tree)
#Preprocessing Data
set.seed(1)
carseats<-Carseats
High = factor(ifelse(carseats$Sales<=8, "No", "Yes"))
carseats = data.frame(carseats, High)
train = sample(1:nrow(carseats),nrow(carseats)*.7)

#Model
tree.carseats = tree(High~.-Sales, data=carseats, subset = train)

#Summary
names(carseats)
summary(tree.carseats)

#Plot
plot(tree.carseats)
text(tree.carseats, pretty = 0)

#교육생용 Plot
student.carseats = tree(High~CompPrice+Price, carseats, subset = train)
plot(carseats$CompPrice, carseats$Price, 
     xlab="CompPrice", ylab="Price", xlim = c(60,200))
partition.tree(student.carseats, add = T, cex = 1.5)

#Result
prob = predict(tree.carseats,carseats[-train,])
pred = ifelse(prob[,1] >= 0.5, "No", "Yes")
table(carseats[-train,"High"], pred)


### 2. Regression Tree
# Preprocessing
library(MASS)
data(Boston)
set.seed(1)
train = sample(1:nrow(Boston),nrow(Boston)*.7)
# Model
tree.boston = tree(medv~., Boston, subset = train)

#Summary
names(Boston)
summary(tree.boston)

#Plot
plot(tree.boston)
text(tree.boston, pretty = 0)

#Result
rsq <- function (x, y) cor(x, y) ^ 2
train_pred = predict(tree.boston,Boston[train,])
rsq(Boston[train,"medv"],train_pred)
test_pred = predict(tree.boston,Boston[-train,])
rsq(Boston[-train,"medv"],test_pred)

#교육생용
tree.boston = tree(medv~rm+lstat, Boston, subset = train)
plot(Boston$rm, Boston$lstat, xlab="rm", ylab="lstat")
partition.tree(tree.boston, add = T, cex = 1.5)




####################################
#### Plotting, Not lecture Note ####
####################################
### 0.Example code, partition.tree only allow 1 or 2 features
## Classification
ggplot(iris, 
       aes(Petal.Width, Sepal.Width, color=Species)) + theme(text = element_text(size=20)) + 
  geom_point() +
  gg.partition.tree(tree(Species ~ Sepal.Width + Petal.Width, data=iris), 
                    label="Species", color = "black") 

## Regression
tree.boston = tree(medv~rm+lstat, Boston, subset = train)
ggplot(Boston, 
       aes(rm, lstat, color=medv)) + theme(text = element_text(size=20)) + 
  geom_point() + 
  gg.partition.tree(tree.boston, color = "red") 


## ggplot code
gg.partition.tree <- function (tree, label = "yval", ordvars, ...) 
{
  ptXlines <- function(x, v, xrange, xcoord = NULL, ycoord = NULL, 
                       tvar, i = 1L) {
    if (v[i] == "<leaf>") {
      y1 <- (xrange[1L] + xrange[3L])/2
      y2 <- (xrange[2L] + xrange[4L])/2
      return(list(xcoord = xcoord, ycoord = c(ycoord, y1, 
                                              y2), i = i))
    }
    if (v[i] == tvar[1L]) {
      xcoord <- c(xcoord, x[i], xrange[2L], x[i], xrange[4L])
      xr <- xrange
      xr[3L] <- x[i]
      ll2 <- Recall(x, v, xr, xcoord, ycoord, tvar, i + 
                      1L)
      xr <- xrange
      xr[1L] <- x[i]
      return(Recall(x, v, xr, ll2$xcoord, ll2$ycoord, tvar, 
                    ll2$i + 1L))
    }
    else if (v[i] == tvar[2L]) {
      xcoord <- c(xcoord, xrange[1L], x[i], xrange[3L], 
                  x[i])
      xr <- xrange
      xr[4L] <- x[i]
      ll2 <- Recall(x, v, xr, xcoord, ycoord, tvar, i + 
                      1L)
      xr <- xrange
      xr[2L] <- x[i]
      return(Recall(x, v, xr, ll2$xcoord, ll2$ycoord, tvar, 
                    ll2$i + 1L))
    }
    else stop("wrong variable numbers in tree.")
  }
  if (inherits(tree, "singlenode")) 
    stop("cannot plot singlenode tree")
  if (!inherits(tree, "tree")) 
    stop("not legitimate tree")
  frame <- tree$frame
  leaves <- frame$var == "<leaf>"
  var <- unique(as.character(frame$var[!leaves]))
  if (length(var) > 2L || length(var) < 1L) 
    stop("tree can only have one or two predictors")
  nlevels <- sapply(attr(tree, "xlevels"), length)
  if (any(nlevels[var] > 0L)) 
    stop("tree can only have continuous predictors")
  x <- rep(NA, length(leaves))
  x[!leaves] <- as.double(substring(frame$splits[!leaves, "cutleft"], 
                                    2L, 100L))
  m <- model.frame(tree)
  if (length(var) == 1L) {
    x <- sort(c(range(m[[var]]), x[!leaves]))
    if (is.null(attr(tree, "ylevels"))) 
      y <- frame$yval[leaves]
    else y <- frame$yprob[, 1L]
    y <- c(y, y[length(y)])
    if (add) 
      lines(x, y, type = "s", ...)
    else {
      a <- attributes(attr(m, "terms"))
      yvar <- as.character(a$variables[1 + a$response])
      xo <- m[[yvar]]
      if (is.factor(xo)) 
        ylim <- c(0, 1)
      else ylim <- range(xo)
      plot(x, y, ylab = yvar, xlab = var, type = "s", ylim = ylim, 
           xaxs = "i", ...)
    }
    invisible(list(x = x, y = y))
  }
  else {
    if (!missing(ordvars)) {
      ind <- match(var, ordvars)
      if (any(is.na(ind))) 
        stop("unmatched names in vars")
      var <- ordvars[sort(ind)]
    }
    lab <- frame$yval[leaves]
    if (is.null(frame$yprob)) 
      lab <- format(signif(lab, 3L))
    else if (match(label, attr(tree, "ylevels"), nomatch = 0L)) 
      lab <- format(signif(frame$yprob[leaves, label], 
                           3L))
    rx <- range(m[[var[1L]]])
    rx <- rx + c(-0.025, 0.025) * diff(rx)
    rz <- range(m[[var[2L]]])
    rz <- rz + c(-0.025, 0.025) * diff(rz)
    xrange <- c(rx, rz)[c(1, 3, 2, 4)]
    xcoord <- NULL
    ycoord <- NULL
    xy <- ptXlines(x, frame$var, xrange, xcoord, ycoord, 
                   var)
    xx <- matrix(xy$xcoord, nrow = 4L)
    yy <- matrix(xy$ycoord, nrow = 2L)
    return(
      list(
        annotate(geom="segment", x=xx[1L, ], y=xx[2L, ], xend=xx[3L, ], yend=xx[4L, ]),
        annotate(geom="text", x=yy[1L, ], y=yy[2L, ], label=as.character(lab), ...)
      )
    )
  }
}
