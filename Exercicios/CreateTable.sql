database CostumerService;

CREATE SET TABLE agent_sales ,NO FALLBACK ,
 NO BEFORE JOURNAL,
 NO AFTER JOURNAL
 (
 agent_id INTEGER,
 sales_amt INTEGER)
UNIQUE PRIMARY INDEX ( agent_id );

CREATE TABLE clob_files
 (Id INTEGER NOT NULL,
 text_file CLOB(10000))
UNIQUE PRIMARY INDEX ( Id );

CREATE TABLE contact, FALLBACK
 (contact_number INTEGER
 ,contact_name CHAR(30) NOT NULL
 ,area_code SMALLINT NOT NULL
 ,phone INTEGER NOT NULL
 ,extension INTEGER
 ,last_call_date DATE NOT NULL)
 UNIQUE PRIMARY INDEX (contact_number);
 
CREATE TABLE customer, FALLBACK
 (customer_number INTEGER
 ,customer_name CHAR(30) NOT NULL
 ,parent_customer_number INTEGER
 ,sales_employee_number INTEGER
 )
 UNIQUE PRIMARY INDEX (customer_number);
 
CREATE SET TABLE daily_sales
,NO FALLBACK ,
 NO BEFORE JOURNAL,
 NO AFTER JOURNAL
 (
 itemid INTEGER,
 salesdate DATE FORMAT 'YY/MM/DD',
 sales DECIMAL(9,2))
PRIMARY INDEX ( itemid );

2

CREATE SET TABLE daily_sales_2014
,NO FALLBACK ,
 NO BEFORE JOURNAL,
 NO AFTER JOURNAL
 (
 itemid INTEGER,
 salesdate DATE FORMAT 'YY/MM/DD',
 sales DECIMAL(9,2))
PRIMARY INDEX ( itemid );

CREATE TABLE department, FALLBACK
 (department_number SMALLINT
 ,department_name CHAR(30) NOT NULL
 ,budget_amount DECIMAL(10,2)
 ,manager_employee_number INTEGER
 )
 UNIQUE PRIMARY INDEX (department_number)
 ,UNIQUE INDEX (department_name);
 
CREATE TABLE employee, FALLBACK
 (employee_number INTEGER
 ,manager_employee_number INTEGER
 ,department_number INTEGER
 ,job_code INTEGER
 ,last_name CHAR(20) NOT NULL
 ,first_name VARCHAR(30) NOT NULL
 ,hire_date DATE NOT NULL
 ,birthdate DATE NOT NULL
 ,salary_amount DECIMAL(10,2) NOT NULL
 )
 UNIQUE PRIMARY INDEX (employee_number);
 
CREATE TABLE employee_phone, FALLBACK
 (employee_number INTEGER NOT NULL
 ,area_code SMALLINT NOT NULL
 ,phone INTEGER NOT NULL
 ,extension INTEGER
 ,comment_line CHAR(72)
 )
 PRIMARY INDEX (employee_number);
 
CREATE SET TABLE Jan_sales
,NO FALLBACK ,
 NO BEFORE JOURNAL,
 NO AFTER JOURNAL
 (
 itemid INTEGER,
 salesdate DATE FORMAT 'YY/MM/DD',
 sales DECIMAL(9,2))
PRIMARY INDEX ( itemid );

3
CREATE TABLE job, FALLBACK
 (job_code INTEGER
 ,description VARCHAR(40) NOT NULL
 ,hourly_billing_rate DECIMAL(6,2)
 ,hourly_cost_rate DECIMAL(6,2)
 )
 UNIQUE PRIMARY INDEX (job_code)
 ,UNIQUE INDEX (description);
 
CREATE TABLE location, FALLBACK
 (location_number INTEGER
 ,customer_number INTEGER NOT NULL
 ,first_address_line CHAR(30) NOT NULL
 ,city VARCHAR(30) NOT NULL
 ,state CHAR(15) NOT NULL
 ,zip_code INTEGER NOT NULL
 ,second_address_line CHAR(30)
 ,third_address_line CHAR(30)
 )
 PRIMARY INDEX (customer_number);
 
CREATE TABLE location_employee, FALLBACK
 (location_number INTEGER NOT NULL
 ,employee_number INTEGER NOT NULL
 )
 PRIMARY INDEX (employee_number);
 
CREATE TABLE location_phone, FALLBACK
 (location_number INTEGER
 ,area_code SMALLINT NOT NULL
 ,phone INTEGER NOT NULL
 ,extension INTEGER
 ,description VARCHAR(40) NOT NULL
 ,comment_line LONG VARCHAR
 )
 PRIMARY INDEX (location_number);
 
CREATE TABLE phonelist
 ( LastName CHAR(20),
 FirstName CHAR(20),
 Number CHAR(12) NOT NULL,
 Photo BLOB(10000))
UNIQUE PRIMARY INDEX ( Number );

CREATE TABLE repair_time
( serial_number INTEGER
,product_desc CHAR(8)
,start_time TIMESTAMP(0)
,end_time TIMESTAMP(0))
UNIQUE PRIMARY INDEX (serial_number);

4
CREATE SET TABLE salestbl
,NO FALLBACK ,
 NO BEFORE JOURNAL,
 NO AFTER JOURNAL
 (
 storeid INTEGER,
 prodid CHAR(1),
 sales DECIMAL(9,2))
PRIMARY INDEX ( storeid );

CREATE TABLE country_sales (
country VARCHAR(50),
yr INTEGER,
quarter CHAR(2),
sales INTEGER )
PRIMARY INDEX (country);