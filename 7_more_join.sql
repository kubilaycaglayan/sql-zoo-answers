--1

SELECT id, title
FROM movie
WHERE yr=1962;

--2

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

--3

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

--4

SELECT id
FROM actor
WHERE name = 'Glenn Close';

--5

SELECT id
FROM movie
WHERE title = 'Casablanca';

--6

SELECT name
FROM actor
  JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 11768;

--7

SELECT name
FROM actor
  JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = (SELECT id
FROM movie
WHERE title = 'Alien');

--8

SELECT title
FROM movie
  JOIN casting ON movie.id = casting.movieid
WHERE casting.actorid = (SELECT id
FROM actor
WHERE name = 'Harrison Ford');

--9

SELECT title
FROM movie
  JOIN casting ON movie.id = casting.movieid
WHERE casting.ord != 1
  AND
  casting.actorid = (SELECT id
  FROM actor
  WHERE name =  'Harrison Ford' );

--10

SELECT
  movie.title, (SELECT name
  FROM actor
  WHERE id = casting.actorid) AS 'Name'
FROM movie
  JOIN casting ON movie.id = casting.movieid
WHERE
yr = 1962
  AND
  casting.ord = 1;

--11

SELECT yr, COUNT(title)
FROM
  movie JOIN casting ON movie.id=movieid
  JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

--12

SELECT movie.title, (SELECT name
  FROM actor
  WHERE id = casting.actorid) as Star
FROM movie
  JOIN casting ON movie.id = movieid
WHERE movie.id IN (SELECT movieid
  FROM casting
  WHERE actorid IN (
  SELECT id
  FROM actor
  WHERE name='Julie Andrews'))
  AND casting.ord = 1;

--13

SELECT name
FROM actor
WHERE actor.id IN (SELECT actorid
FROM casting
WHERE ord = 1
GROUP BY actorid
HAVING COUNT(*) > 56)
ORDER BY name/

--14

SELECT 
  title,
  (SELECT COUNT(*)
  FROM casting
  WHERE movieid = movie.id)
FROM movie JOIN casting ON movie.id = casting.movieid
WHERE movie.yr = 1978
GROUP BY title
ORDER BY (SELECT COUNT(*)
FROM casting
WHERE movieid = movie.id) DESC, title;

--15

SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE movieid IN (10095, 11434, 13630)
  AND
  casting.actorid != 1112;
