# 👨‍💻 Zillow-RealEstate-Project

# 👨‍💻 Table Of Contents


- [Overview](#Overview )
- [Zillow API and ZPID endpoint](#Zillow-API-and-ZPID-endpoint)
- [How to get the ZPIDs from Zillow without manually looking for them](#How-to-get-the-ZPIDs-from-Zillow-without-manually-looking-for-them) 
- [Getting Zillow property data and estimates](#Getting-Zillow-property-data-and-estimates)
- [Data Cleaning in SQL](#Data-Cleaning-in-SQL)
- [Links](#Links)

***

# Overview  
- In the world of evolving markets and advanced technology, it is important for homebuyers and real estate investors to stay up to speed with how the housing market functions and evolves over time. Thanks to data analytics and programming languages such as python, real estate investors and homebuyers can use these skills to increase the likelihood of finding homes or investment properties that fits their budget and their long term ROI and goals. 

- @analyticsariel, a mentor and an expert in the in the data analytics space and a real estate investor has made it possible for individuals in the data analytics space such as myself whom are interested in the housing marekt to utilize these skills to enhance our understanding of the market in order to make sound decisions in terms of buying a home or purchasing a rental property. I am truly grateful for stumbling into her biggerpockets rookie episode and connecting with her on social media in order to learn about using my analytics skills to enhance my understanding of the real estate market.

- And with that I will go ahead and show how to use Python to extract insights from Zillow in regards of getting prices and rental estimates of a particular location. This will involve some data cleaning and cleaning meta data in Python and SQL in order to generate a CSV with each property's information, price, value estimate and rental estimate. I will post a CSV output of single family and multi family homes in Minneapolis.

***

# Zillow API and ZPID endpoint.

- First thing you'll need is the Zillow API key which can be found [here](https://rapidapi.com/sorowerhossan01/api/zillow-working-api/pricing).
- You will see the price ranges as each time you run the API using Python or a different programming language, you will consume many requests depending how big the dataset is so the larger the data is, the more requests that you'll need. ![Screen Shot 2024-02-24 at 4 07 29 PM](https://github.com/KennethManzi1/Zillow-Project/assets/120513764/f99f39a8-5fc6-4ae7-bbbb-277e5a3bc97b)

- Therefore, if you are in a larger city with many properties in the market and you need a list of those properties from Zillow in a cleaned CSV file then you'll most likely need to pay for additional requests/quota usage.
- Once you decide which subscription to use, then you'll go to [endpoints](https://rapidapi.com/sorowerhossan01/api/zillow-working-api) and you'll click the one that says by zpid. Zpid is the Zillow ID that each property has and I'll show you a way to get those without having to manually look them up which can be very tedious. It is easier to get the Zillow ID because addresses can be complicated in terms of how they are written, spelled and also grammer which will cause problems to the code.  ![Screen Shot 2024-02-24 at 4 09 35 PM](https://github.com/KennethManzi1/Zillow-Project/assets/120513764/2510010c-3b2a-444e-867b-e54aae72b5bb)

- Once you get the zpid endpoint snippet, the next step is to generate the ZPIDs.

***

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

***

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

- Now we have the list of the Minneapolis properties and we can go ahead and format and do some additional data cleaning. You can use Python Pandas to do the cleaning or SQL. I decided to use SQL in this case but either method works.


***

## Data Cleaning in SQL

- Now that we have the data in a CSV file. We can start to do data cleaning and formatting the fields appropriately. You can do this in Python, SQL or any other data cleaning tool. I will be doing this in SQL.

- First thing you'll need to add the data into your SQL Server or any relational database management system that you use. I use SQL server through a docker image so I can upload the CSV in SQL and create a table with the data.

- Here is a snapshot of data in Visual Studio Code

- ![Screen Shot 2024-02-24 at 9 05 09 PM](https://github.com/KennethManzi1/Zillow-Project/assets/120513764/4df67288-e729-4a6b-8211-725a4ffcbb0a)


- Now we can do some data cleaning and formatting such as dealing with NULL Values, formatting the history data that is under JSON, and fixing string inaccuracies in the data.

```SQL
SELECT [Zillow zpid], 
[Street Address],
[City],
[Zip Code],
[State],
[Status],
[Neighborhood],
[Type],
[Number of Beds],
[Number of Bathrooms],
[price],
[Property Value Estimate],
[Property Rent Estimate],
[Days on Zillow],
[Time on Zillow],
[brokerageName],
[Date_Posted],
[Last Sold Price],
[Lot Size],
[Lot Area Value],
[lot Area Units],	
[Year Built],
[CountyID],
[ThirtyYearFixedRate],
[ParcelID],
[countyFIPS]
/*,
COALESCE(JSON_VALUE(m.[Price History], '$[0].date'), 'UNKNOWN') AS [Price History Date 1 ], 
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[0].price'),0)) AS [Price History Price 1],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[0].taxPaid'),'UNKNOWN')) AS [Tax History Paid 1],
COALESCE(JSON_VALUE(m.[Price History], '$[1].date'), 'UNKNOWN') AS [Price History Date 2 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[1].price'),0)) AS [Price History Price 2],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[1].taxPaid'),'UNKNOWN')) AS [Tax History Paid 2],
COALESCE(JSON_VALUE(m.[Price History], '$[2].date'), 'UNKNOWN') AS [Price History Date 3 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[2].price'), 0)) AS [Price History Price 3],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[2].taxPaid'),'UNKNOWN')) AS [Tax History Paid 3],
COALESCE(JSON_VALUE(m.[Price History], '$[3].date'), 'UNKNOWN') AS [Price History Date 4 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[3].price'), 0)) AS [Price History Price 4],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[3].taxPaid'),'UNKNOWN')) AS [Tax History Paid 4],
COALESCE(JSON_VALUE(m.[Price History], '$[4].date'), 'UNKNOWN') AS [Price History Date 5 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[4].price'), 0)) AS [Price History Price 5],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[4].taxPaid'),'UNKNOWN')) AS [Tax History Paid 5],
COALESCE(JSON_VALUE(m.[Price History], '$[5].date'), 'UNKNOWN') AS [Price History Date 6 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[5].price'), 0)) AS [Price History Price 6],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[5].taxPaid'),'UNKNOWN')) AS [Tax History Paid 6],
COALESCE(JSON_VALUE(m.[Price History], '$[6].date'), 'UNKNOWN') AS [Price History Date 7 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[6].price'), 0)) AS [Price History Price 7],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[6].taxPaid'),'UNKNOWN')) AS [Tax History Paid 7],
COALESCE(JSON_VALUE(m.[Price History], '$[7].date'), 'UNKNOWN') AS [Price History Date 8],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[7].price'), 0)) AS [Price History Price 8],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[7].taxPaid'),'UNKNOWN')) AS [Tax History Paid 8],
COALESCE(JSON_VALUE(m.[Price History], '$[8].date'), 'UNKNOWN') AS [Price History Date 9],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[8].price'), 0)) AS [Price History Price 9],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[8].taxPaid'),'UNKNOWN')) AS [Tax History Paid 9],
COALESCE(JSON_VALUE(m.[Price History], '$[9].date'), 'UNKNOWN') AS [Price History Date 10 ],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[9].price'), 0)) AS [Price History Price 10],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[9].taxPaid'),'UNKNOWN')) AS [Tax History Paid 10],
COALESCE(JSON_VALUE(m.[Price History], '$[10].date'), 'UNKNOWN') AS [Price History Date 11],
CONCAT('$', COALESCE(JSON_VALUE(m.[Price History], '$[10].price'), 0)) AS [Price History Price 11],
CONCAT('$', COALESCE(JSON_VALUE(m.[Tax History], '$[10].taxPaid'),'UNKNOWN')) AS [Tax History Paid 11]
*/
FROM 
(
        SELECT propertyDetails_zpid AS [Zillow zpid],
        propertyDetails_streetAddress AS [Street Address],
        propertyDetails_city AS [City],
        propertyDetails_zipcode AS [Zip Code],
        propertyDetails_state AS [State],
        propertyDetails_homeStatus AS [Status],
        propertyDetails_neighborhoodRegion_name	AS [Neighborhood],
        propertyDetails_homeType AS [Type],
        CONCAT(propertyDetails_bedrooms, ' ', 'Bedrooms') AS [Number of Beds],
        CONCAT(propertyDetails_bathrooms, '  ', 'Bathrooms') As [Number of Bathrooms],	
        CONCAT( '$', COALESCE(propertyDetails_price, 0)) AS [price],
        CASE WHEN propertyDetails_zestimate IS NULL 
        THEN 'UNKNOWN'
        ELSE CONCAT('$',propertyDetails_zestimate ) 
        END AS [Property Value Estimate],

        CASE WHEN propertyDetails_rentZestimate IS NULL
        THEN 'UNKNOWN'
        ELSE CONCAT('$', propertyDetails_rentZestimate)
        END AS [Property Rent Estimate],
        CONCAT(propertyDetails_daysOnZillow, ' ', 'Days') AS [Days on Zillow],
        propertyDetails_timeOnZillow AS [Time on Zillow],
        propertyDetails_brokerageName AS [brokerageName],
        propertyDetails_datePostedString AS [Date_Posted],
        CASE WHEN propertyDetails_lastSoldPrice IS NULL
        THEN 'UNKNOWN'
        ELSE CONCAT('$', propertyDetails_lastSoldPrice)
        END AS [Last Sold Price],

        propertyDetails_lotSize	AS [Lot Size],
        propertyDetails_lotAreaValue AS [Lot Area Value],
        propertyDetails_lotAreaUnits AS [lot Area Units],	
        propertyDetails_yearBuilt AS [Year Built],
        propertyDetails_countyId AS [CountyID],
        propertyDetails_mortgageRates_thirtyYearFixedRate AS [ThirtyYearFixedRate],
        propertyDetails_parcelId AS	[ParcelID],
        propertyDetails_countyFIPS AS [countyFIPS],
        REPLACE(REPLACE(REPLACE(REPLACE(propertyDetails_priceHistory, 'None', 'null'), '''', '"'), 'False', 'false'), 'True', 'true') AS [Price History],
        REPLACE(REPLACE(REPLACE(REPLACE(propertyDetails_taxHistory, 'None', 'null'), '''', '"'), 'False', 'false'), 'True', 'true') AS [Tax History]
        FROM [master].[dbo].[minneapolisprop]
)m
```

- Now that the data is cleaned and concise, the output file looks better than before. However, if i missed anything or if I overdid it with the formatting please let me know and I am open to any tips and feedback on how to make it better. The output file can be found [here](https://github.com/KennethManzi1/Zillow-Project/blob/main/FinalMinneapolispropoutput.csv).

- Overall this was a fun project and it happened through Ariel after learning about her journey from Bigger Pockets Rookie Podcast. As an individual interested in buying my first property and also a home in the future, this was a great way to use my skills in order to enhance my understanding of the housing market and these insights will help me to find opportunities within the market that will help me reach their goals.
  
- Whether you're interested in investing in real estate or just want to own a home, I hope this code can help provide you insights on making the right decision in purchasing a home using data. Thank you for taking your time to read this and let me know if you have any questions or concerns!!!


***

### Links

- [Analytics Ariel](https://linktr.ee/AnalyticsAriel)
- [Subscribe to Tech in Real Estate](https://www.youtube.com/@techinrealestate)
- [Bigger Pockets Rookie Podcast](https://www.biggerpockets.com/podcasts/real-estate-rookie)
- [Scrapeak](https://app.scrapeak.com/login/?next=/dashboard/scrapers)
- [Rapid API](https://rapidapi.com/sorowerhossan01/api/zillow-working-api/pricing)
- [ZPID Python code](https://github.com/KennethManzi1/Zillow-Project/blob/main/Zillow%20Listings%20and%20ZPID%20Python.py)
- [Zillow Property info and estimates code](https://github.com/KennethManzi1/Zillow-Project/blob/main/Zillow%20Property%20data%20Estimates.py)
- [Minneapolis data cleaning SQL Code](https://github.com/KennethManzi1/Zillow-Project/blob/main/Minneapolis_Properties.sql)
- [CSV final output](https://github.com/KennethManzi1/Zillow-Project/blob/main/FinalMinneapolispropoutput.csv)
  









  




