/*
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.
*/

SELECT DISTINCT num AS ConsecutiveNums
FROM   (SELECT id,
               num,
               Lead(num)
                 OVER(
                   ORDER BY id) AS rep1,
               Lead(num, 2)
                 OVER(
                   ORDER BY id) AS rep2
        FROM   logs) a
WHERE  num = rep1
       AND rep1 = rep2 