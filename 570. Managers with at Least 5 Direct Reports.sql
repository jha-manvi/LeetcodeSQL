/*
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

*/

with cte as (
    select
        m.id,
        m.name,
        count(e.id) as cnt
    from
        employee m
        left join employee e on m.id = e.managerId
    group by
        m.id,
        m.name
    having
        count(e.id) >= 5
)
select
    name
from
    cte