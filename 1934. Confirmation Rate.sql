/*
Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.
*/

WITH CTE AS (
    SELECT
        s.user_id,
        c.action
    FROM
        signups s
        left join confirmations c on s.user_id = c.user_id
),
all_users as (
    SELECT
        user_id,
        count(user_id) as cnt_all
    FROM
        cte
    group by
        user_id
),
conf as(
    SELECT
        user_id,
        count(user_id) as cnt_cnf
    FROM
        cte
    where
        action = 'confirmed'
    group by
        user_id
)
SELECT
    a1.user_id,
    round(
        cast(coalesce(cnt_cnf, 0) as decimal) / cnt_all,
        2
    ) as confirmation_rate
FROM
    all_users a1
    left join conf c1 on a1.user_id = c1.user_id