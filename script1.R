x<-5
#created variable with value 5

X<-x*2
#remember R is case sensitive

print(x)

#c,q,s,t,C,D,D,F,I,T cannot be used as variable names!
#good variable has no spaces gdp_2015 good variable 
#no start numbers

square<-function(x){
  return(x^2)
}

print(square(4))
print(x)

help(print)
help(return)

#if statements
#if(condition){
#  do something
#}

countdown<-function(from)
{
  print(from)
  while(from!=0){
    Sys.sleep(1)
    from<-from-1
    print(from)
  }
}
countdown(5)

print(head(mtcars))

#Where can I get data? Census, UN data.un.org, Kaggle.com
#Download csv files (comma separated values)

library(tidyverse)
