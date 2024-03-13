-- Zoo queries

--3 List the name and continent of countries in the continents
--  containing either Argentina or Australia. Order by name of the country.
select name, continent
from world where continent = (select continent from world where name = 'Argentina') or 
 continent = (select continent from world where name = 'Australia')

--4Which country has a population that is more than United Kingdom
-- but less than Germany? Show the name and the population.
select name, population from world
where population > (select population from world where name  = 'United Kingdom') 
and population < (select population from world where name  = 'Germany')

--5 Which countries have a GDP greater than every country in Europe? 
--[Give the name only.] (Some countries may have NULL gdp values)
select name from world 
where gdp > (select max(gdp) from world where continent = 'Europe')

--6 Which countries have a GDP greater than every country in Europe? 
--  [Give the name only.] (Some countries may have NULL gdp values)
select name from world 
where gdp > (select max(gdp) from world where continent = 'Europe')

--7 Find the largest country (by area) in each continent, 
--  show the continent, the name and the area:
    SELECT continent, name, area
    from world a
    where a.area = 
    (SELECT max(b.area) FROM world as b 
    where a.continent = b.continent)

--8 List each continent and the name of the country that comes first alphabetically.
select continent, name
from world 
group by continent order by name

--9  Find the continents where all countries have a population <= 25000000. 
--   Then find the names of the countries associated with these continents. 
--   Show name, continent and population.
select name, continent, population from world a 
where name = all (select name from world b where a.continent = b.continent  
and population <= 250000000)