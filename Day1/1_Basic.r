#Run each line: ctrl+Enter 

##0.Before Start
x = 1
y = 2+3
x1 = 3
z = 'Hello World!'
print(x);print(y);print(z)
ls()                         #Check variables in environment
ls(pattern = "x")            #Check variables in environment which contains "x"
rm(x)                        #Remove variable
rm(list = ls())              #Remove all variable

##1. Constant
x = 5
y = 2
print(x)
print(y)
typeof(x)
is.numeric(x)

#Calculation
x+y            #Addition, 7
x-y            #Substract, 3
x*y            #Product, 10
x/y            #Division, 2.5
x%%y           #Residual, 1
x%/%y          #Quotient, 2
x^y            #Power, equal to **, 25
x == y         #Equal?, FALSE
x <= y         # x less than y, FALSE
x >= y         # x greater than y, TRUE

##2. Bool
x = TRUE        #T, a number which is not 0 can be considered as TRUE
y = FALSE       #F, 0 can be considered as TRUE
typeof(x)
is.logical(x)

#Calculate
x+y            # TRUE:1, FALSE:0
!x              # Not, FALSE
x&y            # And, FALSE
x|y            # Or, TRUE

#Tips
z = F

x&&y&&z        #AND, Stop at first FALSE(y) and will return FALSE
x||y||z        #OR, Stop at first TRUE(x) and will return TRUE

##3. Vector
X = c(4,7,2,1)
Y = c(2,5,3,7)
is.vector(X)

print(X)                          #4 7 2 1
print(Y)                          #2 5 3 7
print(length(X))                  #4
print(length(Y))                  #4
print(X[1]);print(X[2]);
print(X[3]);print(X[4]);
print(Y[2:3]); print(Y[c(2,4)]);

#Calculate,        all of these calculations are elementwise.
print(X + Y)       #6 12 5 8 
print(X - Y)       #2 2 -1 -6  
print(X * Y)       #8 35 6 7 
print(X / Y)       #2.0000000 1.4000000 0.6666667 0.1428571 
print(X^Y)         #16 16807 8 1 
print(X %% Y)      #0 2 2 1 
print(X %/% Y)     # 2 1 0 0 

print(X == Y)     #FALSE FALSE FALSE FALSE
identical(X,Y)    #FALSE
print(X >= Y)     # TRUE TRUE FALSE FALSE

#Calculating Vector and Scalar
z = 3

print(X + z)      # 7 10 5 4
print(X - z)      # 1 4 -1 -2
print(X * z)      # 12 21 6 3
print(X / z)      # 1.3333333 2.3333333 0.6666667 0.3333333
print(X^z)        # 64 343   8   1
print(X %% z)     # 1 1 2 1
print(X %/% z)    # 1 2 0 0
print(X == z)     # FALSE FALSE FALSE FALSE
print(X >= z)     # TRUE TRUE FALSE FALSE

##4. Matrix
#Generation
X = matrix(data = c(4,7,2,1), nrow = 2, ncol = 2)
Y = matrix(c(2,5,3,7), 2, 2, byrow = TRUE)
I = diag(2)
is.matrix(X)

#Print
print(X)                              # [[4 2] [7 1]]
print(Y)                              # [[2 5] [3 7]]
print(dim(X))                         # 2 2
print(dim(Y))                         # 2 2
print(X[1,1]); print(X[2,2])
print(Y[1:2,1]); print(Y[1,])
print(diag(X))                        # Print diagonal elements 


#Calculate,        all of these calculations are elementwise.
print(X + Y)       #6 12 5 8 
print(X - Y)       #2 2 -1 -6  
print(X * Y)       #8 35 6 7 
print(X / Y)       #2.0000000 1.4000000 0.6666667 0.1428571 
print(X^Y)         #16 16807 8 1 
print(X %% Y)      #0 2 2 1 
print(X %/% Y)     # 2 1 0 0 
print(X == Y)      #FALSE FALSE FALSE FALSE
identical(X,Y)     #FALSE
print(X >= Y)      # TRUE TRUE FALSE FALSE

