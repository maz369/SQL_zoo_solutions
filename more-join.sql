--#1
SELECT id, title
FROM movie
WHERE yr=1962

--#2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

--#3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%star trek%'
ORDER BY yr

--#4
SELECT title
FROM movie
WHERE id IN ( 11768, 11955, 21191)

--#5
SELECT id
FROM actor
WHERE name = 'Glenn Close'

--#6
SELECT id
FROM movie
WHERE title = 'Casablanca'

--#7
SELECT name
FROM actor, casting
WHERE id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Casablanca')

--#8
SELECT name
FROM actor
  JOIN casting ON (id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Alien'))

--#9
SELECT title
FROM movie
  JOIN casting ON (id=movieid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford'))

--#10
SELECT title
FROM movie
    JOIN casting ON (id=movieid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1)

--#11
SELECT title, name
FROM movie JOIN casting ON (id=movieid)
JOIN actor ON (actor.id = actorid)
WHERE ord=1 AND  yr = 1962

--#12
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t)

--#13
SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews')

--#14
SELECT name
FROM actor
  JOIN casting ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>=30)
GROUP BY name

--#15
SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC

--#16
SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name
