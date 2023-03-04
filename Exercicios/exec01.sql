database CostumerService;

--SET SESSION DATABASE CustomerService;

-- Exec 1
SELECT   *
FROM  CustomerService.department;

-- Exec 2
SELECT last_name, first_name, salary_amount
FROM CustomerService.employee
WHERE manager_employee_number = 1019
ORDER BY last_name;

-- Exec 3
SELECT last_name, department_number, salary_amount
FROM CustomerService.employee
WHERE manager_employee_number = 801
ORDER BY last_name;

-- Exec 4

SELECT department_number, manager_employee_number
FROM CustomerService.employee;

SELECT  Distinct department_number, manager_employee_number
FROM CustomerService.employee;
