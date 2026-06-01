-- ============================================================
-- HR Employee Data Analysis
-- Author: Kamala Garayeva
-- Tool: SQL (SQLite-compatible)
-- Dataset: 30 employees across departments
-- ============================================================


-- ============================================================
-- QUERY 1: Total number of employees by department
-- ============================================================
SELECT 
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department
ORDER BY total_employees DESC;

/*
RESULT:
department   | total_employees
-------------|----------------
Engineering  | 8
Sales        | 6
Finance      | 5
HR           | 5
Marketing    | 4  (+ 2 more)
*/


-- ============================================================
-- QUERY 2: Average salary by department
-- ============================================================
SELECT 
    department,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

/*
FINDING: Engineering has the highest average salary.
Finance follows due to senior/CFO roles.
*/


-- ============================================================
-- QUERY 3: Gender distribution across the company
-- ============================================================
SELECT 
    gender,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 1) AS percentage
FROM employees
GROUP BY gender;

/*
FINDING: Identifies gender balance or gap company-wide.
*/


-- ============================================================
-- QUERY 4: Average salary by gender (pay gap analysis)
-- ============================================================
SELECT 
    gender,
    ROUND(AVG(salary), 2) AS avg_salary,
    COUNT(*) AS employee_count
FROM employees
GROUP BY gender
ORDER BY avg_salary DESC;

/*
FINDING: Highlights whether a gender-based pay gap exists.
This is a critical HR equity metric.
*/


-- ============================================================
-- QUERY 5: Top 5 highest paid employees
-- ============================================================
SELECT 
    full_name,
    department,
    job_title,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

/*
FINDING: Identifies highest compensated talent — useful for
retention risk analysis.
*/


-- ============================================================
-- QUERY 6: Employees hired per year (hiring trend)
-- ============================================================
SELECT 
    STRFTIME('%Y', hire_date) AS hire_year,
    COUNT(*) AS new_hires
FROM employees
GROUP BY hire_year
ORDER BY hire_year;

/*
FINDING: Shows hiring trends over time — peak years indicate
growth periods or high-volume recruitment.
*/


-- ============================================================
-- QUERY 7: Employee tenure in years (as of 2025)
-- ============================================================
SELECT 
    full_name,
    department,
    hire_date,
    ROUND((JULIANDAY('2025-06-01') - JULIANDAY(hire_date)) / 365.25, 1) AS tenure_years
FROM employees
ORDER BY tenure_years DESC
LIMIT 10;

/*
FINDING: Long-tenured employees are retention anchors.
Helps identify institutional knowledge holders.
*/


-- ============================================================
-- QUERY 8: Salary above vs below company average
-- ============================================================
SELECT 
    full_name,
    department,
    salary,
    CASE 
        WHEN salary > (SELECT AVG(salary) FROM employees) THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_band
FROM employees
ORDER BY salary DESC;

/*
FINDING: Quick segmentation of workforce by compensation level.
*/


-- ============================================================
-- QUERY 9: Department headcount and salary budget
-- ============================================================
SELECT 
    department,
    COUNT(*) AS headcount,
    SUM(salary) AS total_salary_budget,
    ROUND(AVG(salary), 0) AS avg_salary
FROM employees
GROUP BY department
ORDER BY total_salary_budget DESC;

/*
FINDING: Total salary spend by department — key for budget
planning and cost allocation reporting.
*/


-- ============================================================
-- QUERY 10: Country diversity — how many countries represented?
-- ============================================================
SELECT 
    country,
    COUNT(*) AS employees
FROM employees
GROUP BY country
ORDER BY employees DESC;

/*
FINDING: Shows geographic diversity of workforce.
Important for international remote-first companies.
*/
