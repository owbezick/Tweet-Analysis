#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Template for scraping twitter using the twitter scraper module.


Created on Tue Mar 10 14:41:37 2020

@author: owenbezick
"""

# Lets you use shell within python
import os

# Twitter scraper query
query = 'twitterscraper "query" -bd YYY-MM-DD -ed YYY-MM-DD -o output.JSON'

# Run query
os.system(query)


