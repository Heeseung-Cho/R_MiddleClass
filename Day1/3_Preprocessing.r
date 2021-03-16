head(iris)

iris[iris$Species == 'setosa',]   #setosa종 iris만 추출
iris[iris$Sepal.Length <= 5.0,]   #Sepal.Length가 5.0보다 작은 iris 추출
iris[iris$Species == 'setosa' & iris$Sepal.Length <= 5.0,]  #위 두 조건을 모두 만족

#Cars93 Dataset
install.packages("MASS")
library(MASS)
anyNA(Cars93)           #해당 데이터프레임에 NA가 있는지?: TRUE
is.na(Cars93)           #각 값들이 NA인지 확인
sum(is.na(Cars93))      #NA의 개수 파악 : 13

Cars93[is.na(Cars93$Luggage.room),c(1,2,3,24,25)]
na.omit(Cars93)


