-- 175. Combine Two Tables
SELECT firstName, lastName, city, state 
FROM Person
LEFT JOIN Address
    ON Person.personId = Address.personId

-- 181. Employees Earning More Than Their Managers
SELECT x.name Employee 
FROM employee x 
INNER JOIN employee y 
  ON x.managerId = y.id 
WHERE x.salary > y.salary

-- 182. Duplicate Emails
SELECT email 
FROM Person 
GROUP BY email 
HAVING count(*) > 1

-- 183. Customers Who Never Order
SELECT name Customers 
FROM customers 
LEFT JOIN orders 
  ON customers.id = orders.customerId 
WHERE orders.id IS NULL

-- 196. Delete Duplicate Emails
DELETE p1 
FROM Person p1 
INNER JOIN Person p2 
  ON p1.email = p2.email
WHERE p1.Id > p2.Id

-- 197. Rising Temperature
SELECT with_yest.id
FROM
  (SELECT *, DATE_ADD(recordDate, INTERVAL -1 DAY) AS day_before
  FROM Weather) AS with_yest
  INNER JOIN Weather
      ON with_yest.day_before = Weather.recordDate
WHERE Weather.temperature < with_yest.temperature

-- 584. Find Customer Referee
SELECT name 
FROM customer 
WHERE referee_id <> 2 
  OR referee_id IS NULL
  
-- 586. Customer Placing the Largest Number of Orders
SELECT customer_number
FROM orders 
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1

-- 595. Big Countries
SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 25000000

-- 596. Classes More Than 5 Students
SELECT class 
FROM courses 
GROUP BY class 
HAVING COUNT(student) >= 5

-- 607. Sales Person
SELECT name 
FROM salesperson 
WHERE sales_id NOT IN
  (SELECT sales_id 
  FROM orders 
  WHERE com_id =
    (SELECT com_id 
    FROM company 
    WHERE name = "RED"))
    
-- 620. Not Boring Movies
SELECT *
FROM Cinema
WHERE description <> "boring" 
  AND id % 2 <> 0
ORDER BY rating DESC

-- 627. Swap Salary
UPDATE Salary
SET sex =
    (CASE
        WHEN sex = 'm' Then 'f'
        ELSE 'm'
    END)
    
-- 1050. Actors and Directors Who Cooperated At Least Three Times
SELECT actor_id, director_id
FROM actorDirector
GROUP BY actor_id, director_id
HAVING count(*) >= 3

-- 1084. Sales Analysis III
SELECT product_id, product_name 
FROM product 
WHERE product_id IN
    (SELECT product_id 
     FROM sales 
     GROUP BY product_id 
     HAVING MIN(sale_date)>= '2019-01-01' 
        AND MAX(sale_date)<= '2019-03-31')

-- 511. Game Play Analysis I
SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id

-- 1141. User Activity for the Past 30 Days I
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM activity
GROUP BY activity_date
HAVING activity_date BETWEEN DATE_ADD('2019-07-28', INTERVAL -30 day) AND '2019-07-27'

-- 1148. Article Views I
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY id

-- 1179. Reformat Department Table
SELECT id,
    SUM(CASE WHEN month = "Jan" THEN revenue ELSE NULL END) AS Jan_Revenue,
    SUM(CASE WHEN month = "Feb" THEN revenue ELSE NULL END) AS Feb_Revenue,
    SUM(CASE WHEN month = "Mar" THEN revenue ELSE NULL END) AS Mar_Revenue,
    SUM(CASE WHEN month = "Apr" THEN revenue ELSE NULL END) AS Apr_Revenue,
    SUM(CASE WHEN month = "May" THEN revenue ELSE NULL END) AS May_Revenue,
    SUM(CASE WHEN month = "Jun" THEN revenue ELSE NULL END) AS Jun_Revenue,
    SUM(CASE WHEN month = "Jul" THEN revenue ELSE NULL END) AS Jul_Revenue,
    SUM(CASE WHEN month = "Aug" THEN revenue ELSE NULL END) AS Aug_Revenue,
    SUM(CASE WHEN month = "Sep" THEN revenue ELSE NULL END) AS Sep_Revenue,
    SUM(CASE WHEN month = "Oct" THEN revenue ELSE NULL END) AS Oct_Revenue,
    SUM(CASE WHEN month = "Nov" THEN revenue ELSE NULL END) AS Nov_Revenue,
    SUM(CASE WHEN month = "Dec" THEN revenue ELSE NULL END) AS Dec_Revenue
FROM department
GROUP BY id

-- 1407. Top Travellers
SELECT name, 
  (CASE WHEN SUM(distance) IS NULL THEN 0 ELSE SUM(distance) END) AS travelled_distance
FROM users
LEFT JOIN rides
    ON users.id = rides.user_id
GROUP BY users.id
ORDER BY travelled_distance DESC, name 

-- 1484. Group Sold Products By The Date
SELECT sell_date, count(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product) AS products
FROM activities
GROUP BY sell_date
ORDER BY sell_date

-- 1527. Patients With a Condition
SELECT patient_id, patient_name, conditions
FROM patients
WHERE conditions LIKE 'DIAB1%' 
  OR conditions LIKE '% DIAB1%'
  
-- 1581. Customer Who Visited but Did Not Make Any Transactions
SELECT customer_id, COUNT(visits.visit_id) AS count_no_trans
FROM visits
LEFT JOIN transactions
    ON visits.visit_id = transactions.visit_id
WHERE transactions.visit_id IS NULL
GROUP BY customer_id

-- 1587. Bank Account Summary II
SELECT name, SUM(amount) AS balance
FROM users
INNER JOIN Transactions
    ON users.account = Transactions.account
GROUP BY users.account
HAVING SUM(amount) > 10000

-- 1667. Fix Names in a Table
SELECT user_id, 
    CONCAT(UPPER(SUBSTRING(name,1,1)), LOWER(SUBSTRING(name,2))) AS name 
FROM users
ORDER BY user_id

-- 1693. Daily Leads and Partners
SELECT date_id, make_name, 
    COUNT(distinct lead_id) AS unique_leads, 
    COUNT(distinct partner_id) AS unique_partners
FROM dailySales
GROUP BY date_id, make_name

-- 1729. Find Followers Count
SELECT user_id, COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id

-- 1741. Find Total Time Spent by Each Employee
SELECT event_day AS day, emp_id , 
  ABS(SUM(in_time - out_time)) AS total_time
FROM employees
GROUP BY day, emp_id

-- 1757. Recyclable and Low Fat Products
SELECT product_id
FROM products
WHERE low_fats = 'Y' 
  AND recyclable = 'Y'

-- 1795. Rearrange Products Table
SELECT product_id, 'store1' AS store, store1 AS price FROM products WHERE store1 IS NOT NULL
UNION
SELECT product_id, 'store2' AS store, store2 AS price FROM products WHERE store2 IS NOT NULL
UNION
SELECT product_id, 'store3' AS store, store3 AS price FROM products WHERE store3 IS NOT NULL

-- 1873. Calculate Special Bonus
SELECT employee_id, 
    CASE 
        WHEN (employee_id % 2) != 0 AND name NOT LIKE 'M%' THEN salary
        ELSE 0 
        END AS bonus
FROM employees
ORDER BY employee_id

-- 1890. The Latest Login in 2020
SELECT user_id, MAX(time_stamp) AS last_stamp
FROM logins
WHERE YEAR(time_stamp) = 2020
GROUP BY user_id

-- 1965. Employees With Missing Information
SELECT employee_id FROM
(
    (SELECT employees.employee_id, name, salary 
    FROM employees 
    LEFT JOIN salaries 
        ON employees.employee_id = salaries.employee_id)
    
    UNION
    
    (SELECT salaries.employee_id, name, salary 
    FROM employees 
    RIGHT JOIN salaries 
        ON employees.employee_id = salaries.employee_id)
) AS x
WHERE name IS NULL 
  OR salary IS NULL
