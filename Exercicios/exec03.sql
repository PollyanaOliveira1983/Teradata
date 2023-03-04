--1.) Use the HELP DATABASE command to find all tables, views, and macros names in the CSViews database. What kind of objects do you find there?

HELP DATABASE CSViews;

--Do a similar HELP command on the CustomerService database. What kind of objects do you find there?

Help Database CustomerService;

--2.) To see the names of the columns in the department table, use the appropriate HELP command. 
--(Since the table is in the CustomerService database, not your default database, you may have to qualify the table name with the database name.) 
--This is the command you may wish to use in the future to research data names.
	
	HELP TABLE CustomerService.department;
	
--3.) In Lab 1 on the previous page, you may have noticed that the CSViews database includes a view called emp.  
--SHOW that view. Notice the list of short names the emp view uses in place of full column names. 
--To save typing, you may use the emp view with the shortened names in place of the employee table in any labs throughout this course. 
--(The lab solutions will use the employee table and not the view.)

SHOW VIEW CSViews.emp;

--4.) Modify Lab 1 from the first module to cause the answer set to appear in department name sequence. 
--To find out how Teradata database plans to handle this request, submit it with EXPLAIN in front of it.

EXPLAIN 
SELECT * 
FROM CustomerService.department
ORDER BY department_name;

--5.) Use the appropriate SHOW command to see the table definition of the employee_phone table in the CustomerService database.

SHOW TABLE CustomerService.employee_phone;

--6.) Use the appropriate HELP command to see what kinds of indexes exist on the customer table. 
--To get information about your session, use another HELP command.

HELP INDEX CustomerService.customer;

HELP SESSION;

--7.) Change your current database setting to CustomerService using the DATABASE command. 
--Try to do a SELECT of all columns and rows in the emp view. Does it work? If not, how can you make it work?

DATABASE CustomerService;
 
SELECT * FROM emp;


-- Dá erro object não existe

--Comando que funciona

SELECT * FROM CSViews.emp;




 
