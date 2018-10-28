-- Q1. Find the names of all students who are friends with someone named Gabriel.
SELECT DISTINCT h.name
FROM Highschooler h, Friend f
WHERE h.ID = f.ID1
    AND f.ID2 IN (SELECT hh.ID
                  FROM Highschooler hh
                  WHERE hh.name = "Gabriel")

--Q2 For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
SELECT DISTINCT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1, Highschooler h2, Likes l
WHERE (l.ID1 = h1.ID
   OR l.ID2 = h1.ID)
   AND (l.ID1 = h2.ID
   OR l.ID2 = h2.ID)
   AND h1.grade > (h2.grade + 1)