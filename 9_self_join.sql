--1

SELECT COUNT(*) FROM stops;

--2

SELECT id FROM stops
WHERE name = 'Craiglockhart';

--3

SELECT stops.id, stops.name FROM stops 
JOIN route ON stops.id = route.stop
WHERE num = 4 and company = 'LRT'
ORDER BY pos;

--4

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) > 1;

--5

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53
and b.stop = 149;

--6

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road';

--7

SELECT r1.company, r1.num FROM route r1
JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company)
WHERE 
r1.stop IN (115)
AND
r2.stop IN (137)
GROUP BY r1.num;

--8

SELECT r1.company, r1.num
  FROM route r1 
    JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
      JOIN stops s1 ON (r1.stop = s1.id) 
        JOIN stops s2 ON (r2.stop = s2.id) 
  WHERE 
    s1.name = 'Craiglockhart' 
  AND 
    s2.name = 'Tollcross';

--9

SELECT s2.name, r1.company, r1.num
  FROM route r1 
    JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
      JOIN stops s1 ON (r1.stop = s1.id) 
        JOIN stops s2 ON (r2.stop = s2.id) 
  WHERE 
    s1.name = 'Craiglockhart';

--10

SELECT DISTINCT S.num, S.company, stops.name, E.num, E.company
FROM
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Craiglockhart')
)S
  JOIN
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Lochend')
)E
ON (S.stop = E.stop)
JOIN stops ON(stops.id = S.stop)

--here is my own answer for this problem:

SELECT 
  firstbus.busnumber AS 'num', 
  firstbus.company, secondbus.transfer AS 'name', 
  secondbus.busnumber AS 'num', 
  secondbus.company 
FROM (
  SELECT r1.num AS 'busnumber', 
  r1.company AS 'company', 
  r2.stop AS 'stopp' 
  FROM route r1 
  JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
  JOIN stops s1 ON s1.id = r1.stop
  JOIN stops s2 ON s2.id = r2.stop
  WHERE s1.name = 'Craiglockhart'
  ) firstbus
  JOIN
  (
  SELECT s1.name AS 'transfer', 
  r1.num AS 'busnumber', 
  r1.company AS 'company', 
  r1.stop AS 'stopp', 
  r1.pos AS 'pos' 
  FROM route r1 JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
  JOIN stops s1 ON s1.id = r1.stop
  JOIN stops s2 ON s2.id = r2.stop
  WHERE s2.name = 'Lochend'
  ) secondbus
  ON firstbus.stopp = secondbus.stopp
ORDER BY firstbus.busnumber, name, 4