ORDER BY employee_id

-- 176. Second Highest Salary
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee)

-- 177. Nth Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      IFNULL(
          (SELECT DISTINCT salary
          FROM
            (SELECT salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk 
             FROM employee) AS ranked
          WHERE rnk = N) , NULL)
  );
END

-- 178. Rank Scores
SELECT score, DENSE_RANK() OVER(ORDER BY score DESC) AS 'rank'
FROM scores

-- 180. Consecutive Numbers
SELECT DISTINCT num AS ConsecutiveNums 
FROM
  (SELECT *, 
     LAG(num,1) OVER() mylag, 
     LEAD(num,1) OVER() mylead
   FROM Logs) AS lag_lead
WHERE num = mylag 
  AND num = mylead
  
-- 184. Department Highest Salary
SELECT max_dept.dept_name AS Department, 
  employee.name AS Employee, 
  employee.salary AS Salary
FROM employee
INNER JOIN 
  (SELECT DISTINCT department.id AS dept_id, 
    department.name AS dept_name, 
    MAX(Salary) OVER(PARTITION BY Department.id) AS max_salary_dept
  FROM employee 
  INNER JOIN department
    ON employee.departmentid = department.id) AS max_dept
  ON employee.salary = max_dept.max_salary_dept AND employee.departmentId = max_dept.dept_id

-- 608. Tree Node
SELECT id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT DISTINCT p_id FROM Tree) THEN 'Inner'
        ELSE 'Leaf'
        END AS type
FROM Tree

-- 626. Exchange Seats
SELECT id,
    IFNULL(CASE
        WHEN id % 2 !=0 THEN LEAD(student,1) OVER()
        ELSE LAG(student,1) OVER()
        END, student) AS student
FROM seat 

-- 1158. Market Analysis I
SELECT u.user_id AS buyer_id, 
  join_date, 
  COUNT(order_date) AS orders_in_2019 
FROM Users AS u
LEFT JOIN Orders AS o
  ON u.user_id = o.buyer_id
    AND YEAR(order_date) = '2019'
GROUP BY u.user_id

-- 1393. Capital Gain/Loss
SELECT DISTINCT stock_name, 
  SUM(price_fixed) OVER(PARTITION BY stock_name) AS capital_gain_loss
FROM 
  (SELECT *,
    CASE
      WHEN operation = 'Buy' THEN -1*price
      ELSE price
    END AS price_fixed
  FROM stocks) AS stocks_with_negative
  
-- 185. Department Top Three Salaries
SELECT dept_name AS Department, 
    name AS Employee,
    salary as Salary
FROM
  (SELECT DISTINCT departmentId, 
    department.name AS dept_name, 
    employee.name, 
    salary, 
    DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS dept_rank
  FROM employee
  INNER JOIN department
    ON employee.departmentId = department.id) AS ranked
WHERE dept_rank IN (1,2,3)

601. Human Traffic of Stadium
SELECT id, visit_date, result AS people
FROM
  (SELECT *,
    CASE 
      WHEN people >= 100 AND LEAD(people,1) OVER() >= 100 AND LEAD(people,2) OVER() >= 100 THEN people
      WHEN people >= 100 AND LEAD(people,1) OVER() >= 100 AND LAG(people,1) OVER() >= 100 THEN people
      WHEN people >= 100 AND LAG(people,1) OVER() >= 100 AND LAG(people,2) OVER() >= 100 THEN people
      WHEN people >= 100 AND LEAD(people,1) OVER() IS NULL AND LAG(people,1) OVER() >= 100 AND LAG(people,2) OVER() >= 100 THEN people
      WHEN people >= 100 AND LEAD(people,2) OVER() IS NULL AND LAG(people,1) OVER() >= 100 AND LAG(people,2) OVER() >= 100 THEN people
      ELSE NULL
    END AS result
  FROM stadium) AS result_sub
WHERE result IS NOT NULL
ORDER BY visit_date
