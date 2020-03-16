#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 23 18:11:12 2020

@author: owenbezick
"""
# Lets you use shell within python
import os

# Twitter scraper queries for NIKE
blackLivesMatterNike = 'twitterscraper "Black Lives Matter" -bd 2017-08-27 -ed 2017-09-10 -o blackLivesMatterNike.JSON'
nikeColinKaepernick = 'twitterscraper "Nike and Colin Kaepernick " -bd 2017-08-27 -ed 2017-09-10 -o nikeColinKaepernick.JSON'
nikeKaepernick = 'twitterscraper "Nike and Kaepernick" -bd 2017-08-27 -ed 2017-09-10 -o nikeKaepernick.JSON'
nikeandkaep = 'twitterscraper "Nike and Kaep" -bd 2017-08-27 -ed 2017-09-10 -o NikeandKaep.JSON'
nikeandBlackLivesMatter = 'twitterscraper "Nike and Black Lives Matter" -bd 2017-08-27 -ed 2017-09-10 -o NikeandBlackLivesMatter.JSON'
nikeandBLM = 'twitterscraper "Nike and BLM" -bd 2017-08-27 -ed 2017-09-10 -o NikeandBLM.JSON'
ColinKaepernickandBlackLivesMatter = 'twitterscraper "Colin Kaepernick and Black Lives Matter" -bd 2017-08-27 -ed 2017-09-10 -o ColinKaepernickandblackLivesMatter.JSON'
ColinKaepernickandBLM = 'twitterscraper "Colin Kaepernick and BLM" -bd 2017-08-27 -ed 2017-09-10 -o ColinKaepernickandBLM.JSON'
KaepernickandBlackLivesMatter = 'twitterscraper "Kaepernick and Black Lives Matter" -bd 2017-08-27 -ed 2017-09-10 -o KaepernickandBlackLivesMatter.JSON'
KaepernickandBLM = 'twitterscraper "Kaepernick and BLM" -bd 2017-08-27 -ed 2017-09-10 -o KaepernickandBLM.JSON'
KaepandBlackLivesMatter = 'twitterscraper "Kaep and Black Lives Matter" -bd 2017-08-27 -ed 2017-09-10 -o KaepandBlackLivesMatter.JSON'
KaepandBLM = 'twitterscraper "Kaep and BLM" -bd 2017-08-27 -ed 2017-09-10 -o Kaep and BLM.JSON'
DreamCrazyandBlackLivesMatter= 'twitterscraper "Dream Crazy and Black Lives Matter" -bd 2017-08-27 -ed 2017-09-10 -o DreamCrazyandBlackLivesMatter.JSON'
DreamCrazyandBLM= 'twitterscraper "Dream Crazy and BLM" -bd 2017-08-27 -ed 2017-09-10 -o DreamCrazyandBLM.JSON'
DreamCrazyandNike= 'twitterscraper "Dream Crazy and Nike" -bd 2017-08-27 -ed 2017-09-10 -o DreamCrazyandNike.JSON'
DreamCrazyandNike= 'twitterscraper "Dream Crazy and Kaep" -bd 2017-08-27 -ed 2017-09-10 -o DreamCrazyandKaep.JSON'
DreamCrazyandColinKaepernick= 'twitterscraper "Dream Crazy and ColinKaepernick " -bd 2017-08-27 -ed 2017-09-10 -o DreamCrazyandColinKaepernick.JSON'
os.system(query)
