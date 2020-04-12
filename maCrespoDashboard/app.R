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
        tabItems(
            # Info UI ----
            tabItem(
                tabName = "home"
                ,fluidRow(
                    box(width = 12, title = "Information on Purpose"
                        , textOutput("purpose")
                    )
                )
                , fluidRow(
                    box(
                        width = 6, 
                        title = "Live For Now Ad",
                        HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/uwvAgDCOdU4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                    )
                    ,  box(
                        width = 6, 
                        title = "Dream Crazy Ad", 
                        HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/jBnseji3tBk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                    )
                )
                
                , fluidRow(box(width = 12, title = "Information on Data"
                               , fluidRow(column(width = 3
                                                 , valueBoxOutput("liveForNowTotal", width = 12)
                                                 ,img(src="pepsiWordCloud.png")
                               )
                               , column(width = 3
                                        , valueBoxOutput("dreamCrazyTotal", width =12 )
                                        ,img(src="nikeWordCloud.png")
                               )
                               , column(width = 6
                                        , textOutput("data")
                                        , uiOutput("colabLink")
                                        , textOutput('nrc')
                                        , uiOutput("syuzhetLink")
                               )
                               )
                )
                )
            )
            # Nike Emotional Analysis UI ----
            , tabItem(
                tabName = "nikeEmotionAnalysis"
                , fluidRow(box(width = 12, status = "primary", title = "Overall Emotion"
                               , echarts4rOutput("nikeSentiment_bar")
                )
                , tabBox(title = "Relevant Tweet Texts by Emotion", width = 12, side = "right"
                         , tabPanel(title = "Anger"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyAnger_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Anticipation"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyAnticipation_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Disgust"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyDisgust_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Fear"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyFear_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Joy"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyJoy_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Sadness"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazySadness_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Surprise"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazySurprise_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Trust"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyTrust_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Positive"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyPositive_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Negative"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("dreamCrazyNegative_DT")
                                        )
                                    )
                         )
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
                , fluidRow(box(width = 12, status = "primary", title = "Overall Emotion"
                               , echarts4rOutput("pepsiSentiment_bar")
                )
                , tabBox(title = "Relevant Tweet Texts by Emotion", width = 12, side = "right"
                         , tabPanel(title = "Anger"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowAnger_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Anticipation"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowAnticipation_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Disgust"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowDisgust_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Fear"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowFear_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Joy"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowJoy_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Sadness"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowSadness_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Surprise"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowSurprise_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Trust"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowTrust_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Positive"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowPositive_DT")
                                        )
                                    )
                         )
                         , tabPanel(title = "Negative"
                                    , fluidRow(
                                        box(width = 12, status = "primary"
                                            , DTOutput("liveForNowNegative_DT")
                                        )
                                    )
                         )
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
        tagList("URL link:", url1)
    })    
    url2 <- a("Syuzhet Package", href="https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html")
    output$syuzhetLink <- renderUI({
        tagList("URL link:", url2)
    })
    
    output$nrc <- renderText("The sentiment analysis was conducted using the NRC sentiment library from the syuzhet R package.")
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
    # Anger
    dreamCrazy_anger <- get_anger(dreamCrazyCombinedQueries)
    output$dreamCrazy_nAnger <- renderValueBox(valueBox(
        nrow(dreamCrazy_anger)
        , subtitle = "Tweets Tagged as 'Anger'"
        , width = 12)
    )
    
    output$dreamCrazyAnger_DT <- renderDT({
        df <-dreamCrazy_anger
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(anger, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Anticipation
    dreamCrazy_anticipation <- get_anticipation(dreamCrazyCombinedQueries)
    output$dreamCrazyAnticipation_DT <- renderDT({
        df <- dreamCrazy_anticipation
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(anticipation, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Disgust
    dreamCrazy_disgust <- get_disgust(dreamCrazyCombinedQueries)
    output$dreamCrazyDisgust_DT <- renderDT({
        df <- dreamCrazy_disgust
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(disgust, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Fear
    dreamCrazy_fear <- get_fear(dreamCrazyCombinedQueries)
    output$dreamCrazyFear_DT <- renderDT({
        df <- dreamCrazy_fear
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(fear, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Joy
    dreamCrazy_joy <- get_joy(dreamCrazyCombinedQueries)
    output$dreamCrazyJoy_DT <- renderDT({
        df <- dreamCrazy_joy
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(joy, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Sadness
    dreamCrazy_sadness <- get_sadness(dreamCrazyCombinedQueries)
    output$dreamCrazySadness_DT <- renderDT({
        df <- dreamCrazy_sadness
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(sadness, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Surprise
    dreamCrazy_surprise <- get_surprise(dreamCrazyCombinedQueries)
    output$dreamCrazySurprise_DT <- renderDT({
        df <- dreamCrazy_surprise
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(surprise, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Trust
    dreamCrazy_trust <- get_trust(dreamCrazyCombinedQueries)
    output$dreamCrazyTrust_DT <- renderDT({
        df <- dreamCrazy_trust
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(trust, retweets, text)
        datatable(df, rownames = F)
    })
    # Positive
    dreamCrazy_positive <- get_positive(dreamCrazyCombinedQueries)
    output$dreamCrazyPositive_DT <- renderDT({
        df <- dreamCrazy_positive
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(positive, retweets, text)
        datatable(df, rownames = F)
    })
    # Negative
    dreamCrazy_negative <- get_negative(dreamCrazyCombinedQueries)
    output$dreamCrazyNegative_DT <- renderDT({
        df <- dreamCrazy_negative
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(negative, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Bar Chart with sentiment
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
    # Anger
    liveForNow_anger <- get_anger(liveForNowCombinedQueries)
    output$liveForNow_nAnger <- renderValueBox(valueBox(
        nrow(liveForNow_anger)
        , subtitle = "Tweets Tagged as 'Anger'"
        , width = 12)
    )
    
    output$liveForNowAnger_DT <- renderDT({
        df <-liveForNow_anger
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(anger, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Anticipation
    liveForNow_anticipation <- get_anticipation(liveForNowCombinedQueries)
    output$liveForNowAnticipation_DT <- renderDT({
        df <- liveForNow_anticipation
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(anticipation, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Disgust
    liveForNow_disgust <- get_disgust(liveForNowCombinedQueries)
    output$liveForNowDisgust_DT <- renderDT({
        df <- liveForNow_disgust
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(disgust, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Fear
    liveForNow_fear <- get_fear(liveForNowCombinedQueries)
    output$liveForNowFear_DT <- renderDT({
        df <- liveForNow_fear
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(fear, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Joy
    liveForNow_joy <- get_joy(liveForNowCombinedQueries)
    output$liveForNowJoy_DT <- renderDT({
        df <- liveForNow_joy
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(joy, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Sadness
    liveForNow_sadness <- get_sadness(liveForNowCombinedQueries)
    output$liveForNowSadness_DT <- renderDT({
        df <- liveForNow_sadness
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(sadness, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Surprise
    liveForNow_surprise <- get_surprise(liveForNowCombinedQueries)
    output$liveForNowSurprise_DT <- renderDT({
        df <- liveForNow_surprise
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(surprise, retweets, text)
        datatable(df, rownames = F)
    })
    
    # Trust
    liveForNow_trust <- get_trust(liveForNowCombinedQueries)
    output$liveForNowTrust_DT <- renderDT({
        df <- liveForNow_trust
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(trust, retweets, text)
        datatable(df, rownames = F)
    })
    # Positive
    liveForNow_positive <- get_positive(liveForNowCombinedQueries)
    output$liveForNowPositive_DT <- renderDT({
        df <- liveForNow_positive
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(positive, retweets, text)
        datatable(df, rownames = F)
    })
    # Negative
    liveForNow_negative <- get_negative(liveForNowCombinedQueries)
    output$liveForNowNegative_DT <- renderDT({
        df <- liveForNow_negative
        df <- df[order(df$retweets, decreasing = T),]
        df <- df %>% select(negative, retweets, text)
        datatable(df, rownames = F)
    })
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
}

# Run the application 
shinyApp(ui = ui, server = server)
