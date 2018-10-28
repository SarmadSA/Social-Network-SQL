--Social Network EXTRAS

--Q1 For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.
SELECT a.name, a.grade, b.name, b.grade, c.name, c.grade
FROM Highschooler a, Highschooler b, Highschooler c, Likes l, Likes l2
WHERE a.ID = l.ID1
AND b.ID = l.ID2
AND b.ID = l2.ID1
AND c.ID = l2.ID2
AND a.ID <> c.ID