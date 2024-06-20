CREATE TABLE Corona (
    Province VARCHAR(50),
    Country VARCHAR(50),
    Latitude Decimal(8, 5),
    Longitude Decimal(8, 5),
    Dates Date,
    Confirmed INTEGER,
    Deaths INTEGER,
    Recovered INTEGER
);

SELECT * FROM Corona;
-- Q1. Write a code to check NULL values

SELECT *
FROM corona
WHERE province IS NULL 
   OR country IS NULL 
   OR latitude IS NULL 
   OR dates  IS NULL
   OR confirmed IS NULL
   OR deaths  IS NULL
   OR recovered IS NUll
   OR longitude IS NULL;

-- Q3. check total number of rows

SELECT COUNT(*) AS total_rows
FROM corona;
-- Q4. Check what is start_date and end_date
SELECT 
    MIN(dates) AS start_date,
    MAX(dates) AS end_date
FROM corona;

-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT TO_CHAR(dates, 'YYYY-MM')) AS unique_months
FROM corona;

-- Q6. Find monthly average for confirmed, deaths, recovered

Select TO_CHAR(dates, 'YYYY-MM') As month,
	   Avg(Confirmed) As avg_confirmed,
       Avg(Deaths)  As avg_deaths,
       Avg (Recovered)  As avg_recovered
	    

From Corona
Group by TO_CHAR(dates, 'YYYY-MM');

--Q7.Find most frequent value for confirmed, deaths, recovered each month 

--Q8.Find minimum values for confirmed, deaths, recovered per year

SELECT
    DATE_TRUNC('year', dates) AS year,
    MIN(confirmed) AS min_confirmed,
    MIN(deaths) AS min_deaths,
    MIN(recovered) AS min_recovered
FROM
    corona
GROUP BY
    year
ORDER BY
    year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT
    DATE_TRUNC('year', dates) AS year,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM
    corona
GROUP BY
    year
ORDER BY
    year;

-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT
    DATE_TRUNC('month', dates) AS month,
    Sum(confirmed) AS total_confirmed,
    Sum(deaths) AS total_deaths,
    Sum(recovered) AS total_recovered
FROM
    corona
GROUP BY
    month
ORDER BY
    month;


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )


SELECT
    SUM(confirmed) AS total_confirmed,
    AVG(confirmed) AS average_confirmed,
    VARIANCE(confirmed) AS variance_confirmed,
    STDDEV(confirmed) AS stdev_confirmed
FROM
    corona;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total death cases, their average, variance & STDEV )

SELECT
	DATE_TRUNC('month', dates) AS month,
    SUM(deaths) AS total_deaths,
    AVG(deaths) AS average_deaths,
    VARIANCE(deaths) AS variance_deaths,
    STDDEV(deaths) AS stdev_deaths
FROM
    corona
GROUP BY
    month
ORDER BY
    month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )


SELECT
    SUM(recovered) AS total_recovered,
    AVG(recovered) AS average_recovered,
    VARIANCE(recovered) AS variance_recovered,
    STDDEV(recovered) AS stdev_recovered
FROM
    corona;


-- Q14. Find Country having highest number of the Confirmed case

SELECT country
FROM corona
GROUP BY country
HAVING SUM(Confirmed) = (
    SELECT MAX(total_confirmed)
    FROM (
        SELECT country, SUM(Confirmed) AS total_confirmed
        FROM corona
        GROUP BY country
    ) AS subquery
);

-- Q15. Find Country having lowest number of the death case


SELECT country
FROM corona
GROUP BY country
HAVING SUM(deaths) = (
    SELECT MIN(total_deaths)
    FROM (
        SELECT country, SUM(deaths) AS total_deaths
        FROM corona
        GROUP BY country
    ) AS subquery
);

-- Q16. Find top 5 countries having highest recovered case

SELECT
    country,
    SUM(recovered) AS total_recovered
FROM
    corona
GROUP BY
    country
ORDER BY
    total_recovered DESC
LIMIT 5;


