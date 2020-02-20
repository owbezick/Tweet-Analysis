# Exploratory data analysis of Mariana Crespo's twitter scraping of Kendall Jenner Pepsi Ad's and Colin Kaepernick. 
#
#
#
#

library(jsonlite)
library(dplyr)
library(echarts4r)
library(lubridate)

# Load json file as r dataframe
# blackLivesMatter <- fromJSON("blackLivesMatter.json")
# pepsi_kendall <- fromJSON("pepsi_kendall.json")
oldPepsiA <- fromJSON("PepsiA.json")
oldPepsiA <- oldPepsiA %>%
  mutate(date = as.Date(timestamp), count = 1) %>%
  group_by(date) %>%
  summarise(total = sum(count))

# calendar heatmap
oldPepsiA_calendar <- oldPepsiA %>% 
  e_charts(date) %>% 
  e_calendar(range = "2017") %>% 
  e_heatmap(total, coord_system = "calendar") %>% 
  e_visual_map(max = 1500) %>% 
  e_title("Calendar", "Heatmap of old pepsiA Tweets")

# Calendar HeatMap BLM ----
blackLivesMatter_calendar <-blackLivesMatter <- blackLivesMatter %>%
            mutate(date = as.Date(timestamp), count = 1) %>%
            group_by(date) %>%
            summarise(total = sum(count))

# calendar heatmap
blackLivesMatter %>% 
  e_charts(date) %>% 
  e_calendar(range = "2017") %>% 
  e_heatmap(total, coord_system = "calendar") %>% 
  e_visual_map(max = 1500) %>% 
  e_title("Calendar", "Heatmap of black lives matter Tweets")

# Calendar Heatmap pepsi_kendall ----
pepsi_kendall <- pepsi_kendall %>%
  mutate(date = as.Date(timestamp), count = 1) %>%
  group_by(date) %>%
  summarise(total = sum(count))

# calendar heatmap
pepsi_kendall_calendar <- pepsi_kendall %>% 
  e_charts(date) %>% 
  e_calendar(range = "2017") %>% 
  e_heatmap(total, coord_system = "calendar") %>% 
  e_visual_map(max = 1500) %>% 
  e_title("Calendar", "Heatmap of pepsi and kendall Tweets")