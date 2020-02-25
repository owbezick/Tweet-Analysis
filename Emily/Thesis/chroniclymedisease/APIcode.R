#9/23/19
#Getting set up with scraping data from twitter

#install.packages("twitteR")
#installs TwitteR 
library (twitteR) 

#This will come after approved to be a twitter developer
api_key <- "V6Yq3iyPCn5scGhKXxPg0ReIC"
api_secret <- "9jAxcgnW2HwxZy7Sjf4BQsV7Y8Zxf4WmYNp9EFNmtnSoi8mCJJ"
token <- "1172177480041431040-bVfCqALmiU17hPLkDjyjTkQF0mlYgR"
token_secret <- "AziJMFFvnYt2dZia3mc5MHaowGWbUyaGba91JYJrJblGZ"

#connect to twitter to access the API
setup_twitter_oauth(api_key, api_secret, token, token_secret)

#setup own vector/list of search terms (case sensitive)
#Chronic Lyme Disease, Chronic Lyme, chronic lyme disease, 
#chronic lyme, nytimes + chronic lyme disease 

terms_before <- c("'Chronic Lyme Disease'", "'chronic lyme disease'", 
                  "#chroniclyme")

terms_after <- c("'Chronic Lyme Disease'", "'chronic lyme disease'",
                 "nytimes + 'chronic lyme disease'","#chroniclyme")

terms_search_before <- paste(terms_before, collapse = " OR ")

terms_search_after <- paste(terms_after, collapse = " OR ")

#Chronic Lyme Disease, newyorktimes.com
tweets_before <- searchTwitter(terms_search_before, n = 500, since = "2019-01-01", until = "2019-06-26", resultType = "popular")

tweets_after <- searchTwitter(terms_search_after, n = 500, since = "2019-06-27")

#Save tweets into a data frame
tweets.df_before <-twListToDF(tweets_before)

tweets.df_after <- twListToDF(tweets_after)










#Figure out how to get better location data 

#install.packages("leaflet") 
#install.packages("maps") 
library(leaflet) 
library(maps) 

#make leaflet map 
m <- leaflet(mymap) %>% addTiles()

#add circles to the base map with latitude and longitude 
m %>% addCircles(lng = ~longitude, lat = ~latitude, popup = mymap$type, weight = 8, radius = 40, color = "#fb3004", stroke = TRUE, fillOpacity = 0.8)









#jot down all the things to get from twitter
#list: scraping, api, api > 7 days, rubygems























#export into a .csv file
#write.csv(tweets.df, "C:/Users/EmilyModlin/Documents/ApptoMap/tweets.csv")

