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
dreamCrazyKaep <- readRDS("dreamCrazyData/combined/dreamCrazyColinKaepernick.rds")
dreamCrazyNike <- readRDS("dreamCrazyData/combined/dreamCrazyNike.rds")

dreamCrazyCombinedQueries <- rbind(nikeColinKaepernick,ColinBLM) %>%
  rbind(nikeBLM) %>% 
  rbind(dreamCrazyKaep) %>% 
  rbind(dreamCrazyNike)

dreamCrazyBaselineAndCombined <- rbind(dreamCrazyBlackLivesMatter_p,dreamCrazyNike_p )%>% 
  rbind(dreamCrazyColinKapepernick_p) %>% 
  rbind(dreamCrazyDreamCrazy_p) %>% 
  rbind(dreamCrazyCombinedQueries)

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

liveForNowBaselineAndCombined <- rbind(liveForNowPepsi_p, liveForNowBlackLivesMatter_p) %>%
  rbind(liveForNow_p) %>%
  rbind(liveForNowKendallJenner_p) %>%
  rbind(liveForNowCombinedQueries)