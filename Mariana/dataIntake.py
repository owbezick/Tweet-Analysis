#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 23 18:11:12 2020

@author: owenbezick
"""
# Lets you use shell within python
import os

# Twitter scraper query
query = 'test'

# Result (JSON)
result = os.popen(query)

