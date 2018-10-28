--Social Network EXTRAS

--Q1 For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.
SELECT a.name, a.grade, b.name, b.grade, c.name, c.grade
FROM Highschooler a, Highschooler b, Highschooler c, Likes l, Likes l2
WHERE a.ID = l.ID1
AND b.ID = l.ID2
AND b.ID = l2.ID1
AND c.ID = l2.ID2
AND a.ID <> c.ID

--Q2 Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.
SELECT h.name, h.grade
FROM highschooler h
WHERE h.id NOT IN (
    SELECT h1.ID
    FROM highschooler h1, friend f, highschooler h2
    WHERE h1.ID = f.ID1
    AND h2.ID = f.ID2
    AND h1.grade = h2.grade)

--Q3 What is the average number of friends per student? (Your result should be just one number.)
SELECT COUNT(h.ID) * 1.0 / (SELECT COUNT(ID) FROM Highschooler) AS AVG
FROM Highschooler h, Friend f
WHERE h.ID = f.ID1

--Q4 Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.
SELECT COUNT(ID2)
FROM Friend
WHERE ID1 IN
(SELECT ID2
FROM Friend
WHERE ID1 = (SELECT ID FROM Highschooler WHERE name = 'Cassandra'))