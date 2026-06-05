/* Ranking Question 1 (Beginner Level)
For each department, return:
emp_name
dept_id
salary
ROW_NUMBER() over salary DESC
RANK() over salary DESC
DENSE_RANK() over salary DESC
Partition by dept_id
Order by salary DESC
*/
SELECT
    emp_name,
    dept_id,
    salary,
    ROW_NUMBER() over(PARTITION BY dept_id ORDER BY salary DESC) AS row_number_salary,
    RANK() over(PARTITION BY dept_id ORDER BY salary DESC) AS rank_salary,
    DENSE_RANK() over(PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_salary
FROM Employees
/*
For each department, list
emp_name
dept_id
salary
rank of salary within the department (highest salary = rank 1)
using only RANK(), nothing else.
*/
SELECT
    emp_name,
    dept_id,
    salary,
    RANK() over(PARTITION BY  Employees.dept_id ORDER BY salary DESC) AS rank_salary
FROM Employees
/* For each department, list employees whose salary rank is 1 or 2 using RANK().
*/
WITH CTE AS (
SELECT
    emp_name,
    dept_id,
    salary,
    RANK() over(PARTITION BY  Employees.dept_id ORDER BY salary DESC) AS rank_salary
FROM Employees)
SELECT emp_name, dept_id, salary, rank_salary
FROM CTE
WHERE rank_salary IN(1,2)
/*
For each department, return all employees except those with salary rank = 1
(so exclude the highest-paid employees in every department).
*/
WITH CTE AS (
SELECT
    emp_name,
    dept_id,
    salary,
    RANK() over(PARTITION BY  Employees.dept_id ORDER BY salary DESC) AS rank_salary
FROM Employees)
SELECT emp_name, dept_id, salary, rank_salary
FROM CTE
WHERE rank_salary != 1

/*
For each department, show:
emp_name
dept_id
salary
salary_dense_rank
where salary_dense_rank is dense_rank of salary within each department (highest salary = 1).
*/
SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) salary_dense_rank
FROM Employees
/* Show each employee’s
emp_name
dept_id
salary
dense rank of salary ACROSS the entire company, not per department.
*/
SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (ORDER BY salary DESC) AS rank_salary_across_total
FROM Employees

/*
For each department, list only those employees who have dense_rank = 1 or 2
(i.e., the top two salary groups, including ties).
*/
WITH CTE AS (SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_dept
FROM Employees)
SELECT emp_name, dept_id, salary, dense_rank_dept
FROM CTE
WHERE dense_rank_dept IN(1,2)

/* For each department, return ONLY employees whose salary is in the third highest salary group, based on DENSE_RANK.
*/
WITH CTE AS (SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_dept
FROM Employees)
SELECT emp_name, dept_id, salary, dense_rank_dept
FROM CTE
WHERE dense_rank_dept = 3
/* For each department, return:
emp_name
dept_id
salary
rank_salary
dense_rank_salary
*/
SELECT
    emp_name,
    dept_id,
    salary,
    RANK() over(PARTITION BY dept_id ORDER BY salary DESC) AS rank_salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_salary
FROM Employees
/*
For each department, return only the employees who earn the second-highest salary amount in that department.
*/
WITH CTE AS (SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_dept
FROM Employees)
SELECT emp_name, dept_id, salary, dense_rank_dept
FROM CTE
WHERE dense_rank_dept = 2
/*
For each department, return the employee who appears second when salaries are sorted in descending order, ignoring ties.
*/
WITH CTE AS (
SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_dept
FROM Employees),
CTE2 AS (
SELECT
    emp_name,
    dept_id,
    salary,
    dense_rank_dept,
    ROW_NUMBER() over(PARTITION BY dense_rank_dept ORDER BY dense_rank_dept) AS row_num_dense_rank
FROM CTE
)
SELECT emp_name, dept_id, salary, dense_rank_dept, row_num_dense_rank
FROM CTE2
WHERE row_num_dense_rank = 2

/*
For each department, return all employees whose salary falls in the top 3 salary groups of that department.
(If there are ties within the top 3 groups, include them as well.)
*/
WITH CTE AS (SELECT
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() over (PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank_dept
FROM Employees)
SELECT emp_name, dept_id, salary, dense_rank_dept
FROM CTE
WHERE dense_rank_dept IN (1,2,3)