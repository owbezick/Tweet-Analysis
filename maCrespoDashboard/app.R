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
    dashboardHeader(title = "Crespo Thesis Data" 
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

            )
            # NIke Combined UI ----
            , tabItem(
                tabName = "nikeBaselineTimeSeries"
                , fluidRow(
                    tabBox(title = "Time Series Graphics by Query", width = 12
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
    
    # Time Series Graphics
    output$nikeTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyNike_p, "Nike")
    })
    
    output$colinKaepernickTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyColinKapepernick_p, "Colin Kaepernick")
    })
    
    output$blmTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyBlackLivesMatter_p, "Black Lives Matter")
    })
    
    output$dreamCrazyTimeSeries <- renderEcharts4r({
        timeSeries(dreamCrazyDreamCrazy_p, "Dream Crazy")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
