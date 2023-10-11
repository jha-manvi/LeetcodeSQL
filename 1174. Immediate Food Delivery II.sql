/*

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.



*/

WITH
    CTE
    AS
    (
        select delivery_id,
            customer_id, order_date, customer_pref_delivery_date,
            row_number() over(partition by customer_id order by order_date) as rw
        from delivery
    )

select round(
    100*(cast(count(delivery_id) as decimal)/(select count(*) as cnt_ttl
    from cte
    where 
     rw=1)),2)
     as immediate_percentage
from
    cte
where  order_date=customer_pref_delivery_date
    and rw=1