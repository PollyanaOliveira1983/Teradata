show table CustomerService.employee;

Help Database CustomerService;

HELP TABLE CustomerService.employee;

HELP SESSION;

SHOW TABLE contact;

show table CustomerService.employee;

CREATE SET TABLE CustomerService.employee , Fallback , 
	NO BEFORE JOURNAL,
	NO AFTER JOURNAL,
	CHECKSUM = DEFAULT,
	DEFAULT MERGEBLOCKRATIO
	(
		employee_numner INTEGER,
		manager_employee_number INTEGER,
		department_number INTEGER,
		job_code INTEGER,
		last_name CHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
		first_name VARCHAR(30) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
		hire_date DATE FORMAT 'YY/MM/DD' NOT NULL,
		birth_date DATE FORMAT 'YY/MM/DD' NOT NULL,
		salary_amount DECIMAL(10,2) NOT NULL)
	UNIQUE PRIMARY INDEX (employee_number);
	
	SHOW VIEW dept;
	
	CREATE VIEW dept
	 (dept_num
	  ,dept_name
	  ,dept_name
	  ,budget
	  ,manager)
	 AS
	 SELECT
	 department_number
	  ,department_name
	  ,budget_amount
	  ,manager_employee_number
	FROM CUSTOMERSERVICE.department;
	
	SHOW MACRO get_depts;
	
	CREATE MACRO get_depts
	AS (SELECT department_numner
				,department_name
				,budget_amount
				,manager_employee_number
	FROM department;			
	);
	
	EXPLAIN SELECT * FROM department;