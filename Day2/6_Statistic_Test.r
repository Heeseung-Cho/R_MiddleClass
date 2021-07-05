data('iris')

### Confidence Interval
sample.mean = mean(iris$Sepal.Length)     # 평균
sample.n = length(iris$Sepal.Length)      # 표본수
sample.sd = sd(iris$Sepal.Length)         # 분산

alpha = 0.05
degrees.freedom = sample.n - 1            # 자유도
score = qnorm(p=1-alpha/2)                # 신뢰상수, 95%=1.96

margin.error = (score * sample.sd)/sample.n
lower.bound = sample.mean - margin.error
upper.bound = sample.mean + margin.error
print(c(lower.bound,upper.bound))

#Short cut
ci_Sepal.Length = lm(Sepal.Length~1, data= iris)
confint(ci_Sepal.Length, level = 0.95)   #이때는 t분포를 따름

### t-test
## equal
mean(iris$Sepal.Length)
t.test(iris$Sepal.Length, alternative = "two.sided", mu = 5.5, conf.level = 0.95)

# 그림으로 확인해보자.
dt_twoside = function(x, df, ci) {
  y = dt(x, df = df) 
  z = qt(1 - ci/2, df = df)
  y[x < -z | x > z] <- NA  # 이 범위에는 색깔 없음
  return(y)
}
ggplot(data.frame(x=c(-6,6)), aes(x=x)) +
  stat_function(fun=dt, args=list(df=149), size=2) +
  ggtitle("t-Distribution of df=149") +
  stat_function(fun=dt_twoside, args=list(df = 149, ci=0.05), geom="area", fill="grey", alpha=0.5) +
  geom_vline(xintercept = 5.078, lty = 2) +
  geom_text(x=5.078, y=0.1, label="t-value \n = 5.078", size = 5) + 
  geom_text(x=0, y=0.2, label="95%", size = 10) +
  theme(text = element_text(size=20))

# greater/less than
t.test(iris$Sepal.Length, alternative = "greater", mu = 5.5, conf.level = 0.95)

# 그림으로 확인해보자.
dt_oneside = function(x, df, ci) {
  y = dt(x, df = df) 
  z = qt(1 - ci, df = df)
  y[x > z] <- NA  # 이 범위에는 색깔 없음
  return(y)
}
ggplot(data.frame(x=c(-6,6)), aes(x=x)) +
  stat_function(fun=dt, args=list(df=149), size=2) +
  ggtitle("t-Distribution of df=149") +
  stat_function(fun=dt_twoside, args=list(df = 149, ci=0.05), geom="area", fill="grey", alpha=0.5) +
  geom_vline(xintercept = 5.078, lty = 2) +
  geom_text(x=5.078, y=0.1, label="t-value \n = 5.078", size = 5) + 
  geom_text(x=0, y=0.2, label="95%", size = 10) +
  theme(text = element_text(size=20))


### paired t-test
iris_2group = iris[iris$Species != 'versicolor',]
t.test(Sepal.Length~Species, data = iris_2group, paired = T)

### unpaired t-test
iris_setosa = iris
iris_setosa[iris_setosa$Species == 'versicolor',]$Species = 'virginica'
t.test(Sepal.Length~Species, data = iris_2group, paired = F)

### ANOVA
result_aov = aov(Sepal.Length ~ Species, data = iris) 
summary(result_aov)

### Chi-square Test
corr_tab = xtabs(~Sepal.Length+Petal.Length, data=iris)
chisq.test(corr_tab)

### Corr test
#Check Correlation
cor(iris$Sepal.Length,iris$Petal.Length)        #Correlation
cor(iris[,1:4])                                 #Corr Matrix
ggplot(iris, aes(Sepal.Length, Petal.Length))+  #Plotting
  geom_point()+geom_smooth(method = "lm")+
  theme(text = element_text(size=20))

#Cor.test
cor.test(iris$Sepal.Length,iris$Petal.Length)   

### F-test
var(iris[iris$Species == 'setosa','Sepal.Length'])
var(iris[iris$Species == 'virginica','Sepal.Length'])
var.test(Sepal.Length~Species, data = iris_2group)

##그림으로 알아보자.
df_oneside <- function(x, df1,df2, ci) {
  y = df(x, df1 = df1, df2 = df2) 
  z1 = qf(ci/2, df1 = df1, df2 = df2)
  z2 = qf(1 - ci/2, df1 = df1, df2 = df2)   
  y[x < z1 |x > z2] <- NA  # 이 범위에는 색깔 없음
  return(y)
}
ggplot(data.frame(x=c(0,6)), aes(x=x)) +
  stat_function(fun=df, args=list(df1=49, df2 = 49), size=2) +
  ggtitle("F-Distribution of df1=49, df2=49") +
  stat_function(fun=df_oneside, args=list(df1 = 49, df2 = 49, ci=0.05), geom="area", fill="grey", alpha=0.5) +
  geom_vline(xintercept = 0.30729, lty = 2) +
  geom_text(x=0.30729, y=0.1, label="t-value \n = 0.30729", size = 5) + 
  geom_text(x = 1.1, y=0.2, label="95%", size = 10) +
  theme(text = element_text(size=20))