#Matrix Calculation
X%*%Y                #Matrix Production
det(X)               #Determination
solve(X)             #Inverse Matrix
cbind(X,Y)           #Column bind
rbind(X,Y)           #Row bind
apply(X, 1, prod)
apply(Y, 2, sd)

## 5. List
List1 = list(c(1,2,3), c("x","y","z"))
List2 = list(vector = c(4,8,6), matrix = matrix(c(1,2,3,4),2), character = c("w","v"))
is.list(List1)

print(List1)
print(List2)
List1[1]        #List1의 첫번째 구성요소 반환
List1[[1]]      #List1의 첫번째 구성요소의 값 반환
List1[[1]][1]   #List1의 첫번째 구성요소값 중 첫번째 값 반환
List2[1]        #List2의 첫번째 구성요소 반환
List2[[2]]      #List2의 두번째 구성요소의 값 반환
List2$matrix    #List2의 matrix이름을 가지는 요소의 값 반환

List1$new = c("n","e","w")
List1
List1[[1]] = c(4,5,6)
List1

## 6. Array
arr1 = array(data = 1:8, dim = c(2,2,2))
arr2 = array(8:1, c(2,2,2), dimnames = list(c("row1","row2"),c("col1","col2"),c("dim1","dim2")))
is.array(arr1)


print(arr1)                           #Array1 전체 출력
print(arr2)                           #Array2 전체 출력
print(dim(arr1))                      #Array1 차원 출력
print(dim(arr2))                      #Array2 차원 출력
attr(arr1, 'dim')                     #Array1 차원 속성 출력
attr(arr2, 'dimnames')                #Array2 차원이름 속성 출력
print(arr1[,,1])                      #Array1 첫번째 dime 출력
print(arr1[2,,2])                     #Array1 두번째 dim, 두번째 row 출력
print(arr2[,,'dim2'])                 #Array2 dim2 원소 출력
print(arr2['row1','col2','dim2'])     #Array2 row1, col2, dim2 원소 출력

## 7. Factor
gender = c('Male','Female','Female','Female','Male')
gender_fac = factor(gender)
print(gender)
print(gender_fac)

grade = c('Excellent!!','Great!',"Good","So so","Oops!","Bad..")
grade_fac = factor(grade)
grade_order = factor(grade, ordered = TRUE, levels = grade)
print(grade)
print(grade_fac)
print(grade_order)


## If
x = 3

if(x>y){
  print("x is greater than y")
}

if(x>y) print("x is greater than y")

if(x>y){
  print("x is greater than y")
} else if(x<y){
  print("x is less than y")
} else{
  print("x is equal to y")
}

z=c(1,2,3,4,5)
ifelse(z%%2==0, 'even', 'odd')

## Switch
x = 3
switch(x,"하나","둘","셋","넷")

str = "R"
switch(str,
       "C++" = print("이 언어는 C++입니다."),
       "R" = print("이 언어는 R입니다."),
       "java" = print("이 언어는 java입니다."),
       print("모르는 언어입니다.")
       )


## For
x = c(1:10)
sum = 0
for(i in x){
  sum = sum + i
  print(sum)
}


## While
x = 0
y = 0
while(x<20){
  x = x+2
  y = y+10
  print(x)
}

## Repeat
x = 0
y = 0
repeat{
  x = x+2
  y = y+10
  print(x)
  if (x>20)
    break
}


## While break
x = 0
y = 0
while(x<20){
  x = x+2
  y = y+10
  print(x)
  if(y>30)
    break
}

## while next
x = 0
y = 0
while(x<20){
  x = x+2
  y = y+10
  print('x result')
  print(x)
  if(y>30)
    next
  print('y result')
  print(y)
}


## function
calculator = function(x,y){
  return(x+y)
}
result = calculator(1,2)
print(result)

printer = function(str){
  print(str)
}
printer("Hello World!")
