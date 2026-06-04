/* Write the SQL to compute previous_salary using LAG().
*/
SELECT salary, LAG(Employees.salary) OVER(ORDER BY Employees.salary ASC) AS previous_salary
FROM Employees
/*For each employee, show:
emp_name
salary
next_salary
*/
SELECT
    emp_name,
    salary,
    LEAD(salary) OVER(ORDER BY salary ASC) AS next_salary
FROM Employees
/* For each employee, calculate the salary difference compared to the previous employee, based on ascending salary order.
Output:
emp_name
salary
previous_salary
salary_difference
*/
SELECT
    emp_name,
    salary,
    LAG(salary) OVER(ORDER BY salary ASC) AS previous_salary,
    (salary - LAG(salary) OVER(ORDER BY salary ASC)) AS salary_difference
FROM Employees

/*
For each employee, show:
emp_name
salary
previous_salary
did_salary_increase
*/
SELECT
    emp_name,
    salary,
    LAG(salary) OVER(ORDER BY salary ASC) AS previous_salary,
    CASE WHEN (salary - LAG(salary) OVER(ORDER BY salary ASC)) > 0 THEN 'YES' ELSE 'NO' END AS did_salary_increase
FROM Employees
/*
For each employee, classify their salary trend compared to the previous employee.
Output columns:
emp_name
salary
previous_salary
salary_trend
*/
SELECT
    emp_name,
    salary,
    LAG(salary) OVER(ORDER BY salary ASC) AS previous_salary,
    CASE WHEN (salary - LAG(salary) OVER(ORDER BY salary ASC)) > 0 THEN 'INCREASE' ELSE 'NO' END AS salary_trend
FROM Employees
/* For each employee, compute the salary change amount and salary change direction
compared to the previous employee.
Output:
emp_name
salary
previous_salary
salary_change_amount
salary_change_direction
Where:
salary_change_amount = salary - previous_salary
salary_change_direction = 'Up', 'Down', 'Same', or 'N/A'
*/
SELECT
    emp_name,
    salary,
    LAG(salary) OVER(ORDER BY salary ASC) AS previous_salary,
    (salary - LAG(salary) OVER(ORDER BY salary ASC)) AS salary_change_amount,
    CASE
        WHEN (salary - LAG(salary) OVER(ORDER BY salary ASC)) > 0 THEN 'UP'
        WHEN (salary - LAG(salary) OVER(ORDER BY salary ASC)) = 0 THEN 'SAME'
        WHEN (salary - LAG(salary) OVER(ORDER BY salary ASC)) < 0 THEN 'DOWN'
        ELSE 'N/A'
    END AS salary_change_direction
FROM Employees

/* For each employee, compute the salary difference compared to the previous employee within the SAME department.
Output:
emp_name
dept_id
salary
previous_salary_in_dept
difference_in_dept
*/
SELECT
    emp_name,
    salary,
    LAG(salary) OVER(PARTITION BY dept_id ORDER BY salary) AS previous_salary,
    (salary - LAG(salary) OVER(PARTITION BY dept_id ORDER BY salary)) AS difference_in_dept
FROM Employees
/*
For each employee, show the next employee's salary within the same department
(ordered by salary ASC).
Output:
emp_name
dept_id
salary
next_salary_in_dept
difference_to_next
*/
SELECT
    emp_name,
    salary,
    LEAD(salary) OVER(PARTITION BY dept_id ORDER BY salary) AS next_salary,
    (salary - LEAD(salary) OVER(PARTITION BY dept_id ORDER BY salary)) AS difference_to_next
FROM Employees
/*
For each employee, show:
emp_name
dept_id
salary
previous_salary_in_dept
next_salary_in_dept
is_current_salary_the_middle_value
Where:
is_current_salary_the_middle_value = 'YES' if:
previous_salary < salary < next_salary
Otherwise 'NO'.
NULL cases should produce 'N/A' for the first or last salary in each department.
*/

SELECT
    emp_name,
    salary,
    dept_id,
    LAG(salary) OVER(PARTITION BY dept_id ORDER BY salary) AS previous_salary,
    LEAD(salary) OVER(PARTITION BY dept_id ORDER BY salary) AS next_salary_in_dept,
    CASE
        WHEN (salary > LAG(salary) OVER(PARTITION BY dept_id ORDER BY salary)) AND (salary < LEAD(salary) OVER(PARTITION BY dept_id ORDER BY salary)) THEN 'YES'
        WHEN (LAG(salary) OVER(PARTITION BY dept_id ORDER BY salary) IS NULL) OR (LEAD(salary) OVER(PARTITION BY dept_id ORDER BY salary) IS NULL) THEN 'N/A'
        ELSE 'NO'
    END AS is_current_salary_the_middle_value
FROM Employees