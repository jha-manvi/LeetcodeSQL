/*
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null).

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

*/

WITH EMPL_TO_MGR AS
	(SELECT E1.EMPLOYEE_ID,
			E1.NAME AS MGR_NM,
			E2.NAME AS EMPL_NM,
			E2.AGE
		FROM EMPLOYEES E1
		INNER JOIN EMPLOYEES E2 ON E1.EMPLOYEE_ID = E2.REPORTS_TO)
SELECT EMPLOYEE_ID,
	MGR_NM AS NAME,
	COUNT(EMPL_NM) AS REPORTS_COUNT,
	ROUND(AVG(CAST(AGE AS decimal)),
		0) AS AVERAGE_AGE
FROM EMPL_TO_MGR
GROUP BY EMPLOYEE_ID,
	MGR_NM
ORDER BY EMPLOYEE_ID