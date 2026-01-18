/*

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

*/




WITH base as
(
    SELECT
    SUM(case WHEN income<20000 THEN 1 ELSE 0 end) as "Low_Salary",
    SUM(case WHEN income>=20000 and income<=50000 THEN 1 ELSE 0 end) as "Average_Salary",
    SUM(case WHEN income>50000 THEN 1 ELSE 0 end) as "High_Salary"

    FROM
    accounts
)

select 'Low Salary' as category, "Low_Salary"  as accounts_count from base
UNION ALL
select 'Average Salary' as category, "Average_Salary" as accounts_count  from base
UNION ALL
select 'High Salary' as category, "High_Salary" as accounts_count  from base