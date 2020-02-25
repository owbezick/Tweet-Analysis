
library(tidyverse)
library(rvest)

df <- read_csv("General2016.csv")

# emily <- read_html("https://twitter.com/dahliabloom") %>%
  # html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
  # html_text()


# for each user
# make the url

df2016 <- df %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

d = list()
for(i in 1:nrow(df)){
  test <- read_html(df2016$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- test
  
}

df2016$location <- unlist(do.call(rbind, d))



#-----------------------------------------------------------------------------------------------------------


df <- read_csv("General2017.csv")


df2017 <- df %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

d = list()
for(i in 1:nrow(df)){
  test <- read_html(df2017$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- test
  
}

df2017$location <- unlist(do.call(rbind, d))


#-------------------------------------------------------------------------------------------------
df <- read_csv("General2018.csv")


df2018 <- df %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

d = list()
for(i in 1:nrow(df)){
  test <- read_html(df2018$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- test
  
}

df2018$location <- unlist(do.call(rbind, d))

#------------------------------------------------------------------------------------------------------

df <- read_csv("General2019.csv")


df2019 <- df %>%
  mutate(profile = paste("https://twitter.com/",`Tweet Username`, sep=""))

d = list()
for(i in 1:nrow(df)){
  test <- read_html(df2019$profile[i]) %>%
    html_nodes("#page-container > div.AppContainer > div > div > div.Grid-cell.u-size1of3.u-lg-size1of4 > div > div > div > div.ProfileHeaderCard > div.ProfileHeaderCard-location > span.ProfileHeaderCard-locationText.u-dir") %>%
    html_text()
  
  d[i] <- test
  
}

df2019$location <- unlist(do.call(rbind, d))


#-----------------------------------------------------------------

#connect data frames

#library(tidyverse)

full_df <- df2016 %>%
  rbind(df2017) %>%
  rbind(df2018) %>%
  rbind(df2019)

full_df$location <- gsub("➡️", "", full_df$location)

full_df$location <- gsub("ÜT:", "", full_df$location)

full_df$location <- gsub("👎🏼", "", full_df$location)


distinct_locations <- full_df %>%
  distinct(location)

real_locations <- read_csv("RealLocations3.csv")

list <- apply(real_locations, 1, list)

test <- full_df
length <- length(test$location)
vector <- 

for(i in 1:length) {
  cur <- test[i, "location"]
  print(cur)
  if(cur %in% list) {} else {
    full_df[i, "location"] <- NA
  }
}

install.packages("openxlsx")
library(openxlsx)

write.xlsx(full_df, file = "New Locations.xlsx", colNames = TRUE)

