library(tidyverse)
load("36361-0001-Data.rda")
full_data <- da36361.0001
remove(da36361.0001)

# ALCDAYS
# ALCYRTOT
# ALCREC
# Current users is someone who has used in past 30 days
# Former users are people who have not used in past 30 days
# Never users are people who have never used

full_data <- mutate(full_data, alc_user_status = 
                      ifelse(ALCFLAG == "(0) Never used (IRALCRC = 9)", "Never User",
                             ifelse(ALCMON == "(0) Did not use in the past month (IRALCRC = 2-3,9)",
                                    "Former User", "Current User")))

full_data <- mutate(full_data, alc_30day_use = cut(ALCDAYS,c(0,10,20,30),
                                                  c("Light User","Moderate User","Heavy User")))
# Sanity checking
# tail(filter(select(full_data,mj_user_status, MRJFLAG,MRJMON,MJDAY30A,mj_30day_use),MJDAY30A>5))
# tail(select(full_data,mj_user_status, MRJFLAG,MRJMON,MJDAY30A,mj_30day_use))

full_data <- mutate(full_data, alc_user_status = ifelse(alc_user_status=="Current User",
                                                       as.character(alc_30day_use),
                                                       alc_user_status))

ggplot(full_data)+geom_bar(aes(x=alc_user_status, fill=HEALTH),position="fill")

full_data <- mutate(full_data, alc_user_status = as.factor(alc_user_status)) # mutating data so that mj_user factor version

full_data <- mutate(full_data, alc_user_status = fct_relevel(alc_user_status,
                                                            "Never User",
                                                            "Former User",
                                                            "Light User",
                                                            "Moderate User")) #organize in logical order

ggplot(full_data)+geom_bar(aes(x=alc_user_status, fill=HEALTH),position="fill")

ggplot(full_data)+
  geom_bar(aes(x=alc_user_status, fill=HEALTH),position="fill")+
  coord_flip() # flip x and y axises

ggplot(full_data)+
  geom_bar(aes(x=alc_user_status, fill=HEALTH),position="fill")+
  scale_x_discrete(labels=c("Never User","Former User","Light Current User\n(10 or fewer days per month)","Moderate Current User\n(11-20 days per month)","Heavy Current User\n(more than 20 days per month)","Not Categorized"))

ggplot(full_data)+
  geom_bar(aes(x=alc_user_status, fill=HEALTH),position="fill") + 
  coord_flip()

ggplot(full_data) + geom_bar(aes(x=alc_user_status, fill=HEALTH)) + coord_flip()

ggplot(full_data) + 
  geom_bar(aes(x=alc_user_status, fill=HEALTH),position="identity",alpha=0.5) + 
  coord_flip()

ggplot(full_data) + 
  geom_bar(aes(x=alc_user_status, fill=HEALTH),position="dodge") + 
  coord_flip() # doesn't display data as well
