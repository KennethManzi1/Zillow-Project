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
- Once you decide which subscription to use, then you'll go to [endpoints](https://rapidapi.com/sorowerhossan01/api/zillow-working-api) and you'll click the one that says by zpid. Zpid is the Zillow ID that each property has and I'll show you a way to get those without having to manually look them up which can be very tedious. It is easier to get the Zillow ID because addresses can be complicated in terms of how they are written, spelled and also grammer which will cause problems to the code.
- Once you get the zpid endpoint snippet, the next step is to generate the ZPIDs.

# How to get the ZPIDs from Zillow without manually looking for them.

-





