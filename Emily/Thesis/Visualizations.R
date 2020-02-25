library(readr)
library(dplyr)
library(ggplot2)
library(echarts4r)
library(tidyr)
library(usmap)
library(jsonlite)
library(lubridate)

#load data sets
df_raw <- read_csv("full_sentiment_data.csv")
regions <- read_csv("states.csv")


##########df Tweet data ##############################
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
  mutate(tweets_per_case = tweet_count/`2018Prevalence`)

####################by State#########################################
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

plot_usmap(data = df_state_chart, values = "negative_total")+labs(title = "Total Negative by State")
plot_usmap(data = df_state_chart, values = "positive_total")+labs(title = "Total Positive by State")
plot_usmap(data = df_state_chart, values = "net_total")+labs(title = "Net Positive by State")

json <- read_json("https://s3-us-west-2.amazonaws.com/s.cdpn.io/95368/USA_geo.json")

#interactive map
df_state_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(net_total, map = "USA") %>% 
  e_visual_map(net_total)%>%
  e_title(text = "Net Positive Sentiment by State", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()



####################by Region#########################################
df_region_data<-df_raw%>%
  left_join(regions, by=c("ST"="State Code"))%>%
  filter(!is.na(Region))%>%
  group_by(Region)%>%
  mutate(positive_total = sum(positive)
         , negative_total = sum(negative)
         , net_total = sum(positive) - sum(negative)
         )%>%
  select(Region
         , positive_total
         , negative_total
         , net_total)



df_region_chart<-regions%>%
                left_join(df_region_data, by = "Region")%>%
                mutate(state = State)%>%
                unique()

plot_usmap(data = df_region_chart, values = "negative_total")+labs(title = "Total Negative by Region")
plot_usmap(data = df_region_chart, values = "positive_total")+labs(title = "Total Positive by Region")
plot_usmap(data = df_region_chart, values = "net_total")+labs(title = "Net Positive by Region")


df_region_chart[is.na(df_region_chart)] <- 0 

#interactive map
df_region_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(net_total, map = "USA") %>% 
  e_visual_map(net_total)%>%
  e_title(text = "Net Positive Sentiment by Region", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()



####################by Year#########################################
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
  e_title(text = "Positive/Negative by Year Against US Prevalence", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_grid(top = "60")%>%
  e_legend(show = FALSE) %>%
  e_y_axis(index = 1, min = -50000, max = 60000, show = FALSE) %>%
  e_tooltip()
  

####################CDC Numbmers Charts#########################################

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

chartdf <- full_cdc %>%
  select(state = State, values = '2018Prevalence') 

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


###################Tweet Count####################################

df_chart[is.na(df_chart)] <- 0

df_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(tweets_per_case, map = "USA") %>% 
  e_visual_map(tweets_per_case)%>%
  e_title(text = "Tweets per 2018 Case", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()


###################tweets per state##################
df_chart[is.na(df_chart)] <- 0

df_chart %>%
  e_charts(state) %>%
  e_map_register("USA", json) %>%
  e_map(tweet_count, map = "USA") %>% 
  e_visual_map(tweet_count)%>%
  e_title(text = "Total Tweets per State", subtext = "Tweet Data based on Chronic Lyme Disease")%>%
  e_tooltip()



####################Radar Chart#########################################
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



####################Radar Region Chart#########################################
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

