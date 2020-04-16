--1

SELECT SUM(population)
FROM world;

--2

SELECT DISTINCT continent FROM world;

--3

SELECT SUM(gdp) FROM world
WHERE continent = 'Africa';

--4

SELECT COUNT(*) FROM world
WHERE area >= 1000000;

--5

SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

--6

SELECT 
 continent,
 COUNT(name) as NumberOfTheCountries
FROM world
GROUP BY continent;

--7

SELECT 
 continent,
 COUNT(name)
FROM 
 world
WHERE
 population > 10000000
GROUP BY 
 continent;

--8

SELECT 
 continent
FROM
 world
GROUP BY
 continent
HAVING
 SUM(population) >= 100000000;
