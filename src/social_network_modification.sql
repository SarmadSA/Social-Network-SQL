--Modification EX

--Q1 It's time for the seniors to graduate. Remove all 12th graders from Highschooler.
DELETE FROM Highschooler WHERE grade = 12

--Q2 If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.
DELETE FROM Likes
WHERE ID1 IN
(SELECT l.ID1
FROM Friend f, Likes l, Likes l2
WHERE l.ID1 = f.ID1
AND l.ID2 = f.ID2
EXCEPT SELECT l.ID1
    FROM Friend f, Likes l, Likes l2
    WHERE l.ID2 = l2.ID1
    AND l2.ID2 = l.ID1)

--Q3 For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself.
INSERT INTO Friend
SELECT a.ID, c.ID
FROM Highschooler a, Highschooler b, Highschooler c, Friend f, Friend f2
WHERE a.ID = f.ID1
    AND b.ID = f.ID2
    AND b.ID = f2.ID1
    AND c.ID = f2.ID2
    AND a.ID <> c.ID
    EXCEPT
    SELECT a.ID, c.ID
    FROM Highschooler a, Highschooler c, Friend f
    WHERE a.ID = f.ID1
        AND c.ID = f.ID2

-------- OR --------

INSERT INTO Friend
SELECT a.ID, c.ID
FROM Highschooler a, Highschooler b, Highschooler c, Friend f, Friend f2
WHERE a.ID = f.ID1
    AND b.ID = f.ID2
    AND b.ID = f2.ID1
    AND c.ID = f2.ID2
    AND a.ID <> c.ID
    EXCEPT
    SELECT * FROM Friend