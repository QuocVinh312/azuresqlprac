/* CTE*/

/* Practice Question 1
Problem: Find all employees who earn more than 5000.
Requirements:

Create a CTE named high_earners that selects all employees with salary > 5000
In your main query, select all columns from the CTE
Order the results by salary in descending order

Expected columns in output: emp_id, emp_name, dept_id, salary
*/
WITH CTE AS (
    SELECT
        Employees.emp_id,
        Employees.emp_name,
        Employees.dept_id,
        Employees.salary
    FROM Employees
    WHERE salary > 5000
)
SELECT emp_id, emp_name, dept_id, salary
FROM CTE
/* Practice Question 2
Problem: Find all employees from department 2 who have names starting with the letter 'D' or later in the alphabet (D, E, F, G, etc.).
Requirements:

Create a CTE named dept2_employees
Filter for employees in department 2 whose names start with 'D' or any letter that comes after 'D' alphabetically
In your main query, display emp_id, emp_name, and salary
Sort the results by emp_name alphabetically

Expected columns in output: emp_id, emp_name, salary
*/
SELECT
    emp_id,
    emp_name,
    salary
FROM Employees
WHERE emp_name LIKE 'D%'
ORDER BY emp_name


/* Practice Question 3
Problem: Find all employees whose salary is between 4000 and 5000 (inclusive) and who work in either department 1 or department 4.
Requirements:

Create a CTE named mid_range_salaries
Filter for employees with salaries between 4000 and 5000 (both values included)
Filter for employees in department 1 OR department 4
In your main query, display all columns
Sort by department (ascending), then by salary (descending)

Expected columns in output: emp_id, emp_name, dept_id, salary
*/
WITH CTE AS (
SELECT
    emp_id,
    emp_name,
    dept_id,
    salary
FROM Employees
WHERE salary BETWEEN 4000 AND 5000 AND dept_id IN (1,4))

SELECT
    emp_id,
    emp_name,
    dept_id,
    salary
FROM Employees
ORDER BY dept_id ASC, salary DESC
/* Practice Question 4
Problem: Find the employee with the highest salary in department 3.
Requirements:

Create a CTE named dept3_max_salary that finds the maximum salary in department 3
In your main query, join this CTE with the Employees table to get the complete employee details who has that maximum salary
Display emp_id, emp_name, dept_id, and salary

Expected columns in output: emp_id, emp_name, dept_id, salary
*/

WITH dept3_max_salary AS (SELECT
    emp_id,
    emp_name,
    dept_id,
    salary
FROM Employees
WHERE dept_id = 3 AND salary = (SELECT MAX(salary) FROM Employees WHERE dept_id = 3)
)

SELECT
    emp_id,
    emp_name,
    dept_id,
    salary
FROM dept3_max_salary





/*
Practice Question 5
Problem: Calculate the average salary for each department and then find all employees who earn
more than their department's average salary.
Requirements:

Create a CTE named dept_avg_salaries that calculates the average salary for each department
In your main query, join this CTE with the Employees table
Filter for employees whose salary is greater than their department's average
Display emp_id, emp_name, dept_id, salary, and the department's average salary (you can name it avg_dept_salary)
Sort by dept_id ascending, then by salary descending

Expected columns in output: emp_id, emp_name, dept_id, salary, avg_dept_salary
*/

WITH avg_dept AS (
SELECT
    dept_id,
    AVG(salary) AS avg_dept_salary
FROM Employees
GROUP BY dept_id
),
emp_avg AS (
SELECT
    emp_id,
    emp_name,
    Employees.dept_id,
    salary,
    avg_dept_salary
FROM Employees JOIN avg_dept ON Employees.dept_id = avg_dept.dept_id AND salary > avg_dept_salary
)
SELECT
    emp_id,
    emp_name,
    dept_id,
    salary,
    avg_dept_salary
FROM emp_avg
ORDER BY dept_id ASC, salary DESC


/*
Practice Question 6
Problem: Find all employees who earn exactly the same salary as at least one other employee in a different department.
Requirements:

Create a CTE named salary_counts that counts how many employees have each salary amount across all departments
In your main query, find employees whose salary appears more than once in the entire company
Display emp_id, emp_name, dept_id, and salary
Sort by salary descending, then by emp_name ascending

Expected columns in output: emp_id, emp_name, dept_id, salary
*/
WITH CTE AS
(SELECT
    salary,
    COUNT(salary) AS salary_count
FROM Employees
GROUP BY salary)
SELECT
    Employees.emp_id,
    Employees.emp_name,
    Employees.salary,
    salary_count
FROM Employees JOIN CTE ON Employees.salary = CTE.salary AND salary_count >= 2
/*
Practice Question 7
Problem: Find the second highest salary in each department.
Requirements:
Create a CTE named dept_salary_ranks that assigns a rank to each salary within each department
(highest salary gets rank 1, second highest gets rank 2, etc.)
Use the DENSE_RANK() window function
In your main query, filter for only the rows where the rank is 2
Display dept_id and the second highest salary (you can name it second_highest_salary)
Sort by dept_id ascending

Expected columns in output: dept_id, second_highest_salary
Hint: You'll need to use PARTITION BY with the window function.
*/

