--1.) In a single SELECT statement, display the current DATE, TIME and USER.

SELECT Date
	, Time
	, User
;

--2.) Display the date 365 days from today.

SELECT CURRENT_DATE + 365;

-- 3.) Create a report that gives the literal value "Math Function" as its first column, 
--the numeric value 1 as its second column, and the calculation 2*3+4*5 as its third column. Note the results.

Select 'Mat Function'
	,1
	,((2*3)+(4*5))
;

--4.) Modify #3 request to include parentheses around the 3+4. Resubmit the request. Note the difference in the result.

Select 'Mat Function'
	,1
	,2*(3+4)*5
;

--5.) Some employees are getting raises. The department 401 manager is interested in what salaries would be if each 
--employee received a 10 percent increase. List the first 10 characters of the last name, current salary, 
--and salary after the raise for the employees in department 401. Rank them in descending order by salary.

database CustomerService;

Select Cast (last_name as CHAR(10))
	,salary_amount
	,salary_amount * 1.1
FROM employee
Where department_number = 401
Order By salary_amount DESC
;

--

EXPLAIN 
SELECT * 
FROM CustomerService.employee
;

--6.) The results of exercise #5 left management a bit shaken. They are considering instead a flat $500.00 
--per employee raise. Modify the query to include this new estimated salary as well as the 10% increase for comparison. 
--Include an additional column that tells the net difference in dollars between the two options for each employee. 
--Rename this computed column by inserting the two words AS Difference following the computation. 
--Take the current salary column out of the report.

Select Cast (last_name as CHAR(10))
    ,salary_amount
    ,salary_amount * 1.1
    ,salary_amount + 500
    , (salary_amount*1.1)- (salary_amount+500) AS Difference	
FROM CustomerService.employee
Where department_number = 401
Order By salary_amount DESC
;

--7.) The government has ordered a special employment demographics study. Generate a list of all employees under 60 years old.
--Include last name (CAST the first ten characters only), department number and computed age in years. 
--Sort so that the youngest employees are listed first.

SELECT *FROM CustomerService.employee;

Select Cast (last_name as CHAR(10))
	,department_number
	,(DATE-birthdate)/365
FROM CustomerService.employee
Where (DATE-birthdate)/365 < 60
Order By birthdate DESC
;
