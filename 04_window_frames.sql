/*
Display employee name, salary,
and a running total of salary across ALL employees,
ordered by salary ascending.
*/
SELECT Employees.emp_name, Employees.salary, (SELECT SUM(Employees.salary) FROM Employees) AS "TOTAL SALARY"
FROM Employees
ORDER BY salary ASC
/* For each employee, display:
emp_name
dept_id
salary
running total of salary within their department,
ordered from smallest salary to largest inside each department
*/

/* Question (Aggregate Window – COUNT, single concept)
For each employee, show:
emp_name
dept_id
salary
the number of employees in that employee’s department
*/
SELECT Employees.emp_name, Employees.dept_id, Employees.salary, COUNT(*) over(PARTITION BY Employees.dept_id) AS TOTAL_EMP
FROM Employees
/*
Display each employee’s name, department, salary,
and the highest salary in their department using a window function.
*/
SELECT Employees.emp_name, Employees.dept_id, Employees.salary, MAX(Employees.salary) over(PARTITION BY Employees.dept_id) AS MAX_SALARY
FROM Employees
/*
Display emp_name, dept_id, salary
and the lowest salary in their department using a window function.
*/
SELECT Employees.emp_name, Employees.dept_id, Employees.salary, MIN(Employees.salary) over(PARTITION BY Employees.dept_id) AS MIN_SALARY
FROM Employees
/*
Q4 (Evaluation — Aggregate Window + Comparison Logic)

Show emp_name, salary, dept_id
for employees whose salary
is greater than the average salary of their department,
using window functions (not subqueries for avg).
*/
WITH CTE AS (
    SELECT Employees.emp_name, Employees.salary, Employees.dept_id, AVG(Employees.salary) over(PARTITION BY Employees.dept_id) AS AVG_SALARY
    FROM Employees
)
SELECT emp_name, salary, dept_id, AVG_SALARY
FROM CTE
WHERE salary > AVG_SALARY

/*
Show emp_name, dept_id, salary
where salary < dept_max_salary
using window functions (not subqueries)
*/
WITH CTE AS (
    SELECT Employees.emp_name, Employees.salary, Employees.dept_id, MAX(Employees.salary) over(PARTITION BY Employees.dept_id) AS dept_max_salary
    FROM Employees
)
SELECT emp_name, salary, dept_id, dept_max_salary
FROM CTE
WHERE salary < dept_max_salary
/*
Show employees whose salary is above the average salary of their department
using window functions only (no subqueries, no WHERE on window directly — use two-layer logic)
*/
WITH CTE AS (
    SELECT Employees.emp_name, Employees.salary, Employees.dept_id, AVG(Employees.salary) over(PARTITION BY Employees.dept_id) AS dept_avg_salary
    FROM Employees
    ),
    CTE2 AS (
    SELECT emp_name, salary, dept_id, dept_avg_salary
    FROM CTE
    WHERE salary > dept_avg_salary
    )
SELECT emp_name, salary, dept_id, dept_avg_salary
FROM CTE2
/*
Show employees whose salary
is between
the minimum and maximum salary
of their department,
using window functions — no GROUP BY, no subqueries.
*/
WITH CTE1 AS (
    SELECT emp_name, salary, dept_id, MIN(salary) over(PARTITION BY dept_id) AS MIN_SALARY, MAX(salary) over(PARTITION BY dept_id) AS MAX_SALARY
    FROM Employees
)
SELECT emp_name, salary, dept_id
FROM CTE1
WHERE salary BETWEEN MIN_SALARY AND MAX_SALARY

/*
Using window functions, show each employee’s
salary, dept_id,
department min salary,
department average salary,
and keep only those employees whose salary is greater than the department average salary.
*/
WITH CTE1 AS (
    SELECT emp_name, salary, dept_id, MIN(salary) over(PARTITION BY dept_id) AS MIN_SALARY, AVG(salary) over(PARTITION BY dept_id) AS AVG_SALARY
    FROM Employees
)
SELECT emp_name, salary, dept_id, MIN_SALARY, AVG_SALARY
FROM CTE1
WHERE salary > AVG_SALARY




SELECT emp_name, salary
FROM Employees
WHERE salary >
      (SELECT MIN(salary) AS MIN_FINANCE
       FROM Employees
       WHERE dept_id =
            (SELECT dept_id
            FROM Departments
            WHERE dept_name = 'Finance'))



