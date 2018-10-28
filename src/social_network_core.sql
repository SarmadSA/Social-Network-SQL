-- Q1. Find the names of all students who are friends with someone named Gabriel.
SELECT DISTINCT h.name
FROM Highschooler h, Friend f
WHERE h.ID = f.ID1
    AND f.ID2 IN (SELECT hh.ID
                  FROM Highschooler hh
                  WHERE hh.name = "Gabriel")