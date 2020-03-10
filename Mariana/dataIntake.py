#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 23 18:11:12 2020

@author: owenbezick
"""
# Lets you use shell within python
import os

# Twitter scraper query
query = 'twitterscraper "Pepsi AND Kendall Jenner" -bd 2017-03-14 -ed 2017-05-14 -o test.JSON'

# Run query
os.system(query)



