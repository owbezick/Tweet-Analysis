library(dplyr)
library(tidytext)
library(tm)
library(NLP)
library(syuzhet)
library(lubridate)
library(tidyr)
library(plyr)

#download data frame
FINAL_DF2 <- df_nodates %>%
  separate(tweetDate, c('date', 'time'), ' ')

FINAL_DF2$date <- as.Date(FINAL_DF2$date, format = "%m/%d/%y")

FINAL_DF2 <- FINAL_DF2 %>%
  mutate(Year = year(date),
         Month = month(date),
         Day = day(date))

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

# map # tweets per year across the US 
# percent positive, percent negative, percent ..... for each state (include month and year data)
# same percents per year total so as to include the tweets without location data and the international tweets
# map percents and change over time
# somehow include number of people diagnosed with lyme disease in states each year 
# draw conclusions about what diagnosis level means compared to the sentiment in each state.  Is there a
# difference over time? Is there a difference per state?

FULL_DF_Sentiment %>%
  filter(new_state== "Ontario") %>%
  NROW()


FULL_DF_Sentiment %>%
  filter(Year == 2019 & trust > 0) %>%
  count(trust)

#What's left?
#total tweets per state in general
#CDC rates -- put on positive/negative chart 
#sentiment analysis thing -- do manually
#wordcloudgenerator.com
#statistical analysis -- maybe?

#### remember that total CDC cases reflects reported + probable


write.csv(FULL_DF_Sentiment, file = "full_sentiment_data.csv")


count(sentiment_raw_data$tweetUsername)
      