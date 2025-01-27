/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
*/

with
    cte
    as
    (
        select player_id, event_date,
            lead(event_date) over(partition by player_id order by event_date) as next_date
        from activity

    ),

    first_login
    as
    (
        select player_id, min(event_date) as mindate
        from activity
        group by player_id
    ),

    consec
    as
    (
        select
            cast(count(distinct first_login.player_id) as decimal) as pl_cnt
        from cte inner join first_login
            on cte.player_id=first_login.player_id
        where datediff(next_date,mindate)=1
    ),

    allc
    as
    
    (
        select
            cast(count(distinct player_id) as decimal) as all_cnt
        from activity
    )


select round((pl_cnt/all_cnt),2) as fraction
from consec, allc