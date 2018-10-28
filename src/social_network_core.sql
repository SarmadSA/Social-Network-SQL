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

--Q3 For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
SELECT Distinct h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1, Highschooler h2, Likes l, Likes l2
WHERE h1.ID = l.ID1
    AND h2.ID = l.ID2
    AND h1.ID = l2.ID2
    AND h2.ID = l2.ID1
    AND h1.name < h2.name

--Q4 Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
SELECT h.name, h.grade
FROM Highschooler H
WHERE h.ID NOT IN (SELECT ID1 FROM likes)
    AND h.ID NOT IN (SELECT ID2 FROM likes)
ORDER BY h.grade

--Q5 For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
SELECT DISTINCT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1, Highschooler h2, Likes l
WHERE h1.ID = l.ID1
    AND h2.ID = l.ID2
    AND h2.ID NOT IN (SELECT ID1 FROM Likes)

--Q6 Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
SELECT h.name, h.grade
FROM Highschooler h
WHERE h.ID NOT IN
(SELECT DISTINCT h1.ID
FROM Highschooler h1, Highschooler h2, Friend f
WHERE h1.ID = f.ID1
    AND h2.ID = f.ID2
    AND h1.grade <> h2.grade)
ORDER BY h.grade, h.name

--Q7 For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
SELECT a.name, a.grade, b.name, b.grade, c.name, c.grade
FROM Highschooler a, Highschooler b, Highschooler c, likes l, Friend f, Friend f2
WHERE a.ID = l.ID1
    AND b.ID = l.ID2
    AND a.ID = f.ID1
    AND c.ID = f.ID2
    AND b.ID = f2.ID1
    AND c.ID = f2.ID2
    EXCEPT SELECT h.name, h.grade, h1.name, h1.grade, h2.name, h2.grade
FROM highschooler h, highschooler h1, highschooler h2, friend f
WHERE h.ID = f.ID1 AND h1.ID = f.ID2

--Q8 Find the difference between the number of students in the school and the number of different first names.
SELECT SELECT COUNT(name) - COUNT(DISTINCT name) FROM Highschooler

--Q9 Find the name and grade of all students who are liked by more than one other student.
SELECT name, grade
FROM Highschooler
WHERE ID IN (SELECT ID2 FROM Likes GROUP BY ID2 HAVING COUNT(ID2) > 1)