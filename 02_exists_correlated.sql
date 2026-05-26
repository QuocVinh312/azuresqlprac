/*
Display employee names
who belong to a department that exists in the Departments table.
*/
SELECT Employees.emp_name
FROM Employees
WHERE dept_id IN (SELECT dept_id FROM Departments)   /* *** FLAG: Missing semicolon at end of statement */


/*
Keep employees whose department exists in Departments table.
*/


/*
Display employee names
whose department name starts with ‘I’
*/
SELECT Employees.emp_name
FROM Employees
WHERE emp_name LIKE "I%"
/* Display employee names
whose department does NOT exist in the Departments table.
*/
SELECT Employees.emp_name
FROM Employees
WHERE emp_id NOT IN (SELECT emp_id FROM Departments)
/* Show employees whose department name starts with “M” — using EXISTS
*/
SELECT Employees.emp_name
FROM Employees
WHERE emp_name LIKE "%M"
/*
Display employee names
whose department name is either Marketing or Finance
using EXISTS
*/

/*
Show employee names
who earn more than
the minimum salary in their own department.
*/

/*
Display employee names
whose salary is EQUAL TO
the MAX salary in their own department.
*/

/*
Display employee names
whose salary is greater than the average salary
of THEIR department.
*/

/*
Show employee names
whose salary is less than
the highest salary within their department
BUT also greater than
the lowest salary in their department.
*/

/*
Display employee names
whose salary equals the second highest salary in their department.
*/

/*
Show employee names
whose salary is the second lowest in their department.
*/

/* Assign ranking numbers to employees
within their department
based on salary from highest to lowest.
*/