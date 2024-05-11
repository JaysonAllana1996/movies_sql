-- Let's view the table
Select *
From Movie_data
order by Rank

-- Count Total nomber of movies in the dataset
Select count(distinct rank) as "Movies total"
From Movie_data

--Selecting Movies with missing revenue data
Select Title, Year, Revenue_Millions
From Movie_data
Where Revenue_Millions is null

-- Counting movies with missing revenue data
Select count (distinct Title)
From Movie_data
Where Revenue_Millions is null

-- Top 20 Movies with biggest revenue

Select Title, Year, Revenue_Millions 
From Movie_data
order by Revenue_Millions desc
-- The query ranks the revenue by the left most digit first, which is wrong

--Let's convert the data type of Revenune into float
Select Title, Year, Cast(Revenue_Millions as float) as Revenue 
From Movie_data
order by Revenue desc
-- This query solves the wrong ranking of the previous query

-- Selecting different genre listed 
SELECT DISTINCT TRIM(value) AS Genre
from Movie_data
CROSS APPLY STRING_SPLIT(Genre, ',');

-- Selecting Movie Genre with the biggest total revenue 
SELECT DISTINCT TRIM(value) AS Genre, SUM(Cast(Revenue_Millions as float)) as Revenue
from Movie_data
CROSS APPLY STRING_SPLIT(Genre, ',')
Group by Trim(value)
Order by Revenue desc

-- Ranking Directors by their total revenue 
Select Director, SUM(Cast(Revenue_Millions as float)) as Revenue 
From Movie_data
group by Director
order by Revenue desc

-- Selecting the year with the most revenue 
Select Year, SUM(Cast(Revenue_Millions as float)) as Revenue 
From Movie_data
group by Year
order by Revenue desc

-- Selecting the year with the most number of movies released
Select Year, count(Year) as number_of_films
From Movie_data
group by Year
order by number_of_films desc

--Top Rated movies ranking by rating
Select Title, Genre, Year, Rating
From Movie_data
order by Rating Desc

--Top Rated movies ranking by metascore
Select Title, Genre, Year, Metascore
From Movie_data
order by Metascore Desc

-- Movies with the longest runtime
Select Title, Genre, Runtime_Minutes
From Movie_data
order by Runtime_Minutes Desc



-- Querying top movie revenue by year
WITH TopEarnerPerYear AS (
    SELECT Year, MAX(CAST(Revenue_Millions AS FLOAT)) AS MaxRevenue
    FROM Movie_data
    GROUP BY Year
)
SELECT m.Year, m.Title, m.Revenue_Millions
FROM Movie_data m
JOIN TopEarnerPerYear t ON m.Year = t.Year AND CAST(m.Revenue_Millions AS FLOAT) = t.MaxRevenue
ORDER BY m.Year;


-- Selecting different actors listed 
SELECT DISTINCT TRIM(value) AS Actors
from Movie_data
CROSS APPLY STRING_SPLIT(Actors, ',');

-- Selecting actors with the biggest total revenue on movies
SELECT DISTINCT TRIM(value) AS Actors, SUM(Cast(Revenue_Millions as float)) as Revenue
from Movie_data
CROSS APPLY STRING_SPLIT(Actors, ',')
Group by Trim(value)
Order by Revenue desc
