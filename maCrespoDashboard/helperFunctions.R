# Helper Functions
# Process Raw Data
processData <- function(df) {
  distinct_tweet_id <- distinct(df, tweet_id, .keep_all = TRUE)
  
  processedDF <- distinct_tweet_id %>%
    mutate(timestamp = as.Date(timestamp), tweet_id) %>%
    select(tweet_id, timestamp, hashtags, likes, replies, retweets, user_id, text)
  
  # Get Sentiment
  df_w_sentiment <- getTweetSentiment(processedDF)
  return(df_w_sentiment)
}

getTweetSentiment <- function(df) {
  # Get only unique tweet texts and pull into a list
  unique_tweet_texts <- df %>% 
    distinct(text) 
  
  unique_tweet_id <- df %>% 
    distinct(tweet_id) 
  
  ls_unique_tweets <- unique_tweet_texts %>% pull()
  
  # Pull sentiment data from tweets
  sentiment <- get_nrc_sentiment(ls_unique_tweets)
  
  # Merge the dataframes by row
  tweet_id_and_sentiment <- merge(sentiment, unique_tweet_id, by = 0)
  
  sentimet_tweet_df <- merge(tweet_id_and_sentiment, df, by ="tweet_id")
}

timeSeries <- function(df, title, date){
  df <- df %>%
    group_by(timestamp) %>%
    summarise(positive = sum(positive)
              , negative = sum(negative)) 
  df %>%
    e_chart(timestamp) %>%
    e_line(positive, color = "green") %>%
    e_line(negative, color = "red") %>%
    e_title(title) %>%
    e_axis_labels(x = "Date", y = "Number of Tweets") %>%
    e_mark_line(data = list(xAxis = as.Date(date)), title = "Release Date") %>% 
    e_tooltip(trigger = c("axis"))
}

# Emotion Dataframes
get_anger <- function(df){
  df %>%
    filter(anger > 0)
}

get_disgust <- function(df) {
  df %>%
    filter(disgust > 0)
}

get_fear <- function(df){
  df %>%
    filter(fear > 0)
}

get_sadness <- function(df){
  df %>%
    filter(sadness > 0)
}

get_anticipation <- function(df){
  df %>%
    filter(anticipation > 0)
}

get_joy <- function(df) {
  df %>%
    filter(joy > 0)
}

get_surprise <- function(df) {
  df %>%
    filter(surprise > 0)
}

get_trust <- function(df) {
  df %>%
    filter(trust > 0)
}

get_positive <- function(df) {
  df %>%
    filter(positive > 0)
}

get_negative <- function(df) {
  df %>%
    filter(negative > 0)
}
# Top n retweets ----
top_n_retweets <- function(df,n){
  df %>%
    arrange(desc(retweets)) %>%
    select(tweet_id, user_id, retweets, text) %>%
    filter(retweets >0) %>%
    head(n=n)
}
sentimentBar <- function(df, title){
  df %>%
    e_chart(chart) %>%
    e_bar("anger", name = "Anger") %>%
    e_bar("disgust", name = "Disgust") %>%
    e_bar("fear", name = "Fear") %>%
    e_bar("sadness", name = "Sadness") %>%
    e_bar("anticipation", name= "Anticipation") %>%
    e_bar("joy", name = "Joy") %>%
    e_bar("surprise", name = "Surprise") %>%
    e_bar("trust", name = "Trust") %>%
    e_bar("negative", name = "Negative") %>%
    e_bar("positive", name = "Positive") %>%
    e_axis_labels(x = "Emotion", y = "Number of Tweets") %>%
    e_title(title) %>%
    e_legend(bottom = 0) %>%
    e_tooltip()
}
#++++++++++++++++++++++++++++++++++
# rquery.wordcloud() : Word cloud generator
# - http://www.sthda.com
#+++++++++++++++++++++++++++++++++++
# x : character string (plain text, web url, txt file path)
# type : specify whether x is a plain text, a web page url or a file path
# lang : the language of the text
# excludeWords : a vector of words to exclude from the text
# textStemming : reduces words to their root form
# colorPalette : the name of color palette taken from RColorBrewer package, 
# or a color name, or a color code
# min.freq : words with frequency below min.freq will not be plotted
# max.words : Maximum number of words to be plotted. least frequent terms dropped
# value returned by the function : a list(tdm, freqTable)
rquery.wordcloud <- function(x, type=c("text", "url", "file"), 
                             lang="english", excludeWords=NULL, 
                             textStemming=FALSE,  colorPalette="Dark2",
                             min.freq=3, max.words=200)
{ 
  if(type[1]=="file") text <- readLines(x)
  else if(type[1]=="url") text <- html_to_text(x)
  else if(type[1]=="text") text <- x
  # Load the text as a corpus
  docs <- Corpus(VectorSource(text))
  # Convert the text to lower case
  docs <- tm_map(docs, content_transformer(tolower))
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  # Remove stopwords for the language 
  docs <- tm_map(docs, removeWords, stopwords(lang))
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  # Remove your own stopwords
  if(!is.null(excludeWords)) 
    docs <- tm_map(docs, removeWords, excludeWords) 
  # Text stemming
  if(textStemming) docs <- tm_map(docs, stemDocument)
  # Create term-document matrix
  tdm <- TermDocumentMatrix(docs)
  m <- as.matrix(tdm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  # check the color palette name 
  if(!colorPalette %in% rownames(brewer.pal.info)) colors = colorPalette
  else colors = brewer.pal(8, colorPalette) 
  # Plot the word cloud
  set.seed(1234)
  wordcloud(d$word,d$freq, min.freq=min.freq, max.words=max.words,
            random.order=FALSE, rot.per=0.35, 
            use.r.layout=FALSE, colors=colors)
  
  invisible(list(tdm=tdm, freqTable = d))
}
