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