

-- 1. List the total number of reported crimes between 2018 and 2022?

SELECT to_char(count(*), '9g999g999') AS "Total Reported Crimes"
FROM chicago.crimes;

-- Results:

Total Reported Crimes|
---------------------+
 1,189,780           |

-- 2. What is the count of Homicides, Battery and Assaults reported?

SELECT 
	initcap(crime_type) AS crime_type,
	count(*) AS n_crimes
FROM 
	chicago.crimes
WHERE 
	crime_type IN ('homicide', 'battery', 'assault')
GROUP BY 
	crime_type
ORDER BY 
	n_crimes DESC;

-- Results:

crime_type|n_crimes|
----------+--------+
Battery   |  222214|
Assault   |  100411|
Homicide  |    3440|

-- 3. What are the top ten communities that had the MOST amount of crimes reported?
-- Include the current population, density and order by the number of reported crimes.

SELECT 
	co.community_name AS community,
	co.population,
	co.density,
	count(*) AS reported_crimes
FROM 
	chicago.crimes AS cr
JOIN
	chicago.community AS co
ON 
	co.community_id = cr.community_id
GROUP BY 
	co.community_name,
	co.population,
	co.density
ORDER BY 
	reported_crimes DESC
LIMIT 10;

-- Results:

/*

community      |population|density |reported_crimes|
---------------+----------+--------+---------------+
austin         |     96557|13504.48|          66662|
near north side|    105481|38496.72|          51977|
near west side |     67881|11929.88|          41773|
south shore    |     53971|18420.14|          40984|
loop           |     42298|25635.15|          40245|
north lawndale |     34794|10839.25|          39115|
humboldt park  |     54165|15045.83|          34992|
auburn gresham |     44878|11903.98|          33680|
west town      |     87781|19166.16|          32812|
roseland       |     38816| 8053.11|          30836|

*/

-- 4. What are the top ten communities that had the LEAST amount of crimes reported?
-- Include the current population, density and order by the number of reported crimes.

SELECT 
	co.community_name AS community,
	co.population,
	co.density,
	count(*) AS reported_crimes
FROM 
	chicago.crimes AS cr
JOIN
	chicago.community AS co
ON 
	co.community_id = cr.community_id
GROUP BY 
	co.community_name,
	co.population,
	co.density
ORDER BY 
	reported_crimes 
LIMIT 10;

-- Results:

/*

community      |population|density |reported_crimes|
---------------+----------+--------+---------------+
edison park    |     11525|10199.12|           1336|
burnside       |      2527| 4142.62|           1787|
forest glen    |     19596| 6123.75|           2601|
mount greenwood|     18628|  6873.8|           2609|
hegewisch      |     10027| 1913.55|           2861|
montclare      |     14401|14546.46|           2905|
oakland        |      6799|11722.41|           3289|
fuller park    |      2567| 3615.49|           3616|
archer heights |     14196| 7062.69|           4011|
mckinley park  |     15923|11292.91|           4081|

*/