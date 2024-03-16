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