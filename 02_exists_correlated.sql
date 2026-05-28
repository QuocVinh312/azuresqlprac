/*
Display employee names
who belong to a department that exists in the Departments table.
*/
SELECT Employees.emp_name
FROM Employees
WHERE dept_id IN (SELECT dept_id FROM Departments);   /* *** FLAG: Missing semicolon at end of statement */


/*
Keep employees whose department exists in Departments table.
*/


/*
Display employee names
whose department name starts with ‘I’
*/
SELECT Employees.emp_name
FROM Employees
LEFT JOIN Departments ON Employees.dept_id = Departments.dept_id
WHERE dept_name LIKE "I%";
/* Display employee names
whose department does NOT exist in the Departments table.
*/
SELECT Employees.emp_name
FROM Employees
WHERE NOT EXISTS (SELECT Employees.dept_id FROM Departments);
/* Show employees whose department name starts with “M” — using EXISTS
*/
SELECT e.emp_name
FROM Employees e
WHERE EXISTS (SELECT 1 FROM Departments d WHERE d.dept_id = e.dept_id AND d.dept_name LIKE "M%");
/*
Display employee names
whose department name is either Marketing or Finance
using EXISTS
*/
SELECT emp_name
FROM Employees e
WHERE EXISTS (
SELECT e.emp_name
FROM Departments d
WHERE d.dept_id = e.dept_id AND dept_name IN("Marketing","Finance"));
/*
Show employee names
who earn more than
the minimum salary in their own department.
*/
WITH CTE AS (
    SELECT MIN(salary) AS MIN, Employees.dept_id
    FROM Employees
    GROUP BY 2
    )
SELECT Employees.emp_name
FROM Employees
LEFT JOIN CTE ON Employees.dept_id = CTE.dept_id
WHERE salary > CTE.MIN;

/*
Display employee names
whose salary is EQUAL TO
the MAX salary in their own department.
*/
WITH CTE AS (
    SELECT Employees.dept_id, MAX(Employees.salary) AS MAX
    FROM Employees
    GROUP BY 1
)
SELECT Employees.emp_name
FROM Employees
LEFT JOIN CTE ON Employees.dept_id = CTE.dept_id
WHERE salary = CTE.MAX;
/*
Display employee names
whose salary is greater than the average salary
of THEIR department.
*/

WITH CTE AS (
    SELECT Employees.dept_id, AVG(Employees.salary) AS AVG
    FROM Employees
    GROUP BY 1
)
SELECT Employees.emp_name
FROM Employees
LEFT JOIN CTE ON Employees.dept_id = CTE.dept_id
WHERE salary > CTE.AVG;

/*
Show employee names
whose salary is less than
the highest salary within their department
BUT also greater than
the lowest salary in their department.
*/

WITH CTE AS (
    SELECT Employees.dept_id, MAX(Employees.salary) AS MAX, MIN(Employees.salary) AS MIN
    FROM Employees
    GROUP BY 1
)
SELECT Employees.emp_name
FROM Employees
LEFT JOIN CTE ON Employees.dept_id = CTE.dept_id
WHERE salary > CTE.MIN AND salary < CTE.MAX
;
/*
Display employee names
whose salary equals the second highest salary in their department.
*/
WITH CTE AS (
SELECT emp_name, dept_id, salary, ROW_NUMBER() over (PARTITION BY Employees.dept_id ORDER BY Employees.salary DESC) AS rank_salary
FROM Employees
),
CTE2 AS (SELECT dept_id, emp_name, salary FROM CTE WHERE rank_salary = 2)
SELECT Employees.emp_name
FROM Employees
LEFT JOIN CTE2 ON Employees.dept_id = CTE2.dept_id
WHERE Employees.salary = CTE2.salary;



/*
Show employee names
whose salary is the second lowest in their department.
*/
WITH CTE AS (
SELECT emp_name, dept_id, salary, ROW_NUMBER() over (PARTITION BY Employees.dept_id ORDER BY Employees.salary ASC) AS rank_salary
FROM Employees
),
CTE2 AS (SELECT dept_id, emp_name, salary FROM CTE WHERE rank_salary = 2)
SELECT Employees.emp_name
FROM Employees
LEFT JOIN CTE2 ON Employees.dept_id = CTE2.dept_id
WHERE Employees.salary = CTE2.salary;

/* Assign ranking numbers to employees
within their department
based on salary from highest to lowest.
*/

SELECT emp_name, dept_id, salary, ROW_NUMBER() over (PARTITION BY Employees.dept_id ORDER BY Employees.salary DESC) AS rank_salary
FROM Employees;