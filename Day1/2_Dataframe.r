## 1. Data Frame Basic
gender = rep(factor(c('M','F')),6)
employ = rep(c('Student', 'Employee','JobSeeker'), 4)
age = c(21,28,26,23,31,23,23,32,27,25,26,25)
score = c(90, 80, 85, 75, 95, 100, 70, 90, 85, 100, 65, 85)

Test = data.frame(GENDER = gender, EMP = employ, AGE = age, SCORE = score)

print(Test)


##Print Data Frame
summary(Test)
str(Test)
attributes(Test)
attr(Test,'names')

head(Test)          #위에서부터 5개의 행
tail(Test,6)        #아래에서부터 6개의 행
Test[1]             #첫번째 열
Test[c(2,4)]        #2,4번쟤 열
Test$GENDER         #GENDER 열 백터출력
Test$SCORE          #SCORE열 백터출력
Test[["AGE"]]       #AGE 열 백터출력
Test[1,]            #첫번째 행
Test[3,2]           #세번째 행, 두번째 열
Test[c(5,7),c(1,3)] #5,7번째 행, 1,3번째열
Test[1:10,2:3]      #1~10행, 2~3 열

## 2.Load Data Frame
load_data = read.csv("example_data.csv", header=TRUE)
head(load_data)

## 3. Save Data Frame
if(!dir.exists("save_data")){  ## 해당 폴더가 없으면 폴더 생성
  dir.create("save_data")
}
write.csv(Test, 'save_data/mydata.csv')
write.table(Test, 'save_data/mydata.txt', sep = "\t")
