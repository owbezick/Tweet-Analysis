dreamCrazyCombinedTexts <- dreamCrazyDreamCrazy_p$text
rquery.wordcloud(dreamCrazyCombinedTexts, "text", 
                             lang="english", 
                             textStemming=T,  colorPalette="Dark2",
                             min.freq=5, max.words=50)

liveForNowCombinedTexts <- liveForNowCombinedQueries$text
rquery.wordcloud(liveForNowCombinedTexts, "text", 
                 lang="english", 
                 textStemming=T,  colorPalette="Dark2",
                 min.freq=5, max.words=50)
