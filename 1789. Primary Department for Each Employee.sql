/*
Table: Employee

+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

*/

WITH DEPT_CNT AS
	(SELECT EMPLOYEE_ID,
			COUNT(DEPARTMENT_ID) AS CNT
		FROM EMPLOYEE
		GROUP BY EMPLOYEE_ID)
        
SELECT E.EMPLOYEE_ID,
	E.DEPARTMENT_ID
FROM EMPLOYEE E
JOIN DEPT_CNT D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID
WHERE PRIMARY_FLAG = 'Y'
	OR (PRIMARY_FLAG = 'N'
					AND CNT = 1)