# Libraries
library(jsonlite)
library(dplyr)
library(echarts4r)
library(lubridate)

# Calendar Heatmap Function
calendar_heatmap <- function(json_str){
  
  # Load json file as r dataframe
  df <- fromJSON(json_str)
  
  # Manipulate data
  df_dates_tweets <- df %>%
    mutate(date = as.Date(timestamp), count = 1) %>%
    group_by(date) %>%
    summarise(total = sum(count))
  
  # Make Heatmap
  df_dates_tweets %>% 
    e_charts(date) %>% 
    e_calendar(range = "2017") %>% 
    e_heatmap(total, coord_system = "calendar") %>% 
    e_visual_map(max = 1500) %>% 
    e_title("Calendar", "Test")
}

blackLivesMatterNikeHeatmap <- calendar_heatmap("blackLivesMatterNikeAugust.json")
