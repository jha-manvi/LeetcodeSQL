/*

Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.

*/

with
    quality
    as
    (
        SELECT
            query_name,
            result,
            cast(rating as decimal)/position as qua
        from queries
    ),

    per
    as
    (
        SELECT
            query_name,
            result
        from queries
        where rating < 3
    )

select
    q.query_name,
    round(avg(qua),2) as quality,
    round((cast(100*count(p.query_name) as decimal))/count(q.query_name),2) as poor_query_percentage
from
    quality q left join per p
    on q.query_name=p.query_name and p.result=q.result
group by q.query_name