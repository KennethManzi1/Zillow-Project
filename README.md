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

- Next you'll grab the scrapeak Zillow API url, your API Key from scrapeak, the listing URL from zillow that you're using( I was browsing Minneapolis properties just recently so I'll copy that on the listing_url variable) and the query string dictionary that will set the your API_key and the scrapeak URL.

- After that we will transform the metadata into JSON, get the search results, and normalize it into a dataframe to export into a CSV

```Python
url = "https://app.scrapeak.com/v1/scrapers/zillow/listing"
api_key = 'fe4ba972-163e-4dec-8a39-fd9e4e82d6dc'
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

  




