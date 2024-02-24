#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import plotly.express as px
import requests
import warnings


# ### Listings in Minneapolis(Multifamily)

# In[2]:





url = "https://app.scrapeak.com/v1/scrapers/zillow/listing"
api_key = 'YOUR API KEY HERE'
listing_url = 'https://www.zillow.com/minneapolis-mn/?searchQueryState=%7B%22pagination%22%3A%7B%7D%2C%22isMapVisible%22%3Atrue%2C%22mapBounds%22%3A%7B%22west%22%3A-93.36034635009766%2C%22east%22%3A-93.12345364990234%2C%22south%22%3A44.92864696015096%2C%22north%22%3A45.06824100973466%7D%2C%22regionSelection%22%3A%5B%7B%22regionId%22%3A5983%2C%22regionType%22%3A6%7D%5D%2C%22filterState%22%3A%7B%22land%22%3A%7B%22value%22%3Afalse%7D%2C%22ah%22%3A%7B%22value%22%3Atrue%7D%2C%22apa%22%3A%7B%22value%22%3Afalse%7D%2C%22manu%22%3A%7B%22value%22%3Afalse%7D%2C%22sort%22%3A%7B%22value%22%3A%22globalrelevanceex%22%7D%2C%22con%22%3A%7B%22value%22%3Afalse%7D%2C%22apco%22%3A%7B%22value%22%3Afalse%7D%2C%22tow%22%3A%7B%22value%22%3Afalse%7D%7D%2C%22isEntirePlaceForRent%22%3Atrue%2C%22isRoomForRent%22%3Afalse%2C%22isListVisible%22%3Atrue%2C%22mapZoom%22%3A12%7D'
querystring = {
        "api_key": api_key,
        "url":listing_url
    }
#transform to json
z = requests.request("GET", url, params=querystring)
z_for = z.json()
z_for


# In[3]:


# view data
property_data = z_for["data"]["cat1"]["searchResults"]["mapResults"]
property_data 


# In[4]:


#normalizing the data into a dataframe
listings = pd.json_normalize(property_data)
listings = listings['zpid']
listings


# In[7]:


#to csv
listings.to_csv('listings.csv')


# In[7]:


# columns of interest
details = ['zpid', 'hdpData.homeInfo.streetAddress','hdpData.homeInfo.city', 'hdpData.homeInfo.state', 'hdpData.homeInfo.zipcode',
           'hdpData.homeInfo.price','hdpData.homeInfo.bedrooms', 'hdpData.homeInfo.bathrooms','hdpData.homeInfo.livingArea','hdpData.homeInfo.homeType', 'hdpData.homeInfo.homeStatus', 'hdpData.homeInfo.daysOnZillow', 'hdpData.homeInfo.zestimate','hdpData.homeInfo.rentZestimate','brokerName', 'hdpData.homeInfo.latitude', 'hdpData.homeInfo.longitude'
 ]


# In[7]:


listings_filter = listings[details]
listings_filter





