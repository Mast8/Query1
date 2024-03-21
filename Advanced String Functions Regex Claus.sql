/* 1667. Fix Names in a Table
Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id. */

select user_id, concat(upper(substr(name,1,1)),lower(substr(name,2,length(name)))) as name from users
order by user_id

/* 1527. Patients With a Condition
Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. 
Type I Diabetes always starts with DIAB1 prefix.
Return the result table in any order. */

select patient_id, patient_name, conditions
from patients where conditions like "% DIAB1%" OR conditions like "DIAB1%"

/* 196. Delete Duplicate Emails
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one. */

delete P1 from person p1, person p2 where p1.email =p2.email and p1.id>p2.id

/* 176. Second Highest Salary
Write a solution to find the second highest salary from the Employee table.
 If there is no second highest salary, return null */

select  mAX(SALARY) as secondHighestSalary froM employee 
where SALARY not in (select max(salary) from employee)

/* 1484. Group Sold Products By The Date
Write a solution to find for each date the number of different products sold and their names.
The sold products names for each date should be sorted lexicographically.
Return the result table ordered by sell_date. */

select sell_date, count(distinct product) as num_sold, 
GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') as products 
from activities group by sell_date

/* 1327. List the Products Ordered in a Period
Write a solution to get the names of products 
that have at least 100 units ordered in February 2020 and their amount.
Return the result table in any order. */

select product_name, sum(unit) as unit
from products join orders o using(product_id)
where yEAR(o.order_date)='2020' AND MONTH(o.order_date)='02'
group by product_id
having sum(unit) > 99 

/* 1517. Find Users With Valid E-Mails
Write a solution to find the users who have valid emails.
A valid e-mail has a prefix name and a domain where:
The prefix name is a string that may contain letters (upper or lower case), 
digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'. */

select * from users
 where mail regexp '^[A-Za-z][A-Za-z0-9_\.\-]*@leetcode(\\?com)?\\.com$';
