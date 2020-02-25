#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 23 18:11:12 2020

@author: owenbezick
"""

# List of search terms
ls_searchTerms = ["Pepsi AND Kendall", "Pepsi AND Black Lives Matter", "Pepsi AND BLM", "Kendall Jenner AND Black Lives Matter"]

# List  of start dates (YMD)
ls_startDates = ["2017-03-14","2017-03-12"]

# List  of end dates (YMD)
ls_endDates = ["2017-03-11","2017-03-19"]

# Dictionary of command line calls
dict_commandLineCalls = {}

# Populate dictionary of command line calls

for term in ls_pepsiSearchTerms:
    dict_commandLineCalls[term] = "twitterscraper" + term + "-bd" + 