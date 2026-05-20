/* Using a subquery, find the highest-paid employee(s)
*/
SELECT emp_name AS 'Highest-paid Employee'
FROM Employees
WHERE salary = (SELECT MAX(salary) FROM Employees)
/*
Question 6

Display employee names who work in departments
where the average salary is greater than 5500
*/
WITH avg_emp AS(
    SELECT Employees.dept_id, AVG(Employees.salary) AS AVG_dept_salary
    FROM Employees
    GROUP BY 1
    HAVING AVG_dept_salary > 5500
)
SELECT Employees.emp_name
FROM Employees
JOIN avg_emp ON Employees.dept_id = avg_emp.dept_id
/*
Write a query to display employee names
who work in departments where
the average salary is greater than 6000.
*/
WITH avg_emp AS(
    SELECT Employees.dept_id, AVG(Employees.salary) AS AVG_dept_salary
    FROM Employees
    GROUP BY 1
    HAVING AVG_dept_salary > 6000
)
SELECT Employees.emp_name
FROM Employees
JOIN avg_emp ON Employees.dept_id = avg_emp.dept_id
/*
Display employee names who work in departments
where the maximum salary is greater than 7000.
*/
WITH avg_emp AS(
    SELECT Employees.dept_id, AVG(Employees.salary) AS AVG_dept_salary
    FROM Employees
    GROUP BY 1
    HAVING AVG_dept_salary > 7000
)
SELECT Employees.emp_name
FROM Employees
JOIN avg_emp ON Employees.dept_id = avg_emp.dept_id
/*
Display department names
where at least one employee earns more than Gwen.
*/
SELECT DISTINCT dept_name
FROM Employees
JOIN Departments ON Employees.dept_id = Departments.dept_id
WHERE Employees.salary > (SELECT Employees.salary FROM Employees WHERE emp_name LIKE 'Gwen')

/* Show the employee names
who earn more than Gwen
*/
SELECT emp_name
FROM Employees
WHERE Employees.salary > (SELECT Employees.salary FROM Employees WHERE emp_name LIKE 'Gwen')
/*
Display department names
where no one earns more than Grace.
*/
SELECT emp_name
FROM Employees
WHERE Employees.salary < (SELECT Employees.salary FROM Employees WHERE emp_name LIKE 'Gwen')
/*
Display employee names
whose salary is not less than anyone in IT department
*/
SELECT emp_name
FROM Employees
WHERE Employees.salary > (SELECT MIN(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'IT')
/*
Display employee names
whose salary is greater than or equal to
the highest salary in HR department.
*/
SELECT Employees.emp_name
FROM Employees
WHERE salary >= (SELECT MAX(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'HR')
/*Display employee names
whose salary is greater than or equal to
the average salary in Finance department.
*/

/* 
Display employee names
whose salary is less than
the highest salary in the Marketing department.
*/

/* Display employee names
whose salary is equal to
the minimum salary in the HR department.
*/

/*
Display employee names
whose salary is NOT equal to
the highest salary in the IT department.
*/

/* Display employee names
whose salary is not equal to
the minimum salary in the Finance department.
*/

/* Display employee names
whose salary is equal to
the maximum salary in the department where David works.
*/

/*
Display department names
where the average salary is less than Grace’s salary.
*/

/*
Display department names
where the maximum salary
is greater than Grace’s salary.
*/

/*
Display department names
where the minimum salary
is less than Grace’s salary.
*/

/*
Display department names
where the average salary
is equal to the average salary
of the Sales department.
*/

/*
Display employee names
who belong to a department that exists in the Departments table.
*/