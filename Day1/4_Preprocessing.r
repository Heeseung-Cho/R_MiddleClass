data(iris)
head(iris)

## Filter
ind = rep(c(T,F),75)
iris[ind,]                        #홀수 행만 추출
iris[iris$Species == 'setosa',]   #setosa종 iris만 추출
iris[iris$Sepal.Length <= 5.0,]   #Sepal.Length가 5.0보다 작은 iris 추출
iris[iris$Species == 'setosa' & iris$Sepal.Length <= 5.0,]  #위 두 조건을 모두 만족

#NA, Cars93 Dataset
library(MASS)
data(Cars93)
anyNA(Cars93)           #해당 데이터프레임에 NA가 있는지?: TRUE
is.na(Cars93)           #각 값들이 NA인지 확인
sum(is.na(Cars93))      #NA의 개수 파악 : 13
Cars93[is.na(Cars93$Luggage.room),c(1,2,3,24,25)]

#Remove NA rows
na.omit(Cars93)

#Change NA elements
ind_na = which(Cars93$Luggage.room %in% c(NA))   ##NA인 index 
Cars93[ind_na,]$Luggage.room = 0                 ##NA 값을 0으로 변환
Cars93[ind_na,c(1,2,3,24,25)]

## Add columns
#One column
new_iris = iris
Sepal.mean = (new_iris$Sepal.Length + new_iris$Sepal.Width)/2
print(Sepal.mean)                 #값 확인
new_iris$Sepal.Mean = new_column  #Sepal.Mean 컬럼 추가
head(new_iris)                    

Petal.mean = (new_iris$Petal.Length + new_iris$Petal.Width)/2
new_iris['Petal.Mean'] = Petal.mean
head(new_iris)

#Several columns
new_iris = iris   ##초기화
new_data = data.frame(Sepal.Mean = Sepal.mean,
                      Petal.Mean = Petal.mean) ##Data.Frame화
new_iris = cbind(new_iris, new_data)
head(new_iris)

## Dummy Columns
install.packages("fastDummies")
library(fastDummies)
dummy_cols(iris, select_columns = 'Species')

## Outlier
library(ggplot2)
data(mpg)       ##ggplot2 data
summary(mpg$cty)
