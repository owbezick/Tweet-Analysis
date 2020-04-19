#
#
# Authors: Owen Bezick
#
# 

# Source Libraries
source("libraries.R", local = TRUE)
source("helperFunctions.R", local = TRUE)
source("dataIntake.R", local = TRUE)



# UI ----
ui <- dashboardPage(
  dashboardHeader(title = "Thematic Analysis"
  )
  # Sidebar ----
  , dashboardSidebar( 
    sidebarMenu(
      menuItem(tabName = "home", text = "Info", icon = icon("info-circle")
      )
      , menuItem(tabName ="dreamCrazy", text = "Dream Crazy Campaign", icon = icon("ad")
                 , menuSubItem(tabName = "nikeEmotionAnalysis", text = "Emotion Analysis", icon = icon("surprise"))
                 , menuSubItem(tabName = "nikeBaselineTimeSeries", text = "Time Series", icon = icon("calendar"))
      )
      , menuItem(tabName ="liveForNow", text = "Live For Now Campaign", icon = icon("ad")
                 , menuSubItem(tabName = "pepsiEmotionAnalysis", text = "Emotion Analysis", icon = icon("surprise"))
                 , menuSubItem(tabName = "pepsiBaselineTimeSeries", text = "Time Series", icon = icon("calendar"))
      )
    )
  )
  # Body ----
  , dashboardBody(
    tags$head(tags$style("#purpose{
                                 font-size: 18px;
                                 }"))
    , tags$head(tags$style("#data{
                                 font-size: 18px;
                                 }"))
    , tags$head(tags$style("#nrc{
                                 font-size: 18px;
                                 }"))
    , tags$head(tags$style(HTML(".box-header .box-title{
                                 font-size: 23px;
                                 }")))
    , tags$head(tags$style(HTML(".shiny-html-output{
                                 font-size: 20px;
                                 font-style: italic;
                                 }")))
    , tabItems(
      # Info UI ----
      tabItem(
        tabName = "home"
        ,fluidRow(
          box(width = 6, title = "Purpose", status = "primary", height = "235"
              , textOutput("purpose")
          )
          , box(width = 6, title = "Information on Data", status = "primary", height = "235"
                , column( width = 12
                          , textOutput("data")
                          , uiOutput("colabLink")
                          , textOutput('nrc')
                          , uiOutput("syuzhetLink")
                )
          )
        )
        , fluidRow(
          box(width = 6, height = '425', status = "primary"
              , title = "Live For Now Ad"
              , column(width = 6
                       , HTML('<iframe width="392" height="220.5" src="https://www.youtube.com/embed/uwvAgDCOdU4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
              )
              , column(width = 6
                       , div(img(src="pepsiWordCloud.png"), style = "text-align:center;")
              )
              , valueBoxOutput("liveForNowTotal", width = 12)
          )
          ,   box(width = 6, height = "425", status = "primary"
                  , title = "Dream Crazy Ad"
                  , column(width = 6
                           , HTML('<iframe width="392" height="220.5" src="https://www.youtube.com/embed/jBnseji3tBk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                  )
                  , column(width = 6
                           , div(img(src="nikeWordCloud.png", height = "250", width = "250"), style = "text-align:center;")
                  )
                  , valueBoxOutput("dreamCrazyTotal", width = 12)
          )
        )
        , fluidRow(
          box(width = 6, title = "Live For Now Data", status = "primary"
              , DTOutput("liveForNowData")
              , style = "height: calc(100vh - 260px) !important; overflow-y: scroll;overflow-x: scroll;"
          )
          ,  box(width = 6, title = "Dream Crazy Data", status = "primary"
                 , DTOutput("dreamCrazyData")
                 , style = "height: calc(100vh - 260px) !important; overflow-y: scroll;overflow-x: scroll;"
          )
        )
      )
      # Nike Emotional Analysis UI ----
      , tabItem(
        tabName = "nikeEmotionAnalysis"
        , fluidRow(box(width = 12, status = "primary", title = "Overall Emotion"
                       , echarts4rOutput("nikeSentiment_bar")
        )
        )
        , fluidRow(
          box(width = 12, title = 'Data by Emotion', status = "primary"
              , fluidRow(
                column(width = 2)
                , column(width = 7
                       , radioGroupButtons(
                         inputId = "nikeEmotion",
                         label = "Emotion",
                         choices = c('Negative', 'Anger', "Disgust", "Fear", "Sadness", "Anticipation", "Joy", "Surprise", "Trust", "Positive"),
                         selected = 'Positive',
                       )
                )
                , column(width = 3
                         , valueBoxOutput("percentageNike", width = 12)
                )
              )
              , DTOutput("nikeEmotionData")
          )
        )
      )
      # NIke Time Series UI ----
      , tabItem(
        tabName = "nikeBaselineTimeSeries"
        , fluidRow(
          tabBox(title = "Baseline Queries", width = 12, side = "right"
                 ,tabPanel(title = "Nike"
                           , echarts4rOutput("nikeTimeSeries")
                 )
                 ,tabPanel(title = "Colin Kaepernick"
                           , echarts4rOutput("colinKaepernickTimeSeries")
                 )
                 ,tabPanel(title = "Dream Crazy"
                           , echarts4rOutput("dreamCrazyTimeSeries")
                 )
                 ,tabPanel(title = "Black Lives Matter"
                           , echarts4rOutput("blmNikeTimeSeries")
                 )
          )
          , tabBox(title = "Combined Queries", width = 12, side = "right"
                   ,tabPanel(title = "Colin Kaepernick & Nike"
                             , echarts4rOutput("nikeColinKaepernickTimeSeries")
                   )
                   ,tabPanel(title = "Colin Kaepernick & Black Lives Matter"
                             , echarts4rOutput("blmColinKaepernickTimeSeries")
                   )
                   ,tabPanel(title = "Nike & Black Lives Matter"
                             , echarts4rOutput("nikeBLMTimeSeries")
                   )
                   ,tabPanel(title = "Nike & Dream Crazy"
                             , echarts4rOutput("dreamCrazyNikeTimeSeries")
                   )
                   ,tabPanel(title = "Dream Crazy & Colin Kaepernick"
                             , echarts4rOutput("dreamCrazyKaepTimeSeries")
                   )
          )
        )
      )
      # Pepsi Emotional Analysis UI ----
      , tabItem(
        tabName = "pepsiEmotionAnalysis"
        , fluidRow(
          box(width = 12, status = "primary", title = "Overall Emotion"
              , echarts4rOutput("pepsiSentiment_bar")
          )
        )
        , fluidRow(
          box(width = 12, title = 'Data by Emotion', status = "primary"
              , fluidRow(
                column(width = 2)
                , column(width = 7
                         , radioGroupButtons(
                           inputId = "pepsiEmotion",
                           label = "Emotion",
                           choices = c('Negative', 'Anger', "Disgust", "Fear", "Sadness", "Anticipation", "Joy", "Surprise", "Trust", "Positive"),
                           selected = 'Positive',
                         )
                )
                , column(width = 3
                         , valueBoxOutput("percentagePepsi", width = 12)
                )
              )
              , DTOutput("pepsiEmotionData")
          )
        )
      )
      # Pepsi Time Series UI ----
      , tabItem(
        tabName = "pepsiBaselineTimeSeries"
        , fluidRow(
          tabBox(title = "Time Series Graphics by Query", width = 12, side = "right"
                 ,tabPanel(title = "Pepsi"
                           , echarts4rOutput("pepsiTimeSeries")
                 )
                 ,tabPanel(title = "Kendall Jenner"
                           , echarts4rOutput("kendallJennerimeSeries")
                 )
                 ,tabPanel(title = "Live For Now"
                           , echarts4rOutput("liveForNowTimeSeries")
                 )
                 ,tabPanel(title = "Black Lives Matter"
                           , echarts4rOutput("blmPepsiTimeSeries")
                 )
          )
          , tabBox(title = "Time Series Graphics by Query", width = 12, side = "right"
                   ,tabPanel(title = "Pepsi & Live For Now"
                             , echarts4rOutput("pepsiLiveForNowTimeSeries")
                   )
                   ,tabPanel(title = "Pepsi & Kendall Jenner"
                             , echarts4rOutput("pepsiKedallJennerTimeSeries")
                   )
                   ,tabPanel(title = "Pepsi & Black Lives Matter"
                             , echarts4rOutput("pepsiBLMTimeSeries")
                   )
                   ,tabPanel(title = "Kendall Jenner & Black Lives Matter"
                             , echarts4rOutput("kendallJennerBLMTimeSeries")
                   )
                   ,tabPanel(title = "Kendall Jenner & Live For Now"
                             , echarts4rOutput("liveForNowKendallJennerTimeSeries")
                   )
          )
        )
      )
    )
  )
)


# Define server logic 
server <- function(input, output) {
  # INFO ----
  output$purpose <- renderText("This section of the thesis seeks to understand how Pepsi’s “Live for Now” and Nike’s “Dream Crazy” 
                                 commercials positioned themselves in a space of social resistance. Both of these brand activism advertisements
                                 were met with overwhelming response from consumers on Twitter. Through a scraping twitter and sentiment 
                                 analysis of consumer responses to these commercials one can understand how consumers reacted to these ads.
                                 Through this one can understand how consumers perceive brands engaging in activism.")
  
  output$dreamCrazyTotal <- renderValueBox({
    total_tweets <- nrow(dreamCrazyNike_p) + nrow(dreamCrazyColinKapepernick_p) + nrow(dreamCrazyBlackLivesMatter_p) + nrow(dreamCrazyDreamCrazy_p) + nrow(dreamCrazyCombinedQueries)
    valueBox(format(total_tweets, big.mark = ","), subtitle =  "Dream Crazy Tweets Analyzed")
  })
  
  output$liveForNowTotal <- renderValueBox({
    total_tweets <- nrow(liveForNowPepsi_p) + nrow(liveForNowKendallJenner_p) + nrow(liveForNowBlackLivesMatter_p) + nrow(liveForNow_p) + nrow(liveForNowCombinedQueries)
    valueBox(format(total_tweets, big.mark = ","), subtitle =  "Live For Now Tweets Analyzed")
  })
  
  output$data <- renderText("The data for this project was collected in Python in a Google CoLab Notebook using the TwitterScraper library.")
  
  url1 <- a("Google CoLab Notebook", href="https://colab.research.google.com/drive/1I3g-ZVrYCXkyK5VcVZ6Ujf-7_rz-7SJy")
  output$colabLink <- renderUI({
    tagList("", url1)
  })    
  url2 <- a("Syuzhet Package", href="https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html")
  output$syuzhetLink <- renderUI({
    tagList("", url2)
  })
  
  output$nrc <- renderText("The sentiment analysis was conducted using the NRC sentiment library from the syuzhet R package.")
  
  output$liveForNowData <- renderDT({
    df <- liveForNowBaselineAndCombined
    df <- df[order(df$retweets, decreasing = T),]
    df <- df %>%
      select(Retweets = retweets, Tweet = text)
    datatable(df, rownames = FALSE, options = list(pageLength = 20, scrollY = "750"))
  })
  
  output$dreamCrazyData <- renderDT({
    df <- dreamCrazyBaselineAndCombined
    df <- df[order(df$retweets, decreasing = T),]
    df <- df %>%
      select(Retweets = retweets, Tweet = text)
    datatable(df, rownames = FALSE, options = list(pageLength = 20, scrollY = "750"))
  })
  # NIKE ----
  # Time Series Graphics
  output$nikeTimeSeries <- renderEcharts4r({
    timeSeries(dreamCrazyNike_p, "Nike", "2018-09-03")
  })
  
  output$colinKaepernickTimeSeries <- renderEcharts4r({
    timeSeries(dreamCrazyColinKapepernick_p, "Colin Kaepernick", "2018-09-03")
  })
  
  output$blmNikeTimeSeries <- renderEcharts4r({
    timeSeries(dreamCrazyBlackLivesMatter_p, "Black Lives Matter", "2018-09-03")
  })
  
  output$dreamCrazyTimeSeries <- renderEcharts4r({
    df <- dreamCrazyDreamCrazy_p %>%
      filter(timestamp >= as.Date("2018-09-03"))
    timeSeries(df, "Dream Crazy", "2018-09-03")
  })
  
  
  # Combined
  output$nikeColinKaepernickTimeSeries <- renderEcharts4r({
    timeSeries(nikeColinKaepernick, "Nike & Colin Kaepernick", "2018-09-03")
  })
  output$blmColinKaepernickTimeSeries <- renderEcharts4r({
    timeSeries(ColinBLM, "Black Lives Matter & Colin Kaepernick", "2018-09-03")
  })
  
  output$nikeBLMTimeSeries <- renderEcharts4r({
    timeSeries(nikeBLM, "Black Lives Matter & Nike", "2018-09-03")
  })
  output$dreamCrazyNikeTimeSeries <- renderEcharts4r({
    df <- dreamCrazyNike %>%
      filter(timestamp >= as.Date("2018-09-03"))
    timeSeries(df, "Dream Crazy & Nike", "2018-09-03")
  })
  
  output$dreamCrazyKaepTimeSeries <- renderEcharts4r({
    df <- dreamCrazyKaep %>%
      filter(timestamp >= as.Date("2018-09-03"))
    timeSeries(df, "Dream Crazy & Colin Kaepernick", "2018-09-03")
  })
  
  # Thematic Analysis
  # Bar Chart 
  output$nikeSentiment_bar <- renderEcharts4r({
    dreamCrazyBar_df <- dreamCrazyCombinedQueries %>%
      summarise(anger = sum(anger)
                , disgust = sum(disgust)
                , fear = sum(fear)
                , joy = sum(joy)
                , sadness = sum(sadness)
                , surprise = sum(surprise)
                , trust = sum(trust)
                , anticipation = sum(anticipation)
                , negative = sum(negative)
                , positive = sum(positive)) %>%
      mutate(chart = "")
    sentimentBar(dreamCrazyBar_df, "Dream Crazy Sentiment")
  })
  
  # Data Table
  output$nikeEmotionData <- renderDT({
    req(input$nikeEmotion)
    #Negative
    if(input$nikeEmotion == 'Negative'){
      dreamCrazy_negative <- get_negative(dreamCrazyCombinedQueries)
      df <-dreamCrazy_negative
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(anger, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    #Anger
    if(input$nikeEmotion == 'Anger'){
      dreamCrazy_anger <- get_anger(dreamCrazyCombinedQueries)
      df <-dreamCrazy_anger
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(anger, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Disgust
    if(input$nikeEmotion == 'Disgust'){
      dreamCrazy_disgust <- get_disgust(dreamCrazyCombinedQueries)
      df <- dreamCrazy_disgust
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(disgust, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Fear
    if(input$nikeEmotion == 'Fear'){
      dreamCrazy_fear <- get_fear(dreamCrazyCombinedQueries)
      df <- dreamCrazy_fear
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(fear, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Sadness
    if(input$nikeEmotion == 'Sadness'){
      dreamCrazy_sadness <- get_sadness(dreamCrazyCombinedQueries)
      df <- dreamCrazy_sadness
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(sadness, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Anticipation
    if(input$nikeEmotion == 'Anticipation'){
      dreamCrazy_anticipation <- get_anticipation(dreamCrazyCombinedQueries)
      df <- dreamCrazy_anticipation
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(anticipation, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Joy
    if(input$nikeEmotion == 'Joy'){
      dreamCrazy_joy <- get_joy(dreamCrazyCombinedQueries)
      df <- dreamCrazy_joy
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(joy, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Surprise
    if(input$nikeEmotion == 'Surprise'){
      dreamCrazy_surprise <- get_surprise(dreamCrazyCombinedQueries)
      df <- dreamCrazy_surprise
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(surprise, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Surprise
    if(input$nikeEmotion == 'Trust'){
      dreamCrazy_trust <- get_trust(dreamCrazyCombinedQueries)
      df <- dreamCrazy_trust
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(trust, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Positive
    if(input$nikeEmotion == 'Positive'){
      dreamCrazy_positive <- get_positive(dreamCrazyCombinedQueries)
      df <- dreamCrazy_positive
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(positive, retweets, text)
      percentage$nikeDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
  })
  
  percentage <- reactiveValues(nikeDenominator = 1, pepsiDenominator = 1)
  # Valuebox
  output$percentageNike <- renderValueBox({
    value <- percentage$nikeDenominator/ nrow(dreamCrazyCombinedQueries)
    valueBox(percent(value), subtitle = "Percentage of Tweets")
  })
  
  #PEPSI----
  # Time Series Graphics
  # Baseline
  output$pepsiTimeSeries <- renderEcharts4r({
    timeSeries(liveForNowPepsi_p, "Pepsi", "2017-04-03")
  })
  output$kendallJennerimeSeries <- renderEcharts4r({
    timeSeries(liveForNowKendallJenner_p, "Kendall Jenner", "2017-04-03")
  })
  
  output$blmPepsiTimeSeries <- renderEcharts4r({
    timeSeries(liveForNowBlackLivesMatter_p, "Black Lives Matter", "2017-04-03")
  })
  
  output$liveForNowTimeSeries <- renderEcharts4r({
    df <- liveForNow_p %>%
      filter(timestamp >= as.Date("2017-04-03"))
    timeSeries(df, "Live For Now", "2017-04-03")
  })
  # Combined
  output$kendallJennerBLMTimeSeries <- renderEcharts4r({
    timeSeries(kendallJennerBLM, "Kendall Jenner & Black Lives Matter", "2017-04-03")
  })
  output$liveForNowKendallJennerTimeSeries <- renderEcharts4r({
    timeSeries(liveForNowKendallJenner, "Kendall Jenner & Live For Now", "2017-04-03")
  })
  output$pepsiBLMTimeSeries <- renderEcharts4r({
    timeSeries(pepsiBLM, "Pepsi & Black Lives Matter", "2017-04-03")
  })
  output$pepsiKedallJennerTimeSeries <- renderEcharts4r({
    timeSeries(pepsiKendallJenner, "Pepsi & Kendall Jenner", "2017-04-03")
  })
  output$pepsiLiveForNowTimeSeries <- renderEcharts4r({
    timeSeries(pepsiLiveForNow, "Pepsi & Live For Now", "2017-04-03")
  })
  
  # Thematic Analysis
  # Bar Chart with sentiment
  output$pepsiSentiment_bar <- renderEcharts4r({
    pepsiBar_df <- liveForNowCombinedQueries %>%
      summarise(anger = sum(anger)
                , disgust = sum(disgust)
                , fear = sum(fear)
                , joy = sum(joy)
                , sadness = sum(sadness)
                , surprise = sum(surprise)
                , trust = sum(trust)
                , anticipation = sum(anticipation)
                , negative = sum(negative)
                , positive = sum(positive)) %>%
      mutate(chart = "")
    sentimentBar(pepsiBar_df, "Live For Now Sentiment")
  })
  
  # Data Table
  output$pepsiEmotionData <- renderDT({
    req(input$pepsiEmotion)
    if(input$pepsiEmotion == 'Negative'){
      liveForNow_negative <- get_negative(liveForNowCombinedQueries)
      df <-liveForNow_negative
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(anger, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    #Anger
    if(input$pepsiEmotion == 'Anger'){
      liveForNow_anger <- get_anger(liveForNowCombinedQueries)
      df <-liveForNow_anger
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(anger, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Disgust
    if(input$pepsiEmotion == 'Disgust'){
      liveForNow_disgust <- get_disgust(liveForNowCombinedQueries)
      df <- liveForNow_disgust
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(disgust, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Fear
    if(input$pepsiEmotion == 'Fear'){
      liveForNow_fear <- get_fear(liveForNowCombinedQueries)
      df <- liveForNow_fear
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(fear, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Sadness
    if(input$pepsiEmotion == 'Sadness'){
      liveForNow_sadness <- get_sadness(liveForNowCombinedQueries)
      df <- liveForNow_sadness
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(sadness, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Anticipation
    if(input$pepsiEmotion == 'Anticipation'){
      liveForNow_anticipation <- get_anticipation(liveForNowCombinedQueries)
      df <- liveForNow_anticipation
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(anticipation, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Joy
    if(input$pepsiEmotion == 'Joy'){
      liveForNow_joy <- get_joy(liveForNowCombinedQueries)
      df <- liveForNow_joy
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(joy, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Surprise
    if(input$pepsiEmotion == 'Surprise'){
      liveForNow_surprise <- get_surprise(liveForNowCombinedQueries)
      df <- liveForNow_surprise
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(surprise, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Trust
    if(input$pepsiEmotion == 'Trust'){
      liveForNow_trust <- get_trust(liveForNowCombinedQueries)
      df <- liveForNow_trust
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(trust, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
    # Positive
    if(input$pepsiEmotion == 'Positive'){
      liveForNow_positive <- get_positive(liveForNowCombinedQueries)
      df <- liveForNow_positive
      df <- df[order(df$retweets, decreasing = T),]
      df <- df %>% select(positive, retweets, text)
      percentage$pepsiDenominator <- nrow(df)
      return(datatable(df, rownames = F))
    }
  })
  # Valuebox
  output$percentagePepsi <- renderValueBox({
    value <- percentage$pepsiDenominator/ nrow(liveForNowCombinedQueries)
    valueBox(percent(value), subtitle = "Percentage of Tweets")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
