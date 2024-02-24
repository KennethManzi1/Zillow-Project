# Zillow-Project

# Table Of Contents


# Overview
- In the world of evolving markets and advanced technology, it is important for homebuyers and real estate investors to stay up to speed with how the housing market functions and evolves over time. Thanks to data analytics and programming languages such as python, real estate investors and homebuyers can use these skills to increase the likelihood of finding homes or investment properties that fits their budget and their long term ROI and goals. 

- @analyticsariel, a mentor and an expert in the in the data analytics space and a real estate investor has made it possible for individuals in the data analytics space such as myself whom are interested in the housing marekt to utilize these skills to enhance our understanding of the market in order to make sound decisions in terms of buying a home or purchasing a rental property. I am truly grateful for stumbling into her biggerpockets rookie episode and connecting with her on social media in order to learn about using my analytics skills to enhance my understanding of the real estate market.

- And with that I will go ahead and show how to use Python to extract insights from Zillow in regards of getting prices and rental estimates of a particular location. This will involve some data cleaning and cleaning meta data in Python and SQL in order to generate a CSV with each property's information, price, value estimate and rental estimate. I will post a CSV output of single family and multi family homes in Minneapolis.


# Zillow API and ZPID endpoint.

- First thing you'll need is the Zillow API key which can be found [here](https://rapidapi.com/sorowerhossan01/api/zillow-working-api/pricing).
- You will see the price ranges as each time you run the API using Python or a different programming language, you will consume many requests depending how big the dataset is so the larger the data is, the more requests that you'll need. ![Screen Shot 2024-02-24 at 4 07 29 PM](https://github.com/KennethManzi1/Zillow-Project/assets/120513764/f99f39a8-5fc6-4ae7-bbbb-277e5a3bc97b)

- Therefore, if you are in a larger city with many properties in the market and you need a list of those properties from Zillow in a cleaned CSV file then you'll most likely need to pay for additional requests/quota usage.
- Once you decide which subscription to use, then you'll go to [endpoints](https://rapidapi.com/sorowerhossan01/api/zillow-working-api) and you'll click the one that says by zpid. Zpid is the Zillow ID that each property has and I'll show you a way to get those without having to manually look them up which can be very tedious. It is easier to get the Zillow ID because addresses can be complicated in terms of how they are written, spelled and also grammer which will cause problems to the code.  ![Screen Shot 2024-02-24 at 4 09 35 PM](https://github.com/KennethManzi1/Zillow-Project/assets/120513764/2510010c-3b2a-444e-867b-e54aae72b5bb)

- Once you get the zpid endpoint snippet, the next step is to generate the ZPIDs.


# How to get the ZPIDs from Zillow without manually looking for them.

- First thing you'll need to do is to get an API Key from this [Scrapeak](https://app.scrapeak.com/login/?next=/dashboard/scrapers).
- @analyticsariel has a youtube video on how to register and get the API Key [here](https://www.youtube.com/watch?v=bcZe01LhdFc&list=FLzVtAr-grWR9vaEG4ziY3fw&index=8&t=666s).
- Once you get the API Key, the following Python Script below will generate the property listings from Zillow and their ZPID keys on the front end.

```Python
import pandas as pd
import numpy as np
import plotly.express as px
import requests
import warnings
```
These are the libraries you'll need to get the data. Requests and warnings especially as we are extracting the data in JSON format through the API and warnings will tell us whether we reach a request limit on the data pull.

- Next you'll grab the scrapeak Zillow API url, your API Key from scrapeak, the listing URL from zillow that you're using(I was browsing Minneapolis properties just recently so I'll copy that on the listing_url variable) and the query string dictionary that will set the your API_key and the scrapeak URL.

- The ZPIDs that I pulled are Minneapolis ZPIDs so we will be pulling Minneapolis properties. You'll need to make sure to select the types of properties you want for Zillow and that they're on sale then copy the listing URL onto the listing_url variable

- After that we will transform the metadata into JSON, get the search results, and normalize it into a dataframe to export into a CSV

```Python
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


# view data
property_data = z_for["data"]["cat1"]["searchResults"]["mapResults"]
property_data 

#normalizing the listings from json to a dataframe and get the zpids
listings = pd.json_normalize(property_data)
listings = listings['zpid']
listings


#to csv
listings.to_csv('listings.csv')
```
- There you have it. Now we have the list of Minneapolis ZPIDs from Zillow. Now we will use the ZPIDs to get those properties and their prices and estimates.

## Getting Zillow property data and estimates
- Okay now the real fun begins and where the coding happens. With the ZPIDs, let's now pull the information from Zillow. 
  
- On the listing URL variable from the top code, I selected single and multi family properties on Zillow so our ZPIDs should have properties in those designations.
  
- Okay here is the Python code below. We will import the required libraries. Pandas for data cleaning, numpy, requests and time. We will import time because we are looping through the ZPIDs to grab each of their property data from Zillow through the Rapid Zillow API. That is going to burn through the request/Quota of the API pretty quickly so we will limit the request as the loop works its magic by 1.5 seconds. You will see the code of it below.
  
- Matplot and seaborn are there if you're interested in creating visualizations with this data. I didn't do that as for now but may come back to this if I want to see trends of the prices in the Minneapolis Market within a specific timeline.

```Python
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
```
- Time to get the ZPIDs now. You can convert them into a list using the list() function. I ran into some data type errors so I converted the column into an integer and cleaned the messy stuff out of the column.

```Python
listings = pd.read_csv('listings.csv')
listings['zpid'] = listings['zpid'].astype('int')
listings

zpid_list = list(listings['zpid'])
zpid_list
```

- We will use the ZPID endpoint code from the API and create a for loop that will grab each property info for each zpid within the list of zpid in JSON format and append the JSON data to an empty dataframe list.
- We will limit the request speed by 1.5 seconds to avoid burning the API quota.

```Python
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
```

- Normalize the dataframe into the appropriate format and get the columns that we will need(Address, Type, neighborhood, price, zillow value estimate, zillow rent estimate).

```Python
df_z_for_sale = pd.json_normalize(dataframe)

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

df_z_for_saleoo = df_z_for_sale[detail_cols]
df_z_for_saleoo
```

- Convert the data into a CSV

```Python
df_z_for_saleoo.to_csv('minneapolisprop.csv')
```

Now we have the list of the Minneapolis properties and we can go ahead and format and do some additional data cleaning. You can use Python Pandas to do the cleaning or SQL. I decided to use SQL in this case but either method works.

## Data Cleaning in SQL



  




