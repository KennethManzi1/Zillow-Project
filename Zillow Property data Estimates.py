#!/usr/bin/env python
# coding: utf-8

# In[2]:

#Importing the Libraries
import seaborn as sns
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from pathlib import Path
import os
import glob

import pandas as pd
from pandas.api.types import is_string_dtype
from pandas.api.types import is_numeric_dtype
import numpy as np

import matplotlib.pyplot as plt
import seaborn as sns
import plotly.graph_objects as go
from plotly.subplots import make_subplots

#!pip install python-zillow -q
#!pip uninstall googlesearch-python -q


# In[3]:


#MLS = pd.read_csv('MSP_Duplex_Search_no_criteria_12_27_23.csv', encoding='utf8')
#MLS_cols = MLS[['Address', 'Status', 'City','Beds','Baths','Square Footage', 'zpid']]
#MLS_cols = pd.DataFrame(MLS_cols)
#MLS_cols['Address'] = MLS_cols['Address'].str.strip()
#MLS_cols['City'] = MLS_cols['City'].str.strip()
#MLS_cols['Status'] = MLS_cols['Status'].str.strip()
#MLS_cols = MLS_cols[MLS_cols['Status'] == 'For Sale']
#MLS_cols = MLS_cols.iloc[0:4]
#MLS_cols = MLS_cols [0:10]


# In[4]:


#zpid_list = list(MLS_cols['zpid'])
#zpid_list


# ### Getting ZPIDs of Properties

# In[5]:


listings = pd.read_csv('listings.csv')
listings['zpid'] = listings['zpid'].astype('int')
listings


# In[6]:


#Getting the list of the zpids
#zpid_list = list(MLS_cols['zpid'])
zpid_list = list(listings['zpid'])
zpid_list


# In[7]:


#print(search_results_list)


# In[ ]:


import requests
import time

url = 'https://zillow-working-api.p.rapidapi.com/pro/byzpid'

zpid_list = zpid_list

headers = {
    'X-RapidAPI-Key': 'YOUR API KEY HERE',
    'X-RapidAPI-Host': 'zillow-working-api.p.rapidapi.com'
}
dataframe = []

for zpid in zpid_list:
    querystring = {"zpid":zpid}
    z_for_sale_resp = requests.request("GET", url, headers=headers, params=querystring)
    z_for_sale_resp_json = z_for_sale_resp.json()
    time.sleep(1.5)
    dataframe.append(z_for_sale_resp_json)
    print(z_for_sale_resp_json)
    

print(dataframe)


# In[ ]:


df_z_for_sale = pd.json_normalize(dataframe)
#print('Num of rows:', len(df_z_for_sale))
#print('Num of cols:', len(df_z_for_sale.columns))
#df_z_for_saleoo = df_z_for_sale[detail_cols]
#df_z_for_sale
#df_z_for_sale.to_csv('ss.csv')


# In[ ]:


detail_cols = ['propertyDetails.streetAddress', 
 'propertyDetails.city',
 'propertyDetails.zipcode',
 'propertyDetails.state',
 'propertyDetails.price',
 'propertyDetails.homeType',
 'propertyDetails.homeStatus',
 'propertyDetails.zestimate',
 'propertyDetails.rentZestimate',
 'propertyDetails.livingArea',
 'propertyDetails.bedrooms','propertyDetails.bathrooms', 'propertyDetails.neighborhoodRegion.name', 
'propertyDetails.daysOnZillow', 'propertyDetails.timeOnZillow', 'propertyDetails.brokerageName',
 'propertyDetails.zpid', 'propertyDetails.listedBy', 'propertyDetails.datePostedString', 'propertyDetails.lotSize', 'propertyDetails.lotAreaValue',
 'propertyDetails.lotAreaUnits','propertyDetails.postingProductType', 'propertyDetails.yearBuilt', 'propertyDetails.countyId', 'propertyDetails.lastSoldPrice',
  'propertyDetails.mortgageRates.thirtyYearFixedRate', 
  'propertyDetails.priceHistory', 'propertyDetails.taxHistory', 'propertyDetails.parcelId','propertyDetails.countyFIPS'
 ]


# In[ ]:


df_z_for_saleoo = df_z_for_sale[detail_cols]
df_z_for_saleoo


# In[30]:


df_z_for_saleoo.to_csv('minneapolisprop.csv')


# In[54]:


#Union the datasets
#oakdale = pd.read_csv('Oakdaleprop.csv')
#invergrove = pd.read_csv('InverHillsprop.csv')
#woodbury = pd.read_csv('Woodburyprop.csv')
#union_df = pd.concat([oakdale, invergrove, woodbury])
#union_df
#union_df.to_csv('Oscarrealestate.csv')


# In[28]:


#import pandas as pd
#import json
#df = pd.read_csv('Wooprop.csv')
#df


# In[4]:


#for index, row in df.iterrows():
    #json_data = row['propertyDetails.priceHistory']

    #try:
        # Load JSON data
        #data = json.loads(json_data)

        # Extract 'price' and 'priceChangeRate' from each element
        #for item in data:
            #price = item.get('price', None)
            #price_change_rate = item.get('priceChangeRate', None)

            #print(price, price_change_rate)

    #except json.JSONDecodeError as e:
        #print(f"Error decoding JSON: {e}")


# In[ ]:




