-- Table: Employees
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | name        | varchar |
-- +-------------+---------+
-- employee_id is the column with unique values for this table.
-- Each row of this table indicates the name of the employee whose ID is employee_id.
--  

-- Table: Salaries
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | salary      | int     |
-- +-------------+---------+
-- employee_id is the column with unique values for this table.
-- Each row of this table indicates the salary of the employee whose ID is employee_id.
--  

-- Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:
-- The employee's name is missing, or
-- The employee's salary is missing.
-- Return the result table ordered by employee_id in ascending order.
-- The result format is in the following example.

--  

-- Example 1:

-- Input: 
-- Employees table:
-- +-------------+----------+
-- | employee_id | name     |
-- +-------------+----------+
-- | 2           | Crew     |
-- | 4           | Haven    |
-- | 5           | Kristian |
-- +-------------+----------+
-- Salaries table:
-- +-------------+--------+
-- | employee_id | salary |
-- +-------------+--------+
-- | 5           | 76071  |
-- | 1           | 22517  |
-- | 4           | 63539  |
-- +-------------+--------+

-- Solution:

select employee_id
from (select e.employee_id,
           CASE WHEN e.name IS NOT NULL THEN 0 ELSE 1 END as check1,
           CASE WHEN s.salary IS NOT NULL THEN 0 ELSE 1 END as check2
    from Employees e
    left join Salaries s on e.employee_id = s.employee_id
    
    UNION
    
    select s.employee_id,
           CASE WHEN e.name IS NOT NULL THEN 0 ELSE 1 END as check1,
           CASE WHEN s.salary IS NOT NULL THEN 0 ELSE 1 END as check2
    from Employees e
    right join Salaries s on e.employee_id = s.employee_id
    where e.employee_id IS NULL) as merged_data
where check1 = 1 or check2 = 1
order by employee_id

-- Output: 
-- +-------------+
-- | employee_id |
-- +-------------+
-- | 1           |
-- | 2           |
-- +-------------+
-- Explanation: 
-- Employees 1, 2, 4, and 5 are working at this company.
-- The name of employee 1 is missing.
-- The salary of employee 2 is missing.