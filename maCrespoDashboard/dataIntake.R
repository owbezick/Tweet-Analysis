# Import Raw Data
#dreamCrazyNike_rawDF <- fromJSON("dreamCrazyData/nike.JSON")
#dreamCrazyBlackLivesMatter_rawDF <- fromJSON("dreamCrazyData/blackLivesMatter.JSON")
#dreamCrazycolinKapepernick_rawDF<- fromJSON("dreamCrazyData/colinKaepernick.JSON")
#dreamCrazydreamCrazy_rawDF <- fromJSON("dreamCrazyData/dreamCrazy.JSON")



# Process Data 
#dreamCrazyNike_p <- processData(dreamCrazyNike_rawDF)
#dreamCrazyBlackLivesMatter_p <- processData(dreamCrazyBlackLivesMatter_rawDF)
#dreamCrazycolinKapepernick_p <- processData(dreamCrazycolinKapepernick_rawDF)
#dreamCrazydreamCrazy_p <- processData(dreamCrazydreamCrazy_rawDF)

# Read Processed Data
dreamCrazyBlackLivesMatter_p <- readRDS("dreamCrazyBlackLivesMatter.rds")
dreamCrazyNike_p <- readRDS("dreamCrazyNike.rds")
dreamCrazyColinKapepernick_p <- readRDS("dreamCrazyColinKaepernick.rds")
dreamCrazyDreamCrazy_p <- readRDS("dreamCrazyDreamCrazy.rds")
