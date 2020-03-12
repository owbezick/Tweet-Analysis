library(tidyverse)
library(rvest)
library(dplyr)
library(tidyr)
library(lubridate)
library(tidytext)
library(tm)
library(NLP)
library(syuzhet)
library(plyr)
library(readr)
library(ggplot2)
library(echarts4r)
library(usmap)
library(jsonlite)

# Scraping Location Data ----
  # For each yearly data frame, find the profile
  # for each user that tweets and fine their location

# 2016 ----
df2016 <- read.csv("General2016.csv")
df2016 <- df2016 %>%
  select(`Tweet Number` = Tweet.Number, `Tweet Username` = Tweet.Username, `Tweet Text` = Tweet.Text
         , `Tweet Date` = Tweet.Date, `Tweet Geo` = Tweet.Geo)

df2016_profle<- df2016 %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

d = list()
for(i in 1:nrow(df2016_profle)){
  locations <- read_html(df2016_profle$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- locations
  # print(i)
  # print(d[i])
}

df2016_profle$`Tweet Geo` <- unlist(do.call(rbind, d))

# 2017 ----

df2017 <- read_csv("General2017.csv")

df2017_profile <- df2017 %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

df2017_profile <- df2017_profile[-c(75,76),] # remove user who deleted account

d = list()
for(i in 1:nrow(df2017_profile)){
  locations <- read_html(df2017_profile$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- locations
  # print(i)
  # print(d[i])
}

df2017_profile$`Tweet Geo` <- unlist(do.call(rbind, d))

# 2018 ----

df2018 <- read_csv("General2018.csv")

df2018_profile <- df2018 %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))
df2018_profile <- df2018_profile[-c(47),]
d = list()
for(i in 1:nrow(df2018_profile)){
  locations <- read_html(df2018_profile$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- locations
  # print(i)
  # print(d[i])
}

df2018_profile$`Tweet Geo` <- unlist(do.call(rbind, d))

# 2019 ----

df2019 <- read_csv("General2019.csv")

df2019_profile <- df2019 %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

df2019_profile <- df2019_profile[-c(65),]
df2019_profile <- df2019_profile[-c(178),]
d = list()
for(i in 1:nrow(df2019_profile)){
  location <- read_html(df2019_profile$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- location
  print(i)
  print(d[i])
}

df2019_profile$`Tweet Geo` <- unlist(do.call(rbind, d))

# Standardize and Row Bind Data Frames ----
full_df <- df2016_location %>%
  rbind(df2017_location) %>%
  rbind(df2018_location) %>%
  rbind(df2019_location)

# Remove non-character strings  ----
full_df$location <- gsub("➡️", "", full_df$location)

full_df$location <- gsub("ÜT:", "", full_df$location)

full_df$location <- gsub("👎🏼", "", full_df$location)

full_df$location <- str_replace_all(full_df$location, "\n", "")

full_df$location <- str_trim(full_df$location, side = "both")

# Check
location_list <- full_df %>%
  count(location)

####Get rid of fake locations
write_csv(full_df, "fulldataframe.csv")

####Note: Made some manual changes here

full_df2 <- read_csv("datacatsjan30.csv")

state_abbreviation <- read_csv("State_Name_Abbrev-1.csv")

####Matthew made Data_City_State.csv, which separated locations into city and state (code shown below)

# datacatsjan30 <- read_csv("datacatsjan30.csv")

#split_location<-datacatsjan30 %>%
        #separate(location, c("city", "state"), ", ")%>%
        #select (city, state)

#split_location<-split_location%>%
        #mutate(new_city = case_when(!is.na(state) ~ city)
        #, new_state = case_when(is.na(state) ~ city
        #, TRUE ~ state))%>%
        #select(new_city, new_state)
        #write.csv(cbind(datacatsjan30,split_location), "Data_City_State.csv")

####Using Data_City_State.csv, you can join with the state abbreviation data set to get the ST in the right format

full_df3 <- read_csv("Data_City_State.csv")

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

full_df4 <- full_df3 %>%
  filter(!is.na(location) & !location %in% intl) %>%
  left_join(state_abbreviation, by = c("new_state" = "State_Name")) %>%
  mutate(ST = case_when(nchar(new_state) == 2 ~ new_state,
                        TRUE ~ State_abbrev))

df_nodates <- full_df3 %>%
  left_join(state_abbreviation, by = c("new_state" = "State_Name")) %>%
  mutate(ST = case_when(nchar(new_state) == 2 ~ new_state,
                        TRUE ~ State_abbrev))

colnames(df_nodates) <- c("X1", "tweetNumber", "tweetUsername", "tweetText", 
                          "tweetDate", "tweetGeo", "profile", "location", 
                          "new_city", "new_state", "State_abbrev", "ST")

####separating all the dates and times

FINAL_DF2 <- df_nodates %>%
  separate(tweetDate, c('date', 'time'), ' ')

FINAL_DF2$date <- as.Date(FINAL_DF2$date, format = "%m/%d/%y")

FINAL_DF2 <- FINAL_DF2 %>%
  mutate(Year = year(date),
         Month = month(date),
         Day = day(date))




############################Sentiment Analysis#########################################

#separate tweet text from df and make everything lowercase
tweet_text <- FINAL_DF2$tweetText
tweet_text <- tolower(tweet_text)

#get sentiments for tweets
mysentiment <- get_nrc_sentiment(tweet_text)

#make sentiment analysis a data frame
mysentimentdf <- data.frame(mysentiment)

#bind the big data set with 
sentiment_raw_data <- cbind(FINAL_DF2, mysentimentdf)

FULL_DF_Sentiment <- sentiment_raw_data

####Use code to extract specific data about the tweet counts, etc... (to be used in demographics info)

#FULL_DF_Sentiment %>%
      #filter(new_state== "Ontario") %>%
      #NROW()


#FULL_DF_Sentiment %>%
      #filter(Year == 2019 & trust > 0) %>%
      #count(trust)

write.csv(FULL_DF_Sentiment, file = "full_sentiment_data.csv")



##################################Build Visualizations######################################

df_raw <- read_csv("full_sentiment_data.csv")
regions <- read_csv("states.csv")

###### Build df tweet data

#first load all CDC prevalence data found off the CDC website
CDC16 <- read_csv("Prevalence_2016.csv")
CDC16 <- CDC16 %>%
  select(ReportingArea, TotalCases)

CDC17 <- read_csv("Prevalence_2017.csv")
CDC17 <- CDC17 %>%
  select(ReportingArea, TotalCases)

CDC18 <- read_csv("Prevalence_2018.csv")
CDC18 <- CDC18 %>%
  select(ReportingArea, TotalCases)

full_cdc <- CDC16 %>%
  left_join(CDC17, by= "ReportingArea") %>%
  left_join(CDC18, by= "ReportingArea")

names(full_cdc) <- c("State", "2016Prevalence", 
                     "2017Prevalence", "2018Prevalence")

# build big data set 
df_tweetdata <- df_raw %>%
  group_by(ST) %>%
  summarize(positive_total = sum(positive)
            , negative_total = sum(negative)
            , net_total = sum(positive) - sum(negative)
            , tweet_count = n()
  )

df_chart <- regions %>%
  left_join(full_cdc, by = c("State" = "State")) %>%
  left_join(df_tweetdata, by = c("State Code" = "ST")) %>%
  rename(state = State) %>%
  mutate(tweets_per_case = tweet_count/`2018Prevalence`) %>%
  rename(`2018Prevalence` = values)

####### Visualizing net positive sentiment rates per state

df_chart<-df_raw %>%
  group_by(ST)%>%
  filter(!is.na(ST))%>%
  summarise(negative_total = sum(negative)
            , positive_total = sum(positive)
            , net_total = sum(positive) - sum(negative)
  )%>%
  select(ST
         , negative_total
         , positive_total
         , net_total)

df_state_chart<-regions%>%
  left_join(df_chart, by = c("State Code" = "ST"))%>%
  mutate(state = State)

df_state_chart[is.na(df_state_chart)] <- 0 

#plot_usmap(data = df_state_chart, values = "negative_total")+labs(title = "Total Negative by State")
#plot_usmap(data = df_state_chart, values = "positive_total")+labs(title = "Total Positive by State")
#plot_usmap(data = df_state_chart, values = "net_total")+labs(title = "Net Positive by State")

json <- read_json("https://s3-us-west-2.amazonaws.com/s.cdpn.io/95368/USA_geo.json")

#interactive map (final map)
df_state_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(net_total, map = "USA") %>% 
  e_visual_map(net_total)%>%
  e_title(text = "Net Positive Sentiment by State", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()


####### Visualizing net positive sentiment rates per region

df_region_data<-df_chart %>%
  dplyr::group_by(Region) %>%
  dplyr::summarize(net_total = sum(net_total)) 


df_region_chart<-regions%>%
  left_join(df_region_data, by = "Region")%>%
  mutate(state = State)%>%
  unique()

#plot_usmap(data = df_region_chart, values = "negative_total")+labs(title = "Total Negative by Region")
#plot_usmap(data = df_region_chart, values = "positive_total")+labs(title = "Total Positive by Region")
#plot_usmap(data = df_region_chart, values = "net_total")+labs(title = "Net Positive by Region")

#interactive map
df_region_chart[is.na(df_region_chart)] <- 0 

df_region_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(net_total, map = "USA") %>% 
  e_visual_map(net_total)%>%
  e_title(text = "Net Positive Sentiment by Region", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()


####### Visualizing CDC Prevalence Rates

chartdf2 <- df_chart %>%
  select(metric = values, state)

chartdf2[is.na(chartdf2)] <- 0

chartdf2 <- chartdf2 %>%
  select(state, metric)

chartdf2 %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(metric, map = "USA") %>% 
  e_visual_map(metric)%>%
  e_title(text = "2018 CDC Prevalence Rates by State", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()


####### Visualizing Tweet Counts per 2018 Prevalence Rates 

df_chart[is.na(df_chart)] <- 0

df_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(tweets_per_case, map = "USA") %>% 
  e_visual_map(tweets_per_case)%>%
  e_title(text = "Total Tweets per 2018 Case per State", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()


####### Visualizing Tweet Counts per State

df_chart[is.na(df_chart)] <- 0

df_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(tweet_count, map = "USA") %>% 
  e_visual_map(tweet_count)%>%
  e_title(text = "Total Tweets per State", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()


####### Visualizing Positive/Negative Sentiment in comparison with prevalence data in the US

changeovertime <- read.csv("Prevalence_US.csv")

changeovertime <- changeovertime %>%
  mutate(Year = as.numeric(as.character(Year)))

df_year<-df_raw%>%
  left_join(regions, by=c("ST" = "State Code"))%>%
  mutate(year = as.factor(year(date)))%>%
  group_by(year)%>%
  summarise(positive_total = sum(positive)
            , negative_total = sum(negative)*-1
            , net_total = sum(positive) - sum(negative)
  ) %>%
  mutate(year = as.numeric(as.character(year))) %>%
  left_join(changeovertime, by = c("year" = "Year"))

df_year%>%
  mutate(year = as.factor(year)) %>%
  e_chart(year) %>%
  e_bar(negative_total, stack = 'GRP', name = "Negative Total")%>%
  e_bar(positive_total, stack = 'GRP', name = "Positive Total")%>%
  e_line(TotalCases, y_index = 1, label = list(show = "TRUE")) %>%
  e_title(text = "Positive/Negative by Year and US Prevalence Rates", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_grid(top = "60")%>%
  e_legend(show = FALSE) %>%
  e_y_axis(index = 1, min = -50000, max = 60000, show = FALSE) %>%
  e_tooltip()


##########Radar Chart by Year

list_good<-c("positive", "joy", "surprise", "trust")
list_bad<-c("negative","anger", "disgust", "fear")

list_metrics<-c(list_good, list_bad)
list_all_columns<-c("year",list_metrics)


df_radar<-df_raw%>%
  mutate(year = as.factor(year(date)))%>%
  select(list_all_columns)%>%
  group_by(year)%>%
  summarise_all(funs(sum))%>%
  gather(metric, value, -year)%>%
  spread(year, value)%>%
  arrange(factor(metric, levels = list_metrics))

names(df_radar)<-c("Metric", "Y16", "Y17", "Y18", "Y19")
df_radar$Metric<-toupper(df_radar$Metric)

df_radar%>%
  e_chart(Metric)%>%
  e_radar(Y16, name = "2016", max = 500)%>%
  e_radar(Y17, name = "2017", max = 500)%>%
  e_radar(Y18, name = "2018", max = 500)%>%
  e_radar(Y19, name = "2019", max = 500)%>%
  e_legend()


##############Radar Chart per Region

list_all_columns_regions<-c("Region",list_metrics)


df_region_radar<-df_raw%>%
  left_join(regions, by=c("ST" = "State Code"))%>%
  select(list_all_columns_regions)%>%
  filter(!is.na(Region))%>%
  group_by(Region)%>%
  summarise_all(funs(sum))%>%
  gather(metric, value, -Region)%>%
  spread(Region, value)%>%
  arrange(factor(metric, levels = list_metrics))


df_region_radar%>%
  e_chart(metric)%>%
  e_radar(Midwest, max = 500)%>%
  e_radar(Northeast, max = 500)%>%
  e_radar(South, max = 500)%>%
  e_radar(West, max = 500)%>%
  e_legend()




