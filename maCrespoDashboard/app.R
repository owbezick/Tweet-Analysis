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
            menuItem(tabName = "home", text = "Home", icon = icon("home")
            )
            , menuItem(tabName ="dreamCrazy", text = "Dream Crazy Campaign"
                       , menuSubItem(tabName = "nikeEmotionAnalysis", text = "Thematic Analysis")
                       , menuSubItem(tabName = "nikeBaselineTimeSeries", text = "Time Series")
            )
            , menuItem(tabName ="liveForNow", text = "Live For Now Campaign"
                       , menuSubItem(tabName = "pepsiEmotionAnalysis", text = "Thematic Analysis")
                       , menuSubItem(tabName = "pepsiBaselineTimeSeries", text = "Time Series")
            )
        )
    )
    # Body ----
    , dashboardBody( 
        tabItems(
            # Home UI ----
            tabItem(
                tabName = "home"
            )
            # Nike Baseline UI ----
            , tabItem(
                tabName = "nikeEmotionAnalysis"
                , fluidRow(box(width = 12, status = "primary", title = "Overall Emotion"
                               , echarts4rOutput("nikeSentiment_bar")
                )
                , tabBox(title = "Thematic Analysis by Emotion", width = 12, side = "right"
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
                )
                )
            )
            # NIke Combined UI ----
            , tabItem(
                tabName = "nikeBaselineTimeSeries"
                , fluidRow(
                    tabBox(title = "Time Series Graphics by Query", width = 12, side = "right"
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
                                     , echarts4rOutput("blmTimeSeries")
                           )
                    )
                )
            )
            # Pepsi Baseline UI ----
            , tabItem(
                tabName = "pepsiEmotionAnalysis"
            )
            # Pepsi Combined UI ----
            , tabItem(
                tabName = "pepsiBaselineTimeSeries"
            )
        )
    )
)


# Define server logic 
server <- function(input, output) {
    # NIKE ----
    # Time Series Graphics
    output$nikeTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyNike_p, "Nike", "2018-09-03")
    })
    
    output$colinKaepernickTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyColinKapepernick_p, "Colin Kaepernick", "2018-09-03")
    })
    
    output$blmTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyBlackLivesMatter_p, "Black Lives Matter", "2018-09-03")
    })
    
    output$dreamCrazyTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyDreamCrazy_p, "Dream Crazy", "2018-09-03")
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
    # Bar Chart with sentiment
    # Data
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
    # Chart
    output$nikeSentiment_bar <- renderEcharts4r({
        dreamCrazyBar_df %>%
            e_chart(chart) %>%
            e_bar("anger") %>%
            e_bar("disgust") %>%
            e_bar("fear") %>%
            e_bar("sadness") %>%
            e_bar("anticipation") %>%
            e_bar("joy") %>%
            e_bar("surprise") %>%
            e_bar("trust") %>%
            e_bar("negative") %>%
            e_bar("positive") %>%
            e_tooltip()
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
