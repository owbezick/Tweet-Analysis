# Libraries
library(jsonlite)
library(dplyr)

df <- fromJSON("blackLivesMatterNike.json")

popular <- df %>%
  select(likes, retweets, tweet_id)

top_50_retweets <- popular %>% 
  arrange(desc(retweets)) %>%
  select(tweet_id, retweets)