WITH dept_salary_ranks AS (
    SELECT
        emp_id,
        emp_name,
        dept_id,
        salary,
        DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rank_dept_salary
    FROM Employees
)
SELECT
    emp_id,
    emp_name,
    dept_id,
    salary,
    rank_dept_salary AS second_highest_salary
FROM dept_salary_ranks
WHERE rank_dept_salary = 2
ORDER BY dept_id ASC
/*
Practice Question 8
Problem: Find employees who earn more than the average salary of the entire company.
Requirements:

Create a CTE named company_avg that calculates the overall average salary across all employees (just one number for the whole company)
In your main query, select employees whose salary is greater than this company average
Display emp_id, emp_name, dept_id, salary, and the company average (name it company_avg_salary)
Sort by salary descending

Expected columns in output: emp_id, emp_name, dept_id, salary, company_avg_salary
*/

WITH avg_emp AS (
    SELECT
        emp_id,
        emp_name,
        dept_id,
        salary,
        (SELECT AVG(salary) FROM Employees) AS company_avg_salary
    FROM Employees
)
SELECT
    emp_id,
    emp_name,
    dept_id,
    salary,
    company_avg_salary
FROM avg_emp
WHERE salary > company_avg_salary
/*
Practice Question 9
Problem: Find the total number of employees and total salary expenditure for each department,
but only show departments where the total salary expenditure exceeds 25000.
Requirements:

Create a CTE named dept_summary that calculates the count of employees and sum of salaries for each department
In your main query, filter for departments where total salary is greater than 25000
Display dept_id, total number of employees (name it employee_count), and total salary (name it total_salary)
Sort by total_salary descending

Expected columns in output: dept_id, employee_count, total_salary
# */
WITH dept_summary AS (
SELECT
    dept_id,
    COUNT(emp_id) AS employee_count,
    SUM(salary) AS total_salary
FROM Employees
GROUP BY dept_id
)
SELECT
    dept_id,
    employee_count,
    total_salary
FROM dept_summary
WHERE total_salary > 25000

/*
Practice Question 10
Problem: Find all employees whose salary is higher than the average salary of their own department.
Requirements:

Create a CTE named dept_averages that calculates the average salary for each department
In your main query, join with the employees table and filter for employees whose salary exceeds their department's average
Display emp_id, emp_name, dept_id, employee's salary, and their department's average salary (name it dept_avg_salary)
Sort by dept_id ascending, then by salary descending

Expected columns in output: emp_id, emp_name, dept_id, salary, dept_avg_salary
*/
WITH dept_averages AS (
    SELECT
        dept_id,
        AVG(salary) AS dept_avg_salary
    FROM Employees
    GROUP BY 1
)
SELECT
    emp_id,
    emp_name,
    Employees.dept_id,
    salary,
    dept_avg_salary
FROM Employees JOIN dept_averages ON Employees.dept_id = dept_averages.dept_id
WHERE salary > dept_avg_salary



/*
Practice Question 11 (Intermediate – CTE + Aggregation)
Find departments where the average salary is greater than 6000, then list all employees in those departments.
Requirements:
Create a CTE named high_avg_departments
Compute average salary per department
Keep only departments with avg salary > 6000
In the main query, return employees from those departments
Output columns: emp_id, emp_name, dept_id, salary
Order by dept_id ASC, salary DESC
*/
WITH high_avg_departments AS (
    SELECT
        dept_id,
        AVG(salary) AS high_avg_dept
    FROM Employees
    GROUP BY 1
    HAVING high_avg_dept > 6000
)
SELECT
    emp_id,
    emp_name,
    Employees.dept_id,
    salary,
    high_avg_dept
FROM Employees JOIN high_avg_departments ON Employees.dept_id = high_avg_departments.dept_id
ORDER BY dept_id ASC, salary DESC

/* Practice Question 12 (Next Level – CTE + Ranking Concept)
Problem:
For each department, find employees who earn the highest salary in that department.
Rules:
Use one CTE
The CTE should help identify the top salary per department
Final output should show only employees who match that top salary
Output columns: emp_id, emp_name, dept_id, salary
*/

WITH CTE AS (
    SELECT
        dept_id,
        MAX(salary) AS dept_max_salary
    FROM Employees
    GROUP BY 1
)
SELECT
    emp_id,
    emp_name,
    Employees.dept_id,
    salary
FROM Employees JOIN CTE ON Employees.dept_id = CTE.dept_id AND salary = dept_max_salary
/*
Practice Question 13 (same question, rewritten in your preferred style):
Problem: Return employees who earn more than their own department’s average salary,
 but only include departments that have 5 or more employees.
Requirements:
Use CTEs to (1) identify departments with at least 5 employees, and (2) compute department average salaries
Final output columns: emp_id, emp_name, dept_id, salary
Display results grouped by department, and within each department show higher salaries before lower salaries
*/
WITH dept_summary AS (
    SELECT
        dept_id,
        AVG(salary) AS dept_avg_salary,
        COUNT(emp_id) AS dept_total_employees
    FROM Employees
    GROUP BY 1
    HAVING dept_total_employees >= 5
)
SELECT
    emp_id,
    emp_name,
    Employees.dept_id,
    salary
FROM Employees JOIN dept_summary ON Employees.dept_id = dept_summary.dept_id AND salary > dept_avg_salary

