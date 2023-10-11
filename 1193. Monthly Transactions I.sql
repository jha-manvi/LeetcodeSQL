/*

Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.



*/

WITH
    all_transactions
    as
    
    (
        SELECT
            left(trans_date,7) as month,
            country,
            sum(amount) as trans_total_amount,
            count(id) as trans_count
        FROM Transactions
        GROUP BY left(trans_date,7),country
    ),

    approved_transactions
    as
    
    (
        SELECT
            left(trans_date,7) as month,
            country,
            sum(amount) as approved_total_amount,
            count(id) as approved_count
        FROM Transactions
        WHERE state='approved'
        GROUP BY left(trans_date,7),country
    )

SELECT
    a.month,
    a.country,
    a.trans_count,
    coalesce(b.approved_count,0) as approved_count,
    a.trans_total_amount,
    coalesce(b.approved_total_amount,0) as approved_total_amount
FROM all_transactions a left join approved_transactions b
    ON a.month=b.month and a.country=b.country