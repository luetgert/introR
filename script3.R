#Tidyverse collects ggplot2, dplyr, tidyr and more essentials for cleaning, processing and visualizing


library(tidyverse)
interviews<-read_csv("SAFI_clean.csv", na="NULL")

interviews #quick preview in output
View(interviews) #opens in extra browser window
dim(interviews) #yields dimensions
nrow(interviews) #number of rows
ncol(interviews) #number of columns
head(interviews) #look at first six
tail(interviews) #last six rows
names(interviews)#column names

str(interviews)#name of column, type of column and look at first few values
class(interviews)
summary(interviews)#summary stats for each variable
interviews$no_membrs #vector of number of members(any column selected)
no_rooms<-interviews$rooms
interviews[2] #gives the column data
interviews[2,]#rows
interviews[,2]#column [3:5,1]would mean rows 3-5 in col 1, this is subsetting

#now switch to dplyr
#verb(dataframe,parameters,...) will return a dataframe

select(interviews,village,no_membrs,years_liv)#pulled three vars from df

filter(interviews,village=="God")

#pipe feature in dplyr data %>% do this
#pipes are features unique to R and take the output of one function and send it directly to the next
#pipes can be made using shift+M on a PC or CMD+Shift+M on a Mac %>% 
interviews %>%
  filter(village=="God") %>%
  select(village, no_membrs,years_liv)

interviews %>%
  filter(memb_assoc=="yes") %>%
  select(memb_assoc,affect_conflicts,liv_count,no_meals)

interviews %>%
  filter(memb_assoc=="yes") %>%
  mutate(people_per_room=no_membrs/rooms)%>%
  select(people_per_room, everything())

interviews %>%
  mutate(total_meals=no_membrs*no_meals)%>%
  filter(total_meals>20)%>%
  select(total_meals, no_membrs,no_meals,everything())%>%
  select(village, total_meals)
  
#second alternative
interviews %>%
  mutate(total_meals=no_membrs*no_meals)%>%
  select(village, total_meals)%>%
  filter(total_meals>20)

interviews %>%
  group_by(village)%>%
  summarize(mean(no_membrs))
 
  
#could add a second group to group by
interviews %>%
  filter(!is.na(memb_assoc))%>% #this will throw out the observations where memb_assoc+. for analysis
  group_by(village, memb_assoc)%>%
  summarize(mean(no_membrs),
            min_membrs=min(no_membrs),
            count=n()) %>%
  arrange(desc(min_membrs))

interviews%>%
  count(no_meals)

interviews %>%
  group_by(village)%>%
  summarize(mean_membrs=mean(no_meals),
            min_meals=min(no_meals),
            max_meals=max(no_meals),
            count=n()) %>%
  arrange(desc(mean_membrs))

#make three new variables based on interview date, load library first
library(lubridate)
interviews_month<-interviews%>%
  mutate(year=year(interview_date),
         month=month(interview_date),
         day=day(interview_date))

interviews_month %>%
  group_by(month)%>%
  summarize(max_membrs=max(no_membrs),
            count=n()) %>%
  arrange(desc(max_membrs))


#tidyr will pivot tables, we are transposing and including values first Booleans and later values
interviews_wide <-interviews%>%
  mutate(has_wall_type=TRUE)%>%
  #select(respondent_wall_type, has_wall_type,everyything())
  pivot_wider(names_from=respondent_wall_type,
              values_from = has_wall_type,
              values_fill = list(has_wall_type=FALSE))

interviews%>%
  pivot_wider(names_from=respondent_wall_type,
              values_from=no_membrs)%>%
  View()


interviews_wide %>%
  pivot_longer(muddaub:cement,
               names_to="respondent_wall_type",
               values_to="has_wall_type")%>%
  filter(has_wall_type==TRUE)%>% #could drop ==TRUE
  select(-has_wall_type)%>%
View()


interviews_items_owned<-interviews%>%
  separate_rows(items_owned, sep=";")%>%
  mutate(items_owned_logical=TRUE)%>%
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical=FALSE))

interviews_items_owned<-interviews_items_owned%>%
  rename(no_listed_items='NA')
           
interviews_items_owned%>%
  filter(bicycle)%>%
  group_by(village)%>%
  count(bicycle)

interviews_plotting <- interviews %>%
  ## pivot data by items_owned
  separate_rows(items_owned, sep=";") %>%
  mutate(items_owned_logical = TRUE) %>%
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical=FALSE)) %>%
  rename(no_listed_items = `NA`) %>%
  ## pivot data by months_lack_food
  separate_rows(months_lack_food, sep=";") %>%
  mutate(months_lack_food_logical = TRUE) %>%
  pivot_wider(names_from = months_lack_food,
              values_from = months_lack_food_logical,
              values_fill = list(months_lack_food_logical = FALSE)) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Apr:Sept))) %>%
  mutate(number_items = rowSums(select(., bicycle:television)))

write_csv(interviews_plotting,path="interviews_plotting.csv")








