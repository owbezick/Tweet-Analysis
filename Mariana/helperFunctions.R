source("libraries.R")

# Calendar Heatmap ----
calendarHeatmap <- function(df){
  df <-blackLivesMatter
  # Manipulate data
  df_dates_tweets <- df %>%
    mutate(date = as.Date(timestamp), count = 1) %>%
    group_by(date) %>%
    summarise(total = sum(count))
  
  max <- max(df_dates_tweets$total)
  min_date <- format(min(df_dates_tweets$date), "%Y-%m")
  max_date <- format(seq(as.Date(max(df_dates_tweets$date)), by = "month", length = 2)[2], "%Y-%m") #adding one month
  
  # Make Heatmap
  df_dates_tweets %>% 
    e_charts(date) %>% 
    e_calendar(range = c(min_date, max_date)) %>% 
    e_heatmap(total, coord_system = "calendar") %>% 
    e_visual_map(max = max) %>% 
    e_title("Calendar", "Test")
}

# Top 50 retweets ----
top_50_retweets <- function(df){
  df %>%
    arrange(desc(retweets)) %>%
    select(tweet_id, user_id, retweets, text) %>%
    head(n=50)
}

# Top 50 Likes ----
top_50_likes <- function(df){
  df %>%
    arrange(desc(likes)) %>%
    select(tweet_id, user_id, likes, text) %>%
    head(n=50)
}

# Sentiment Direction Bar Graph ----
sentimentDirectionBar <- function(df, title){
  df <- df
  # Perform Sentiment Analysis on Top 50 Liked Tweets
  text <- df$text
  sentiment <- analyzeSentiment(text)
  # Extract dictionary-based sentiment according to the QDAP dictionary
  dicBasedSentiment <- sentiment$SentimentQDAP
  # Sentiment direction (i.e. positive, neutral and negative)
  direction <- convertToDirection(dicBasedSentiment)
  # Convert to Data Frame
  df_direction <- as.data.frame(direction) %>% group_by(direction)
  # Get Tally
  directionTally <- tally(df_direction) %>% mutate(Count = n)
  # Create Bar Chart Based on Tally 
  sentimentBar <- directionTally %>%
    e_charts(direction) %>%
    e_bar(Count, legend = F) %>%
    e_title(title) %>%
    e_x_axis(name = "Sentiment Direction", nameLocation = "center",nameTextStyle = list(padding = 10)) %>%
    e_y_axis(name = " Count of Tweets") %>%
    e_tooltip()
}





