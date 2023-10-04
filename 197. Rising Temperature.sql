/*
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.


*/

SELECT
    b.id
FROM
    WEATHER a
    join weather b on datediff(day, a.recordDate, b.recordDate) = 1
    and b.temperature > a.temperature