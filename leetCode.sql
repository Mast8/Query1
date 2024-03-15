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