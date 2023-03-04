--1) Testar as funções listadas abaixo. Como sugestão, fazer selects do tipo:

SELECT first_name, length(first_name) FROM customerservice.employee;

SELECT last_name, length(last_name) FROM customerservice.employee;

SELECT length('Capgemini'), length('uma frase um pouco mais longa');

--2) Usando as funções que acharem mais apropriadas (vistas no curso ou acima), selecionar:
-- Último dia do mês anterior

SELECT CURRENT_DATE - 30;

SELECT LAST_DAY(ADD_MONTHS(DATE, -1));

-- Primeiro dia do mês atual

SELECT CURRENT_DATE - 27;
 
-- Primeiro dia do mês anterior

SELECT ADD_MONTHS(CURRENT_DATE - EXTRACT(DAY FROM CURRENT_DATE)+1, -1);

-- Último dia do mês atual 
SELECT  LAST_DAY (CURRENT_DATE);
SELECT  LAST_DAY ( DATE  '2023-02-28' );