# Import Raw Data
#dreamCrazyNike_rawDF <- fromJSON("dreamCrazyData/baseline/nike.JSON")
#dreamCrazyBlackLivesMatter_rawDF <- fromJSON("dreamCrazyData/baseline/blackLivesMatter.JSON")
#dreamCrazycolinKapepernick_rawDF<- fromJSON("dreamCrazyData/baseline/colinKaepernick.JSON")
#dreamCrazydreamCrazy_rawDF <- fromJSON("dreamCrazyData/baseline/dreamCrazy.JSON")

#nikeColinKaep <- fromJSON("dreamCrazyData/combined/nikeColinKaepernick.JSON")
#colinKaepBLM <- fromJSON("dreamCrazyData/combined/colinKaepernickBlackLivesMatter.JSON")
#nikeBLM <- fromJSON("dreamCrazyData/combined/nikeBlackLivesMatter.JSON")

# pepsiBLM <- fromJSON("liveForNowData/baseline/blackLivesMatter.JSON")
# kendallJenner <- fromJSON("liveForNowData/baseline/kendallJenner.JSON")
# liveForNow <-fromJSON("liveForNowData/baseline/liveForNow.JSON")
# pepsi <- fromJSON("liveForNowData/baseline/pepsi.JSON")

# pepsiBLMComb <- fromJSON("liveforNowData/combined/pepsiBlackLivesMatter.JSON")
# PepsiLiveForNow <- fromJSON("liveforNowData/combined/pepsiLiveForNow.JSON")
# pepsiKendallJenner <- fromJSON("liveforNowData/combined/pepsiKendallJenner.JSON")
# kendallJennerBLM <- fromJSON("liveforNowData/combined/kendallJennerBlackLivesMatter.JSON")
# liveForNowKendallJennerComb <- fromJSON("liveforNowData/combined/liveForNowKendallJenner.JSON")


# Process Data 
#dreamCrazyNike_p <- processData(dreamCrazyNike_rawDF)
#dreamCrazyBlackLivesMatter_p <- processData(dreamCrazyBlackLivesMatter_rawDF)
#dreamCrazycolinKapepernick_p <- processData(dreamCrazycolinKapepernick_rawDF)
#dreamCrazydreamCrazy_p <- processData(dreamCrazydreamCrazy_rawDF)

#nikeColinKaep_p <- processData(nikeColinKaep)
#colinKaepBLM_p <- processData(colinKaepBLM)
#nikeBLM_p <- processData(nikeBLM)

# pepsiBLM_p <- processData(pepsiBLM)
# kendallJenner_p <- processData(kendallJenner)
# liveForNow_p <- processData(liveForNow)
# pepsi_p <- processData(pepsi)

# pepsiBLMComb_p <- processData(pepsiBLMComb)
# pepsiLiveForNowComb_p <- processData(PepsiLiveForNow)
# pepsiKendallJenner_p <- processData(pepsiKendallJenner)
# kendallJennerBLM_p <- processData(kendallJennerBLM)
# liveForNowKendallJennerComb_p <- processData(liveForNowKendallJennerComb)

# Read Processed Data
# Nike ----
# Baseline
dreamCrazyBlackLivesMatter_p <- readRDS("dreamCrazyData/baseline/dreamCrazyBlackLivesMatter.rds")
dreamCrazyNike_p <- readRDS("dreamCrazyData/baseline/dreamCrazyNike.rds")
dreamCrazyColinKapepernick_p <- readRDS("dreamCrazyData/baseline/dreamCrazyColinKaepernick.rds")
dreamCrazyDreamCrazy_p <- readRDS("dreamCrazyData/baseline/dreamCrazyDreamCrazy.rds")
# Combined
nikeColinKaepernick <- readRDS("dreamCrazyData/combined/nikeColinKaepernick.rds")
ColinBLM <- readRDS("dreamCrazyData/combined/colinKaepernickBLM.rds")
nikeBLM <- readRDS("dreamCrazyData/combined/nikeBLM.rds")

dreamCrazyCombinedQueries <- rbind(nikeColinKaepernick,ColinBLM) %>% rbind(nikeBLM)

# Pepsi ----
# Baseline
liveForNowPepsi_p <- readRDS("liveForNowData/baseline/pepsi.rds")
liveForNowBlackLivesMatter_p <- readRDS("liveForNowData/baseline/pepsiBlackLivesMatter.rds")
liveForNow_p <- readRDS("liveForNowData/baseline/liveForNow.rds")
liveForNowKendallJenner_p <- readRDS("liveForNowData/baseline/kendallJenner.rds")
# Combined
kendallJennerBLM <- readRDS("liveForNowData/combined/kendallJennerBLMComb.rds")
liveForNowKendallJenner <- readRDS("liveForNowData/combined/liveForNowKendallJenner.rds")
pepsiBLM <- readRDS("liveForNowData/combined/pepsiBLMComb.rds")
pepsiKendallJenner <- readRDS("liveForNowData/combined/pepsiKendallJennerComb.rds")
pepsiLiveForNow <- readRDS("liveForNowData/combined/pepsiLiveForNowComb.rds")

liveForNowCombinedQueries <- rbind(kendallJennerBLM, liveForNowKendallJenner) %>% rbind(pepsiBLM) %>% rbind(pepsiKendallJenner) %>% rbind(pepsiLiveForNow)
