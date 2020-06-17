--Bigger than Russia
--#1 List each country name where the population is larger than that of 'Russia'.
--world(name, continent, area, population, gdp).
SELECT name FROM world
  WHERE population >
  (SELECT population FROM world
  WHERE name='Russia');

--Richer than UK
--#2 Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
--Per Capita GDP
--The per capita GDP is the gdp/population.
SELECT name
  FROM world
  WHERE gdp/population > (SELECT gdp/population
                          FROM world
                          WHERE name = 'United Kingdom')
                          AND continent = 'Europe';

--Neighbours of Argentina and Australia
--#3 List the name and continent of countries in the continents containing either 
--Argentina or Australia. Order by name of the country.
SELECT name, continent
  FROM world
  WHERE continent IN (SELECT continent
                     FROM world
                     WHERE name = 'Argentina'
                     OR name = 'Australia')
                     ORDER BY name;

--Between Canada and Poland
--#4 Which country has a population that is more than Canada but less than Poland? 
--Show the name and the population.
SELECT name, population
  FROM world
  WHERE population IN (SELECT population
                       FROM world 
                       WHERE population > 37.59E6
                       AND population < 37.97E6);

--Percentages of Germany
--#5 Germany (population 80 million) has the largest population of the countries in Europe. 
--Austria (population 8.5 million) has 11% of the population of Germany.
--Show the name and the population of each country in Europe.Show the population as a percentage of the population of Germany.
--The format should be Name, Percentage for example:
--Decimal places
--You can use the function ROUND to remove the decimal places.
--Percent symbol %
--You can use the function CONCAT to add the percentage symbol.
SELECT name, CONCAT(ROUND((population*100)/(SELECT population FROM world WHERE name LIKE ('Germany')), 0), '%')
  FROM world
  WHERE population IN (SELECT population
                       FROM world
                       WHERE continent='Europe');

--Bigger than every country in Europe
--#6 Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values).
SELECT name
  FROM world
  WHERE gdp > (SELECT gdp 
               FROM world
               WHERE continent = 'Europe'
               ORDER BY gdp DESC
               LIMIT 1);

--Largest in each continent
--#7 Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area 
  FROM world x
  WHERE x.area >= ALL
  (SELECT area FROM world y
  WHERE x.continent = y.continent
  AND y.area > 0);

--First country of each continent (alphabetically)
--#8 List each continent and the name of the country that comes first alphabetically.
SELECT continent, name
  FROM world
  GROUP BY continent ASC;
