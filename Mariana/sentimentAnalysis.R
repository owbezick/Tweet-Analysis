# Exploratory data analysis of Mariana Crespo's twitter scraping of Kendall Jenner Pepsi Ad's and Colin Kaepernick. 
#
#
#
#

library(jsonlite)
library(dplyr)

# Load json file as r dataframe
df_pepsiA <- fromJSON("PepsiA.json")

# date stuff
library(lubridate)

dates <- df_pepsiA %>%
            mutate(date = as.Date(timestamp), count = 1) %>%
            group_by(date) %>%
            summarise(total = sum(count))

# calendar heatmap

dates %>% 
  e_charts(date) %>% 
  e_calendar(range = "2017") %>% 
  e_heatmap(total, coord_system = "calendar") %>% 
  e_visual_map(max = 1500) %>% 
  e_title("Calendar", "Heatmap of PepsiA Tweets")