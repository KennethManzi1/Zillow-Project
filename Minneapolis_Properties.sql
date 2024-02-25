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
propertyDetails_parcelId AS [ParcelID],
propertyDetails_countyFIPS AS [countyFIPS],
REPLACE(REPLACE(REPLACE(REPLACE(propertyDetails_priceHistory, 'None', 'null'), '''', '"'), 'False', 'false'), 'True', 'true') AS [Price History],
REPLACE(REPLACE(REPLACE(REPLACE(propertyDetails_taxHistory, 'None', 'null'), '''', '"'), 'False', 'false'), 'True', 'true') AS [Tax History]
FROM [master].[dbo].[minneapolisprop]
)m

	

--SUBSTRING(propertyDetails_priceHistory, CHARINDEX('"price":', propertyDetails_priceHistory) + LEN('"price":') + 30,
             -- CHARINDEX(',', SUBSTRING(propertyDetails_priceHistory, CHARINDEX('"price":', propertyDetails_priceHistory) + LEN('"price":') + 1, LEN(propertyDetails_priceHistory))) - 1) AS [History Price]


--JSON_VALUE(REPLACE(propertyDetails_priceHistory, '''', ''), '$[0].price') AS [History Price]
--JSON_VALUE(CAST(REPLACE(propertyDetails_priceHistory, '''', '') AS NVARCHAR(MAX)), '$[0].price') AS [History Price]

--JSON_VALUE(JSON_QUERY(REPLACE(propertyDetails_listedBy, '''', '"'), '$[1].elements[0].text'), '$') AS [Listing Agent]
	


