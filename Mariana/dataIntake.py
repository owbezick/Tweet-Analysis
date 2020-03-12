#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 23 18:11:12 2020

@author: owenbezick
"""
# Lets you use shell within python
import os

# Twitter scraper query
query = 'twitterscraper "Black Lives Matter" -bd 2017-03-03 -ed 2017-010-03 -o blackLivesMatterNike.JSON'

# Run query
os.system(query)



