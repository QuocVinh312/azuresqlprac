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
SELECT Employees.emp_name
FROM Employees
WHERE salary >= (SELECT AVG(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'Finance')

/* 
Display employee names
whose salary is less than
the highest salary in the Marketing department.
*/
SELECT Employees.emp_name
FROM Employees
WHERE salary < (SELECT MAX(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'Marketing')
/* Display employee names
whose salary is equal to
the minimum salary in the HR department.
*/
SELECT Employees.emp_name
FROM Employees
WHERE salary = (SELECT MIN(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'HR')
/*
Display employee names
whose salary is NOT equal to
the highest salary in the IT department.
*/
SELECT Employees.emp_name
FROM Employees
WHERE salary != (SELECT MAX(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'IT')
/*
/* Display employee names
whose salary is not equal to
the minimum salary in the Finance department.
*/
SELECT Employees.emp_name
FROM Employees
WHERE salary != (SELECT MIN(Employees.salary) FROM Employees JOIN Departments ON Employees.dept_id = Departments.dept_id WHERE dept_name = 'Finance')
/* Display employee names
whose salary is equal to
the maximum salary in the department where Deepak works.
*/

SELECT Employees.emp_name
FROM Employees
WHERE salary = (SELECT MAX(SALARY)
                FROM Employees
                WHERE dept_id = (SELECT Departments.dept_id
                                 FROM Employees
                                          JOIN Departments ON Employees.dept_id = Departments.dept_id
                                 WHERE emp_name LIKE 'Deepak'))

/*
Display department names
where the average salary is less than Ralph’s salary.
*/
SELECT dept_name
FROM Departments d
JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY 1
HAVING AVG(salary) < (SELECT salary FROM Employees WHERE emp_name = 'Ralph')
/*
Display department names
where the maximum salary
is greater than Grace’s salary.
*/
SELECT dept_name
FROM Departments d
JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY 1
HAVING AVG(salary) > (SELECT salary FROM Employees WHERE emp_name = 'Hank')


/*
Display department names
where the minimum salary
is less than Grace’s salary.
*/
SELECT d.dept_name, MIN(e.salary) AS MIN
FROM Departments d
JOIN Employees e ON e.dept_id = d.dept_id
GROUP BY 1
HAVING MIN < (SELECT salary FROM Employees WHERE emp_name = 'Jonas')




/*
Display department names
where the average salary
is equal to the average salary
of the Sales department.
*/
SELECT Departments.dept_name, AVG(Employees.salary) AS AVG
FROM Departments
LEFT JOIN Employees ON Departments.dept_id = Employees.dept_id
GROUP BY 1
HAVING AVG = (SELECT AVG(Employees.salary) FROM Departments JOIN Employees ON Departments.dept_id = Employees.dept_id WHERE dept_name = 'Sales')
/*
Display employee names
who belong to a department that exists in the Departments table.
*/
SELECT Employees.emp_name
FROM Employees
WHERE dept_id IN (SELECT dept_id FROM Departments)