/* For each employee, compute:
department average salary
global minimum salary
global maximum salary
Then show only employees whose salary is:
✔ greater than their department average
AND
✔ between global_min and global_max (which will always be true except for learning)
*/
WITH CTE AS (
    SELECT Employees.emp_name, Employees.salary, AVG(Employees.salary) over (PARTITION BY Employees.dept_id) AS dept_avg_salary, (SELECT MAX(Employees.salary) FROM Employees) AS global_max_salary, (SELECT MIN(Employees.salary) FROM Employees) AS global_min_salary
    FROM Employees
)
SELECT emp_name
FROM CTE
WHERE salary > dept_avg_salary AND salary BETWEEN global_min_salary AND global_max_salary

/*
For each employee, show:
emp_name
salary
dept_id
the difference between their salary and the department minimum salary
*/
WITH CTE AS(
    SELECT Employees.emp_name, Employees.salary, Employees.dept_id, MIN(Employees.salary) OVER(PARTITION BY Employees.dept_id) AS dept_min_salary
    FROM Employees)
SELECT emp_name, salary, dept_id, (salary - dept_min_salary) AS diff_min_salary
FROM CTE
/* For each employee, show:
emp_name
salary
running_total_salary
Running total should accumulate salaries in ascending order of salary.
*/
SELECT
    Employees.emp_name,
    Employees.salary,
    (SELECT SUM(Employees.salary) FROM Employees) AS running_total_salary,
    SUM(salary) OVER(ORDER BY salary ASC) AS running_salary_accumulate
FROM Employees
/*
For each employee, show:
emp_name
salary
running_min_salary
Running minimum should use salary ORDER BY salary ASC.
*/
SELECT
    Employees.emp_name,
    Employees.salary,
    (SELECT MIN(Employees.salary) FROM Employees) AS running_min_salary,
    MIN(salary) OVER(ORDER BY salary ASC) AS running_min_accumulate
FROM Employees
/* For each employee, display:
emp_name
salary
running_max_salary
*/
SELECT
    Employees.emp_name,
    Employees.salary,
    MAX(salary) OVER(ORDER BY salary ASC) AS running_max_salary
FROM Employees
/* List employees with:
emp_name
salary
running_avg_salary (average salary so far)
Based on ascending salary order.
*/
SELECT
    emp_name,
    salary,
    AVG(salary) OVER(ORDER BY salary ASC) AS avg_running_salary
FROM Employees
/* For each employee, show
emp_name
salary
running_total_salary
using this window frame:
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/
SELECT
    emp_name,
    salary,
    SUM(salary) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_salary
FROM Employees

/* For each employee, calculate the 3-row moving sum of salary,
ordered by salary ascending.
*/
SELECT
    emp_name,
    salary,
    SUM(salary) OVER(ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS running_total_salary
FROM Employees

/* Calculate the 3-row moving average of salary
in ascending salary order.
*/
SELECT
    emp_name,
    salary,
    AVG(salary) OVER(
                    ORDER BY salary ASC
                    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        ) AS running_avg_salary
FROM Employees


/* Show:
emp_name
salary
sum_current_row
*/
SELECT
    emp_name,
    salary,
    SUM(salary) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_current_row
FROM Employees


/* For each employee, compute:
emp_name
salary
forward_sum_salary
*/
SELECT
    emp_name,
    salary,
    SUM(salary) OVER(ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS sum_current_row
FROM Employees
/*
For each employee, compute the 3-row centered moving average
(previous row, current row, next row)
ordered by salary ascending
*/
SELECT
    emp_name,
    salary,
    AVG(salary) OVER(ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 3row_moving_average
FROM Employees
/* (1 PRECEDING to 1 FOLLOWING)
compute the centered moving MINIMUM salary
ordered by salary ascending.
*/
SELECT
    emp_name,
    salary,
    MIN(salary) OVER(ORDER BY salary ASC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 3row_min_salary
FROM Employees
/* Compute the centered moving MAXIMUM salary.
Output columns:
emp_name
salary
centered_max_salary
Ordered by salary ASC.
*/
SELECT
    emp_name,
    salary,
    MAX(salary) OVER(ORDER BY salary ASC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 3row_max_salary
FROM Employees