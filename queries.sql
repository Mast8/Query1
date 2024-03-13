-- Zoo queries

--1List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2 Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world 
WHERE continent = 'Europe' and gdp/population >
 (SELECT gdp/population FROM world WHERE name = 'United Kingdom')

--3 List the name and continent of countries in the continents
--  containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') or 
 continent = (SELECT continent FROM world WHERE name = 'Australia')

--4Which country has a population that is more than United Kingdom
-- but less than Germany? Show the name and the population.
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name  = 'United Kingdom') 
and population < (SELECT population FROM world WHERE name  = 'Germany')

--5 Show the name and the population of each country in Europe. 
--Show the population as a percentage of the population of Germany.
SELECT 
  name, 
  CONCAT(ROUND((population*100)/(SELECT population 
    FROM world WHERE name='Germany'), 0), '%')
FROM world
WHERE  continent='Europe'

--6 Which countries have a GDP greater than every country in Europe? 
--  [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world 
WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe')

--7 Find the largest country (by area) in each continent, 
--  show the continent, the name and the area:
    SELECT continent, name, area
    FROM world a
    WHERE a.area = 
    (SELECT MAX(b.area) FROM world as b 
    WHERE a.continent = b.continent)

--8 List each continent and the name of the country that comes first alphabetically.
SELECT continent, name
FROM world 
group by continent order by name

--9  Find the continents WHERE all countries have a population <= 25000000. 
--   Then find the names of the countries associated with these continents. 
--   Show name, continent and population.
SELECT name, continent, population FROM world a 
WHERE name = all (SELECT name FROM world b WHERE a.continent = b.continent  
and population <= 250000000)

--10 Some countries have populations more than three times that of all of their neighbours
-- (in the same continent). Give the countries and continents.

SELECT name, continent
FROM world a WHERE population > 
all(SELECT population*3 FROM world b WHERE a.continent= b.continent and a.name != b.name)