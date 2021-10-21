#Sample R code from October 21

#Generate a few variables and manipulate them
area_hectares<-2.5
area_acres<-2.47*area_hectares
area_hectares<-50 #update value of area_hectares
length<-6
width<-4
area<-length*width
b<-sqrt(25)
round(3.754,2)
?round

#Can also build more vectors of information
hh_members<-c(3,7,10,6) #create a numeric vector with 4 elements

respondent_wall_type<- c("muddaub","burntbricks","sunbricks")
length(hh_members)#gives us the number of elements in the vector
length(respondent_wall_type)
class(hh_members)
str(hh_members)

possessions<-c("bicycle","radio","televison")
possessions<-c(possessions,"mobile_phone")
str(possessions)

possessions<-c("car",possessions)
str(possessions)

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

hh_members[hh_members>5]#using a logical vector to subset our data
hh_members[hh_members>=7 | hh_members==3]
rooms<-c(2,1,1,NA,4)

mean(rooms)#will return NA
mean(rooms,na.rm=TRUE)#no we override the missing and build a mean without miss

is.na(rooms) #identify vector of missings
!is.na(rooms)#now flipped
rooms[!is.na(rooms)] #could use complete.cases


