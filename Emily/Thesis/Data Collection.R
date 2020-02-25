
library(dplyr)
library(tidyr)
library(tidyverse)
library(lubridate)

# combine all data frames
full_df <- df2016 %>%
  rbind(df2017) %>%
  rbind(df2018) %>%
  rbind(df2019)

#get rid of emojis in locations
full_df$location <- gsub("➡️", "", full_df$location)

full_df$location <- gsub("ÜT:", "", full_df$location)

full_df$location <- gsub("👎🏼", "", full_df$location)

#get rid of html code
full_df$location <- str_replace_all(full_df$location, "\n", "")

#get rid of white space
full_df$location <- str_trim(full_df$location, side = "both")

#check to see if things are working
location_list <- full_df2 %>%
  count(location)

#get rid of fake locations and "United States"
write_csv(full_df, "fulldataframe.csv")

full_df2 <- read_csv("datacatsjan30.csv")

state_abbreviation <- read_csv("State_Name_Abbrev-1.csv")


full_df$location <- str_replace_all(full_df$location, ", USA", "")

#state abbreviation (ideal)
#letter case (lower, upper, title, etc)
#nickname
#lat, long

#slashes
#zip code
#just city
#neighborhood
#city, state - set up a regex (regular expression) to find all these instances and 

#make a list of international
intl <- c("Canada", "Nova Scotia, Canada", "Norwich, England", 
          "Australia", "Dublin, Ireland", "UK", "Gibsons, British Columbia", 
          "Brighton, England", "United Kingdom", "Alberta, Canada", 
          "Ireland", "London, England", "Hertfordshire", 
          "Galway, Ireland", "Cork, Ireland", "South Africa", 
          "Algoma-Manitoulin, Canada", "France", "The Netherlands",
          "Swindon, United Kingdom", "Rio de Janeiro, Rio de Janeiro", 
          "Adelaide, Australia", "Sheffield, England", "Cyprus", 
          "Surrey", "Wormer, Netherlands", "Wareham Dorset, UK", 
          "Kingston Surrey", "Keighley, England", "Sleeper Island, Australia", 
          "England, United Kingdom", "Oxford,United Kingdom", "Ottawa, Ontario, Canada",
          "Swindon United Kingdom")

#figure out how to erase them from location column next before running the second mutation

#full_df2 <- full_df2 %>%
  #mutate(intl = case_when(location %in% intl ~ 1, is.na(location) ~ NA ,TRUE ~ 0))

full_df2 %>%
  filter(!is.na(location) & !location %in% intl)

#separate them into city and state variables

just_ST <- length(location) ==2 
just_state <- location %in% state_abbreviation$State_Name
just_state_new <- which[] #figure out which function
city_ST <- substring(location, -1, 2)
city_state <- str_split(location)


full_df2 %>%
  filter(!is.na(location) & !location %in% intl) %>%
  #mutate(ST=case_when(just_ST ~ location,
                      #just_state ~ just_state_new,
                      #city_ST %in% state_abbreviation$State_abbrev ~ city_ST,
                    
    
USlocation <- full_df2 %>%
  filter(!is.na(location) & !location %in% intl) %>%
  separate(location, c("city", "state", ", ")) %>%
  mutate(state = case_when(is.na(state) ~ city,
                           TRUE ~ state))


state_abbreviation <- read_csv("State_Name_Abbrev-1.csv")
full_df3 <- read_csv("Data_City_State.csv")
  

#need to figure out Washington DC, internation

full_df4 <- full_df3 %>%
  filter(!is.na(location) & !location %in% intl) %>%
  left_join(state_abbreviation, by = c("new_state" = "State_Name")) %>%
  mutate(ST = case_when(nchar(new_state) == 2 ~ new_state,
                          TRUE ~ State_abbrev))

df_nodates <- full_df3 %>%
  left_join(state_abbreviation, by = c("new_state" = "State_Name")) %>%
  mutate(ST = case_when(nchar(new_state) == 2 ~ new_state,
                        TRUE ~ State_abbrev))


#separate dates and times
  
colnames(df_nodates) <- c("X1", "tweetNumber", "tweetUsername", "tweetText", 
                          "tweetDate", "tweetGeo", "profile", "location", 
                          "new_city", "new_state", "State_abbrev", "ST")

FINAL_DF <- df_nodates %>%
  separate(tweetDate, c('date', 'time'), ' ')
  
FINAL_DF$date <- as.Date(FINAL_DF$date, format = "%m/%d/%y")

FINAL_DF <- FINAL_DF %>%
  mutate(Year = year(date),
         Month = month(date),
         Day = day(date))


#What Mathew did:
#library(tidyr)
#library(readr)
#library(openintro)
#datacatsjan30 <- read_csv("datacatsjan30.csv")


#states<-data.frame(state=c("California", "North Carolina"), st = c("CA", "NC"))
#location<-data.frame(location = c("Charlotte, NC", "Charlotte, North Carolina", "Napa, CA", "California", "CA"))

#split_location<-datacatsjan30%>%
  #separate(location, c("city", "state"), ", ")%>%
  #select (city, state)


#split_location<-split_location%>%
  #mutate(new_city = case_when(!is.na(state) ~ city)
         
         #, new_state = case_when(is.na(state) ~ city
                                 #, TRUE ~ state))%>%
  #select(new_city, new_state)
#write.csv(cbind(datacatsjan30,split_location), "Data_City_State.csv")

