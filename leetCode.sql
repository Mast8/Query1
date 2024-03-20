--Find the names of the customer that are not referred by the customer with id = 2.
--Return the result table in any order.
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id is null

--A country is big if:
--it has an area of at least three million (i.e., 3000000 km2), or
--it has a population of at least twenty-five million (i.e., 25000000).
--Write a solution to find the name, population, AND area of the big countries.
SELECT name, population , area 
FROM world WHERE area >=3000000 OR population >=25000000

--Write a solution to find all the authors that viewed at least one of their own articles.
--Return the result table sorted by id in ascending order.

SELECT DISTINCT author_id AS id FROM views WHERE author_id = viewer_id 
order by author_id

--Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number 
--of characters used in the content of the tweet is strictly greater than 15.
--Return the result table in any order.
SELECT tweet_id FROM tweets WHERE LENGTH(content) > 15

--1378 Write a solution to show the unique ID of each user, If a user does not have a unique ID replace 
--just show null.Return the result table in any order.
SELECT unique_id, name FROM employees left JOIN employeeuni ON employees.id = employeeuni.id 

--1068 Write a solution to report the product_name, year, AND price for each sale_id in the Sales table.
--Return the resulting table in any order.
SELECT product_name, year , price FROM sales JOIN product ON sales.product_id = product.product_id 

--1581 Write a solution to find the IDs of the users who visited without making any transactions AND the number of times they made these types of visits.
--Return the result table sorted in any order.
SELECT customer_id, count(customer_id) AS count_no_trans FROM visits left JOIN transactions ON visits.visit_id = transactions.visit_id 
WHERE transaction_id is null 
group by customer_id
order by null

-- 197 Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
--Return the result table in any order.
SELECT w1.id
FROM weather w1, weather w2 
WHERE w1.temperature >w2.temperature 
AND datediff(w1.recordDate, w2.recordDate) =1

/* 1661. Average Time of Process per Machine
There is a factory website that has several machines each running the same number of processes. 
Write a solution to find the average time each machine takes to complete a process.
The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
The average time is calculated by the total time to complete every process on the machine 
divided by the number of processes that were run.
The resulting table should have the machine_id along with the average time as processing_time, 
which should be rounded to 3 decimal places. */

SELECT s.machine_id, ROUND(AVG(e.timestamp-s.timestamp), 3) AS processing_time
FROM Activity s JOIN Activity e ON
    s.machine_id = e.machine_id AND s.process_id = e.process_id AND
    s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY s.machine_id;

/* 577. Employee Bonus
Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
Return the result table in any order. */
select name, bonus from employee e left join bonus b on e.empId = b.empId 
where  bonus is null OR bonus < 1000 

/* 1280. Students and Examinations
Write a solution to find the number of times each student attended each exam.
Return the result table ordered by student_id and subject_name. */

SELECT s.student_id, s.student_name, su.subject_name, 
(SELECT COUNT(1) 
	FROM Examinations 
	
	WHERE student_id = s.student_id 
	AND subject_name = su.subject_name) AS attended_exams
FROM Students s
JOIN Subjects su
 ORDER BY s.student_id, su.subject_name

/*  570. Managers with at Least 5 Direct Reports
 Write a solution to find managers with at least five direct reports.

Return the result table in any order. */
select name
from employee where id in (
select managerId from employee 
group by managerId
having count(managerId) > 4)

/* 1934. Confirmation Rate
The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. 
The confirmation rate of a user that did not request any confirmation messages is 0. 
Round the confirmation rate to two decimal places.
Write a solution to find the confirmation rate of each user. */

select s.user_id,  ROUND(AVG(if(c.action = "confirmed", 1, 0)) , 2) AS confirmation_rate  
from confirmations c right join signups s on c.user_id = s.user_id group by s.user_id

/*620. Not Boring Movies
Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order. */

select id, movie, description ,rating
from cinema c where mod(id,2) = 1 AND description != 'boring'
order by rating desc

/* 1251. Average Selling Price
Write a solution to find the average selling price for each product.
 average_price should be rounded to 2 decimal places.
Return the result table in any order. */
select p.product_id, ifnull(round(sum(units*price)/sum(units),2),0) as average_price
from prices p left join unitssold us on p.product_id = us.product_id 
and us.purchase_date between start_date AND end_date group by product_id

/* 1075. Project Employees I
Write an SQL query that reports the average experience years of all the employees for each project,
 rounded to 2 digits.
Return the result table in any order. */

