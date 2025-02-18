/*
Table: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Report for every three line segments whether they can form a triangle.

Return the result table in any order.
*/

WITH three_side
     AS (SELECT x,
                y,
                z,
                x + y AS xy,
                y + z AS yz,
                x + z AS xz
         FROM   triangle),
     checks
     AS (SELECT x,
                y,
                z,
                CASE
                  WHEN xy > z
                       AND yz > x
                       AND xz > y THEN 'Yes'
                  ELSE 'No'
                END AS triangle
         FROM   three_side)
SELECT *
FROM   checks 