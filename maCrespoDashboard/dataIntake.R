# Import Raw Data
#dreamCrazyNike_rawDF <- fromJSON("dreamCrazyData/nike.JSON")
#dreamCrazyBlackLivesMatter_rawDF <- fromJSON("dreamCrazyData/blackLivesMatter.JSON")
#dreamCrazycolinKapepernick_rawDF<- fromJSON("dreamCrazyData/colinKaepernick.JSON")
#dreamCrazydreamCrazy_rawDF <- fromJSON("dreamCrazyData/dreamCrazy.JSON")
#cKBLM <- fromJSON("dreamCrazyData/colinKaepernickBlackLivesMatter.JSON")
#dreamCrazyBLM <- fromJSON("dreamCrazyData/dreamCrazyBlackLivesMatter.JSON")

# Process Data 
#dreamCrazyNike_p <- processData(dreamCrazyNike_rawDF)
#dreamCrazyBlackLivesMatter_p <- processData(dreamCrazyBlackLivesMatter_rawDF)
#dreamCrazycolinKapepernick_p <- processData(dreamCrazycolinKapepernick_rawDF)
#dreamCrazydreamCrazy_p <- processData(dreamCrazydreamCrazy_rawDF)
#cKBLM <- processData(cKBLM)
#dreamCrazyBLM <- processData(dreamCrazyBLM)

# Read Processed Data
dreamCrazyBlackLivesMatter_p <- readRDS("dreamCrazyData/dreamCrazyBlackLivesMatter.rds")
dreamCrazyNike_p <- readRDS("dreamCrazyData/dreamCrazyNike.rds")
dreamCrazyColinKapepernick_p <- readRDS("dreamCrazyData/dreamCrazyColinKaepernick.rds")
dreamCrazyDreamCrazy_p <- readRDS("dreamCrazyData/dreamCrazyDreamCrazy.rds")

dreamCrazyColinKapepernickBlackLivesMatter_p <- readRDS("dreamCrazyData/colinKaepernickBlackLivesMatter.rds")
dreamCrazyBlackLivesMatter_p <- readRDS("dreamCrazyData/dreamCrazyBlackLivesMatterComb.rds")

dreamCrazyCombinedQueries <- rbind(dreamCrazyColinKapepernickBlackLivesMatter_p,dreamCrazyBlackLivesMatter_p)

