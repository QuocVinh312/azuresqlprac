/* Assign ranking numbers to employees
within their department
based on salary from highest to lowest.
*/
SELECT emp_name, dept_id, salary, ROW_NUMBER() over (PARTITION BY Employees.dept_id ORDER BY Employees.salary DESC) AS rank_salary
FROM Employees;
/*
Your query must:

✔ Use ROW_NUMBER()
✔ Use PARTITION BY dept_id
✔ Use ORDER BY salary DESC
*/
/* For each employee, return:
employee name
department id
salary
the average salary of their department
using a window function.
*/
SELECT Employees.emp_name, Employees.dept_id, Employees.salary, AVG(salary) over (PARTITION BY  Employees.dept_id) AS AVG_Dept
FROM Employees;