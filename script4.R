library(tidyverse)

interviews_plotting<-read.csv("interviews_plotting.csv")

ggplot(interviews_plotting, aes(x=no_membrs, y=number_items))+
  geom_point()

base_plot<-ggplot(interviews_plotting, aes(x=no_membrs, y=number_items))

#changing the opacity
base_plot+
  geom_point(alpha=0.5)

#jitter is adding random noise, colors can also be added
base_plot+
  geom_jitter(alpha=0.5, color='blue')

#could add color as a dimension
ggplot(interviews_plotting, aes(x=no_membrs, y=number_items, color=village))+
  geom_jitter(alpha=0.5)

ggplot(interviews_plotting, aes(x=respondent_wall_type, y=rooms))+
  geom_boxplot()+
  geom_jitter(alpha=0.5, color='tomato')

ggplot(interviews_plotting, aes(x=respondent_wall_type, y=rooms))+
  geom_violin()

#mapping in the first line will be universal, when in the following lines then specific to that overlay
ggplot(interviews_plotting, aes(x=respondent_wall_type, y=liv_count,))+
  geom_boxplot()+
  geom_jitter(aes(alpha=0.5, color=memb_assoc))

#bar plots don't require the y definition because the default is count
#forcats is a package that is useful for ordering variables
#dodge will take the plots and spread them out next to eachother
ggplot(interviews_plotting, aes(x=respondent_wall_type))+
  geom_bar(aes(fill=village), position='dodge')

ggplot(interviews_plotting, aes(x=respondent_wall_type))+
  geom_bar(aes(fill=village), position='dodge')

percent_wall_type<-interviews_plotting%>%
  filter (respondent_wall_type!="cement")%>%
  count(village,respondent_wall_type)%>%
  group_by(village)%>%
  mutate(percent=n/sum(n))%>%
  ungroup()

View(percent_wall_type) 

#stat line is necessary to override the default of building a count variable, use the y
ggplot(percent_wall_type, aes(x=village, y=percent, fill=respondent_wall_type))+
  geom_bar(stat='identity',position='dodge')
  labs(title="Proportion of Wall Type by Village",
       x="Village",
       y="Percent")


respondents_village<-interviews_plotting%>%
  filter (!is.na(memb_assoc))%>%
  count(village,memb_assoc)%>%
  group_by(village)%>%
  mutate(percent=n/sum(n))%>%
  ungroup()

View(respondents_village) 

ggplot(respondents_village, aes(x=village, y=percent, fill=memb_assoc))+
  geom_bar(stat='identity',position='dodge')


#Code has been copied and reinserted from above
percent_wall_type<-interviews_plotting%>%
  filter (respondent_wall_type!="cement")%>%
  count(village,respondent_wall_type)%>%
  group_by(village)%>%
  mutate(percent=n/sum(n))%>%
  ungroup()

View(percent_wall_type) 

#stat line is necessary to override the default of building a count variable, use the y
ggplot(percent_wall_type, aes(x=village, y=percent, fill=respondent_wall_type))+
  geom_bar(stat='identity',position='dodge')+
  labs(title="Proportion of Wall Type by Village",
      x="Village",
      y="Percent",
      fill="Respondent Wall Type")

#we can reverse the order of the facet_wrap(village~.)
ggplot(percent_wall_type, aes(x=respondent_wall_type, y=percent))+
  geom_bar(stat='identity',position='dodge')+
  facet_wrap(~village)+
  theme_minimal()
  
#we could use theme_set(theme_minimal()) to change the default for the session