select project_id , round(avg(experience_years),2) average_years 
from project p left join employee e on p.employee_id = e.employee_id 
group by project_id

/* 1633. Percentage of Users Attended a Contest
Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
Return the result table ordered by percentage in descending order. In case of a tie, 
order it by contest_id in ascending order. */

select contest_id, round(count(user_id)*100.00/(select count(*) from users),2) as percentage
from register
group by contest_id  
order by percentage desc, contest_id

/* 1211. Queries Quality and Percentage
We define query quality as:
The average of the ratio between query rating and its position.
We also define poor query percentage as:
The percentage of all queries with rating less than 3.
Write a solution to find each query_name, the quality and poor_query_percentage.
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order. */
select query_name, round(sum(rating/position)/count(query_name) ,2) as quality
,ROUND(AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END)*100,2) as poor_query_percentage 
from queries 
where query_name is not null
group by query_name

/* 1193. Monthly Transactions I
Write an SQL query to find for each month and country, the number of transactions and 
their total amount, the number of approved transactions and their total amount.
Return the result table in any order. */
select Date_format(trans_date, '%Y-%m')  as month, country,
 count(state) trans_count, count(if(state='approved',1,null)) approved_count, 
 sum(amount) trans_total_amount, 
 SUM(IF(state = 'approved', amount, 0)) as approved_total_amount from transactions
group by country, month

/* 2356. Number of Unique Subjects Taught by Each Teacher
Write a solution to calculate the number of unique subjects each teacher teaches in the university.
Return the result table in any order. */
select teacher_id , count(distinct subject_id) cnt from teacher
group by teacher_id

/* 1141. User Activity for the Past 30 Days I
Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively.
 A user was active on someday if they made at least one activity on that day.
Return the result table in any order. */

select activity_date as day , count(distinct user_id) as active_users 
from activity
WHERE (activity_date > "2019-06-27" AND activity_date <= "2019-07-27") 
group by activity_date

/* 1070. Product Sales Analysis III
Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
Return the resulting table in any order. */

select product_id, year as first_year, quantity, price from sales  
where (product_id, year) in (
    select product_id, min(year)
    from sales
    group by product_id 
)

/* 596. Classes More Than 5 Students
Write a solution to find all the classes that have at least five students.
Return the result table in any order. */
select class from courses   group by class having count(student)> 4

/* 1729. Find Followers Count
Write a solution that will, for each user, return the number of followers.
Return the result table ordered by user_id in ascending order. */

select user_id, count(follower_id) as followers_count from followers group by user_id order by user_id

6/* 19. Biggest Single Number
A single number is a number that appeared only once in the MyNumbers table.
Find the largest single number. If there is no single number, report null. */
select max(num) as num from (
    select num from mynumbers  group by num having count(*) = 1
) as nums

/* 1731. The Number of Employees Which Report to Each Employee
For this problem, we will consider a manager an employee who has at least 1 other employee reporting 
to them. Write a solution to report the ids and the names of all managers, the number of employees 
who report directly to them, and the average age of the reports rounded to the nearest integer.
Return the result table ordered by employee_id. */

SELECT
    m.employee_id,
    m.name,
    count(e.reports_to) AS reports_count,
    round(avg(e.age)) AS average_age
FROM
    Employees e
    JOIN Employees m ON e.reports_to = m.employee_id
GROUP BY
    m.employee_id
ORDER BY
    m.employee_id;

/* 610. Triangle Judgement
Report for every three line segments whether they can form a triangle.
Return the result table in any order. */
select x, y,z,
if(x+y > z and y+z > x and z+x > y, "Yes","No") as triangle
from triangle 

/* 1978. Employees Whose Manager Left the Company
Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted 
from the Employees table, but the reports still have their manager_id set to the manager that left.
Return the result table ordered by employee_id. */

select employee_id from employees where salary < 30000 and manager_id not in( select employee_id from employees)
order by employee_id 

/* 1341. Movie Rating
Find the name of the user who has rated the greatest number of movies. 
In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. 
In case of a tie, return the lexicographically smaller movie name. */

(SELECT name AS results
FROM MovieRating JOIN Users USING(user_id)
GROUP BY name
ORDER BY COUNT(*) desc, name
LIMIT 1)

UNION ALL

(select title as results from movierating join movies using(movie_id) 
where extract(Year_month from created_at) = 202002
group by title
order by avg(rating) desc,title
limit 1)