--1

SELECT 
 matchid,
 player
 FROM goal 
  WHERE teamid = 'GER';

--2

SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012;

--3

SELECT goal.player, goal.teamid, game.stadium, game.mdate
  FROM game JOIN goal ON (id=matchid) WHERE goal.teamid = 'GER';

--4

SELECT 
 game.team1, game.team2, goal.player
FROM 
 game
JOIN
 goal
ON 
 game.id = goal.matchid
WHERE
 goal.player LIKE 'Mario%';

--5

SELECT goal.player, goal.teamid, eteam.coach, goal.gtime
  FROM goal
JOIN eteam ON goal.teamid = eteam.id
 WHERE gtime<=10;

--6

SELECT 
 game.mdate,
 eteam.teamname
FROM game
JOIN eteam
ON game.team1 = eteam.id
WHERE (SELECT coach FROM eteam WHERE id = game.team1) = 'Fernando Santos';

--7

SELECT goal.player FROM goal
JOIN game ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw';

--8

SELECT DISTINCT player
  FROM goal
    JOIN game ON goal.matchid = game.id
      WHERE 
        goal.teamid != 'GER'
      AND
        (game.team1 = 'GER'
        OR
        game.team2 = 'GER');

--9

SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname;

--10

SELECT 
  game.stadium, COUNT(goal.player) AS NumberOfGoals
    FROM game
      JOIN goal ON game.id = goal.matchid
        GROUP BY game.stadium;

--11

SELECT matchid, mdate, COUNT(goal.player)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid;

--12

SELECT matchid, mdate, COUNT(goal.player)
  FROM game JOIN goal ON matchid = id 
 WHERE 
(team1 = 'GER' OR team2 = 'GER')
AND
goal.teamid = 'GER'
GROUP BY matchid;

--13

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
    FROM game JOIN goal ON matchid = id 
        GROUP BY game.id
          ORDER BY mdate, matchid, team1, team2;
