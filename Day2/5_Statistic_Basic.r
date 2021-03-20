### Random Variable
sample(c(1,2,3,4,5,6),1)
sample(c(1,2,3,4,5,6),10, replace = TRUE)

mean(c(1,2,3,4,5,6))
sd(c(1,2,3,4,5,6))

### Normal distribution
pnorm(2, mean = 2, sd = 4)     #P(X<2)까지의 확률
dnorm(0, 2, 4)                 #X=0일 때 확률밀도함수 값
qnorm(0.5, 2, 4)               #p = 0.5가 되기 위한 확률변수값
plot(dnorm,-3,3, main = "Normal dist", ylab = "prob", cex.main=2, cex.axis = 2, cex.lab = 1.5)


### Chi-square distribution
pchisq(2, df = 3)             #P(X<2) 까지의 확률
dchisq(2, df = 3)             #x=2일 때 확률밀도함수 값
qchisq(0.4275933, df = 3)     #p = 0.4275933이 되기 위한 확률변수값
plot_chi = function(x){
  dchisq(x, df = 3)
}
plot(plot_chi,0,10, main = "Chi2 dist, df = 3", ylab = "prob", cex.main=2, cex.axis = 2, cex.lab = 1.5)

### t distribution
pt(0, df = 3)                 #P(X<0) 까지의 확률   
dt(0, df = 3)                 #x=0일 때 확률밀도함수 값
qt(0.5, df = 3)               #p = 0.5가 되기 위한 확률변수값
plot_t = function(x){
  dt(x, df = 3)
}
plot(plot_t,-3,3, main = "T dist, df = 3", ylab = "prob", cex.main=2, cex.axis = 2, cex.lab = 1.5)


### F distribution
pf(2, df1 = 3, df2 = 2)                 #P(X<2) 까지의 확률   
df(2, df1 = 3, df2 = 2)                 #x=2일 때 확률밀도함수 값
qf(0.6495191, df1 = 3, df2 = 2)         #p = 0.6495191가 되기 위한 확률변수값
plot_F = function(x){
  df(x, df1 = 3, df2= 2)
}
plot(plot_F,0,10, main = "F dist, df1 = 3, df2 =2 ", ylab = "prob", cex.main=2, cex.axis = 2, cex.lab = 1.5)
