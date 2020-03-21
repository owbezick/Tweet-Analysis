# Read in data frame
source("libraries.R")
source("helperFunctions.R")

# Nike Black Lives Matter Baseline ----

# Get Dataframe
blackLivesMatter <- fromJSON("Nike/baselineTweets/blackLivesMatter.JSON")

# Build Heatmap
blackLivesMatterHeatmap <- calendarHeatmap(blackLivesMatter)

# Find Most Popular/ Engaging Tweets
blackLivesMatterTop50Retweets <- top_50_retweets(blackLivesMatter)
blackLivesMatterTop50Likes <- top_50_likes(blackLivesMatter)

# Sentiment Direction Bar Chart
likesBar <- sentimentDirectionBar(blackLivesMatterTop50Likes, 'Top 50 Most Liked Tweets - Black Lives Matter')
retweetsBar <- sentimentDirectionBar(blackLivesMatterTop50Retweets, 'Top 50 Most Retweeted Tweets - Black Lives Matter')

# Word Cloud
# Most used hashtags

# Time series of average sentiment for the day over those two weeks