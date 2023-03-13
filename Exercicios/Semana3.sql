Tarefas
1.	Para todo valor da coluna tz dentro do intervalo [−7,−5], substitua o valor na coluna dst pelo horário de verão US/Canada. Não atualizar a coluna quando não for necessário.

--51 linhas afetadas
update airports set dst = 'A' 
where airports.tz between -7 and -5
and dst <> 'A';

------------------------------------------------------------------------------------------------

2.	Para todo valor da coluna dst que seja igual a U, substitua por A.

--8 linhas afetadas
update airports set dst = 'A' 
where dst = 'U';


------------------------------------------------------------------------------------------------


3.	Crie a coluna region e atribua os valores de acordo com as condições abaixo:

alter table airports
add region VARCHAR(20);

select lon, name, lat,
    case
        when lon < -124 then 'ALaska'
        when lon > -50 and lat < 24 then 'OFFSHORE'
        when lon <= -95 then 'WEST'
        when lon > -95 then 'EAST'
        else 'NAN'
    end as longitude
from airports
where lon between -124 and -50
;


select * from airports where lat < 24;

Obs: a região principal dos EUA está no intervalo de longitude [−124,−50]
ALASKA : Quando a longitude for menor que -124.
OFFSHORE : Quando a longitude for maior que -50 ou a latitude for menor que 24.
WEST : Quando a longitude for menor ou igual -95 na região principal dos EUA.
EAST : Quando a longitude for maior que -95 na região principal dos EUA.
NaN : Caso não atenda nenhuma das condições acima.
Consultar a frequência dos valores do novo campo (contagem de cada valor).
 --ALASKA 261
--EAST 696
--OFFSHORE 4
--WEST 436

update airports set region =
(
    case
        when lon < -124 then 'ALaska'
        when lon > -50 and lat < 24 then 'OFFSHORE'
        when lon <= -95 then 'WEST'
        when lon > -95 then 'EAST'
        else 'NAN'
    end
    )
where lon between -124 and -50

--1132 alteraçoes


SELECT region, COUNT(*)
FROM airports
GROUP BY region;


select region from airports;

------------------------------------------------------------------------------------------------

4.	Crie a coluna tipo e atribua os valores a partir de subtrings identificadas na coluna name de acordo com as condições abaixo:

select * from airports;

alter table airports
add military CHAR(5);


SELECT region, COUNT(*) as frequencia
FROM airports
GROUP BY region;


Obs: a prioridade das correspondências deve ser a mesma listada abaixo. Por exemplo, caso seja identificado "Airport" e "Field" na mesma string, o valor atribuido deve ser AP.
AP : "Airport", "Tradeport", "Heliport", "Airpor", ou "Arpt"
AD : "Aerodrome"
AK : "Airpark" ou "Aero Park"
AS : "Station" ou "Air Station"
FL : "Field" ou "Fld"
NaN : Caso não atenda nenhuma das condições acima.
Consultar a frequência dos valores do novo campo.

Select name, tipo,
(
	case
	  WHEN name LIKE '%Airport%' OR name LIKE '%Tradeport%' OR name LIKE '%Heliport%' OR name LIKE '%Airpor%' OR name LIKE '%Arpt%' THEN 'AP'
        WHEN name LIKE '%Aerodrome%' THEN 'AD'
        WHEN name LIKE '%Airpark%' OR name LIKE '%Aero Park%' THEN 'AK'
        WHEN name LIKE '%Station%' OR name LIKE '%Air Station%' THEN 'AS'
        WHEN name LIKE '%Field%' OR name LIKE '%Fld%' THEN 'FL'
        ELSE 'NaN'
	END
)	
from airports;

UPDATE airports SET tipo =
(
	CASE 
	  WHEN name LIKE '%Airport%' OR name LIKE '%Tradeport%' OR name LIKE '%Heliport%' OR name LIKE '%Airpor%' OR name LIKE '%Arpt%' THEN 'AP'
        WHEN name LIKE '%Aerodrome%' THEN 'AD'
        WHEN name LIKE '%Airpark%' OR name LIKE '%Aero Park%' THEN 'AK'
        WHEN name LIKE '%Station%' OR name LIKE '%Air Station%' THEN 'AS'
        WHEN name LIKE '%Field%' OR name LIKE '%Fld%' THEN 'FL'
        ELSE 'NaN'
	END
)
;
--1397
SELECT tipo, COUNT(*) as frequencia
FROM airports
GROUP BY tipo;



---------------------or----------------------------


UPDATE airportsSET tipo = CASE
WHEN name LIKE ANY('%Airport%', '%Tradeport%', '%Heliport%', '%Airpor%', '%Arpt%') THEN 'AP'
WHEN name LIKE '%Aerodrome%' AND tipo <> 'AP' THEN 'AD'
WHEN name LIKE ANY('%Airpark%', '%Aero Park%') AND tipo NOT IN('AP', 'AD') THEN 'AK'
WHEN name LIKE ANY('%Station%', '%Air Station%') AND tipo NOT IN('AP', 'AD', 'AK') THEN 'AS'
WHEN name LIKE ANY('%Field%', '%Fld%') AND tipo NOT IN('AP', 'AD', 'AK', 'AS') THEN 'FL'
ELSE 'NaN'
END;

------------------------------------------------------------------------------------------------


5.	Crie a coluna military e atribua os valores a partir de subtrings identificadas ao final da coluna name de acordo com as condições abaixo:

DELETE FROM flights 
WHERE (mes) = 12;


alter table airports
add military CHAR(8);

Y: "Base", "Aaf", "AFs", "Ahp", "Afb", "LRRS", "Lrrs", "Arb", "Naf", "NAS", "Nas", "Jrb", "Ns", "As", "Cgas", "Angb".
N: Caso nenhuma substring acima seja identificada.
Consultar a frequência dos valores do novo campo.


select * from airports;


----1397
select name, military,
(
	CASE 
	    WHEN name LIKE '%Base' THEN 'Y'
	    WHEN name LIKE '%Aaf' THEN 'Y'
	    WHEN name LIKE '%AFs' THEN 'Y'
	    WHEN name LIKE '%Ahp' THEN 'Y'
	    WHEN name LIKE '%Afb' THEN 'Y'
	    WHEN name LIKE '%LRRS' THEN 'Y'
	    WHEN name LIKE '%Lrrs' THEN 'Y'
	    WHEN name LIKE '%Arb' THEN 'Y'
	    WHEN name LIKE '%Naf' THEN 'Y'
	    WHEN name LIKE '%NAS' THEN 'Y'
	    WHEN name LIKE '%Nas' THEN 'Y'
	    WHEN name LIKE '%Jrb' THEN 'Y'
	    WHEN name LIKE '%Ns' THEN 'Y'
	    WHEN name LIKE '%As' THEN 'Y'
	    WHEN name LIKE '%Cgas' THEN 'Y'
	    WHEN name LIKE '%Angb' THEN 'Y'
	    ELSE 'N'
  END
)
from airports;

update airports set military =
(
	CASE 
	    WHEN name LIKE '%Base' THEN 'Y'
	    WHEN name LIKE '%Aaf' THEN 'Y'
	    WHEN name LIKE '%AFs' THEN 'Y'
	    WHEN name LIKE '%Ahp' THEN 'Y'
	    WHEN name LIKE '%Afb' THEN 'Y'
	    WHEN name LIKE '%LRRS' THEN 'Y'
	    WHEN name LIKE '%Lrrs' THEN 'Y'
	    WHEN name LIKE '%Arb' THEN 'Y'
	    WHEN name LIKE '%Naf' THEN 'Y'
	    WHEN name LIKE '%NAS' THEN 'Y'
	    WHEN name LIKE '%Nas' THEN 'Y'
	    WHEN name LIKE '%Jrb' THEN 'Y'
	    WHEN name LIKE '%Ns' THEN 'Y'
	    WHEN name LIKE '%As' THEN 'Y'
	    WHEN name LIKE '%Cgas' THEN 'Y'
	    WHEN name LIKE '%Angb' THEN 'Y'
	    ELSE 'N'
  END
);


SELECT military, COUNT(*) as frequencia
FROM airports
GROUP BY military;


Y       	155
N       	1.242

------------------------------------------------------------------------------------------------

6.	Crie a coluna administration e atribua os valores a partir de substrings identificadas na coluna name de acordo com as condições abaixo:

alter table airports
add administration CHAR(3);

---1397

Obs: a prioridade das correspondências deve ser a mesma listada abaixo. Por exemplo, caso seja identificada "City" e "International" na mesma string, o valor atribuido deve ser I.
I : "International", "Intl", ou "Intercontinental"
N : "National", "Natl"
R : "Regional", "Reigonal", "Rgnl", "County", "Metro" ou "Metropolitan"
M : "Municipal", "Muni", ou "City"
NaN : Caso não atenda nenhuma das condições acima.
Consultar a frequência dos valores do novo campo.

Select name, administration,
(
    case
      WHEN name LIKE '%International%' OR name LIKE '%Intl%' OR name LIKE '%Intercontinental%' THEN 'I'
      WHEN name LIKE '%National%' OR name LIKE '%Natl%' THEN 'N'
      WHEN name LIKE '%Regional%' OR name LIKE '%Reigonal%' OR name LIKE '%Rgnl%' OR name LIKE '%County%' OR name LIKE '%Metro%' OR name LIKE '%Metropolitan%' THEN 'R'
      WHEN name LIKE '%Municipal%' OR name LIKE '%Muni%' OR name LIKE '%City%' THEN 'M'
      ELSE 'NaN'
    END
)   
from airports;

UPDATE airports SET administration =
(
    CASE 
     WHEN name LIKE '%International%' OR name LIKE '%Intl%' OR name LIKE '%Intercontinental%' THEN 'I'
     WHEN name LIKE '%National%' OR name LIKE '%Natl%' THEN 'N'
     WHEN name LIKE '%Regional%' OR name LIKE '%Reigonal%' OR name LIKE '%Rgnl%' OR name LIKE '%County%' OR name LIKE '%Metro%' OR name LIKE '%Metropolitan%' THEN 'R'
     WHEN name LIKE '%Municipal%' OR name LIKE '%Muni%' OR name LIKE '%City%' THEN 'M'
     ELSE 'NaN'
    END
)
; 

select * from airports;

SELECT administration, COUNT(*) AS frequency
FROM airports
GROUP BY administration;


--------------------------------------------------------------Planes Dataset-------------------------------------------------------------------------

1.	Na coluna ano, substitua todo valor inconsistente por 1996.

select ano from planes;

---61 alteraçoes
select ano from planes
where (ano is null
or trim(ano) = ''
or length(trim(ano)) = 0
or trim(ano) = 'NA'

);

UPDATE planes
SET ano = 
	CASE
      WHEN COALESCE(ano,'') = '' THEN '1996'
      WHEN REGEXP_REPLACE(ano, '[^0-9]+', '') <> ano THEN '1996'
      ELSE ano
    END;

SELECT ano, COUNT(*) AS frequency
FROM planes
GROUP BY ano;

------------------------------------------------------------------------------------------------
55.812 21,24 adicionar to NUMBER

2.	Crie a coluna age e atribua a idade do avião com base na coluna ano e o ano atual. 
Verificar os resultados por amostra e de forma agregada utilizando soma e média.

select age from planes; 

select age from planes; 

alter table planes drop age;

alter table planes
add age Byteint;

update planes set age = EXTRACT(YEAR from CURRENT_DATE) - TO_NUMBER(ano);
--46 resultados

select model, age from planes sample 10;

select model, age from planes;

select Sum(age) as Soma, Avg(age) as Media from planes;


------------------------------------------------------------------------------------------------

3.	Para todo valor da coluna manufacturer substitua o valor na coluna manufacturer de modo que existam somente os valores únicos listados abaixo. 
Para simplificar a atualização recomenda-se utilizar uma tabela “de-para”.
AIRBUS
BOEING
BOMBARDIER
CESSNA
EMBRAER
SIKORSKY
CANADAIR
PIPER
MCDONNELL DOUGLAS
CIRRUS
BELL
KILDALL GARY
LAMBERT RICHARD
BARKER JACK
ROBINSON HELICOPTER
GULFSTREAM
MARZ BARRY

Verificar frequência resultante dos valores do campo após atualização, ordenando pelos mais frequentes.

Criar tabela de Para



----------------------------------------------------------------------------------------------------------------

select Distinct(manufacturer) from planes;

create table manufacturer_de_para(
	old_manufacturer Varchar(50),
	new_manufacturer Varchar(50)
);

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer) 
VALUES ('AIRB', 'AIRBUS'),
('BOEI', 'BOEING'),
('BOMB', 'BOMBARDIER'),
('CESS', 'CESSNA'),
('EMBR', 'EMBRAER'),
('SIKO', 'SIKORSKY'),
('CANA', 'CANADAIR'),
('PIPE', 'PIPER'),
('MD', 'MCDONNELL DOUGLAS'),
('CIRR', 'CIRRUS'),
('BELL', 'BELL'),
('KILD', 'KILDALL GARY'),
('LAMB', 'LAMBERT RICHARD'),
('BARK', 'BARKER JACK'),
('ROBI', 'ROBINSON HELICOPTER'),
('GULF', 'GULFSTREAM'),
('MARZ', 'MARZ BARRY')
;


-------------------

select Distinct(manufacturer) from planes ORDER BY manufacturer;

drop table manufacturer_de_para;

select * from manufacturer_de_para;

create table manufacturer_de_para(
	old_manufacturer Varchar(50),
	new_manufacturer Varchar(50)
);

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES ('AIRBUS', 'AIRBUS');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('BOEING', 'BOEING');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('BOMBARDIER', 'BOMBARDIER');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('CESSNA', 'CESSNA');
  
INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('EMBRAER', 'EMBRAER');
  
INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('SIKORSKY', 'SIKORSKY');
  
INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('CANADAIR', 'CANADAIR');
  
INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('PIPER', 'PIPER');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('MCDONNELL', 'MCDONNELL DOUGLAS');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('CIRRUS', 'CIRRUS');
  
INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('BELL', 'BELL');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('KILDALL', 'KILDALL GARY');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES ('LAMBERT', 'LAMBERT RICHARD');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('BARKER', 'BARKER JACK');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES ('ROBINSON', 'ROBINSON HELICOPTER');
  
INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('GULFSTREAM', 'GULFSTREAM');

INSERT INTO manufacturer_de_para(old_manufacturer, new_manufacturer)
VALUES('MARZ', 'MARZ BARRY');

--621 atualizada

---atualizar a coluna

update planes set manufacturer = (
	select new_manufacturer
	from manufacturer_de_para
	where old_manufacturer = planes.manufacturer
);

-- contar frequencia
SELECT manufacturer, COUNT(*) AS frequency
FROM planes
GROUP BY manufacturer
ORDER BY frequency DESC;


--------------------------------------------------------------------------------------------------------

4.	Remova todos caracteres entre parenteses da coluna model mantendo somente os valores fora do parenteses.

select model from planes;

update planes set model = REGEXP_REPLACE(model, '\(.*?\)', '')
WHERE model LIKE '%(%' OR model LIKE '%)%';

--46 resultados


UPDATE planesSET model = OREPLACE(model, model, STRTOK(model, '(', 1))
WHERE model LIKE '%(%';

-----------------------------------------------------------------------------------------------------

5.	Impute os valores não existentes na coluna speed com base na fórmula: seats / 0,36.
Verificar os resultados por amostra (top 5) e de forma agregada utilizando soma e média.

select speed from planes;

select speed 
from planes
where speed = 'NA';

update planes 
set speed = TO_CHAR(seats / 0.36)
where speed is null
or speed = ''
or speed = 'NA';

select TOP 5 speed
From planes;

--1.139.524,00
select SUM(speed) as 'Soma Speed'
From planes;

select AVG(speed) as 'Meida Speed'
From planes;
--433,61

------------------------------------------------------------------------------------------------------

update planes
--select seats,
set speed =

--seats / 0.36
--OREPLACE(to_char(seats/0.36), to_char(seats/0.36), STRTOK(to_char(seats/0.36), '.', 1))
to_char(round(seats / 0.36))
--as new_speed
--from planes
where speed = 'NA';

-----------------------------------------------------------------------------------------------------

Flights Dataset

Tarefas
1.	Impute os valores não existentes nas colunas hora e minuto com 0, e os valores iguais a 24 da coluna hora por 0.

select hora, minuto 
from flights
where hora = 'NA'
or hora is null
or minuto = 'NA'
or minuto = ''

;
--29

update flights set 
hora = to_char(0)
where hora = 'NA' 
or hora is null
or minuto = ''
;

update flights set minuto = to_char(0)
where minuto = 'NA'
or minuto = ''
;

select hora
from flights 
where hora = '24'
or minuto = ''
;

--1 linha

update flights set hora = to_char(0)
where hora = '24'
;
--------------ou------------------------

SELECT hora, minuto FROM flights
WHERE TO_NUMBER(hora) IS NULL
OR TO_NUMBER(minuto) IS NULL
OR hora = 24;


update flights
set hora = '0'
where hora = 'NA' or hora = '24';

 -- 32

update flights
set minuto = '0'
where minuto = 'NA'; -- 31


----------------------------------------------------------------------------------------------------

2.	Crie a coluna dep_datetime (timestamp) usando as colunas ano, mes, dia, hora, minuto no formato YYYY-MM-DD HH:MM:00.
Validar que a conversão foi ok comparando a frequência do campo mes com o campo mês da nova coluna, e vendo se os valores 
mínimo e máximo estão dentro do esperado.

ALTER TABLE flights
ADD dep_datetime TIMESTAMP(0);

UPDATE flights 
SET dep_datetime = 
	CAST(ano AS VARCHAR(4))||'-'||
	CAST(cast(mes AS FORMAT'9(2)')as char(2))||'-'||
	CAST(cast(dia AS FORMAT'9(2)')as char(2))||' '|| 
	CAST(cast(to_number(hora) AS FORMAT'9(2)')as char(2))||':'|| 
	CAST(cast(to_number(minuto) AS FORMAT'9(2)')as char(2))||':'||'00'
;

---------------------------marcos----------------------------------

alter table flights add dep_datetime timestamp;
update flights set dep_datetime =
--sel ano,mes,dia,hora,minuto,
cast(trim(ano) || '-' ||
CAST(CAST(mes AS FORMAT '9(2)') AS CHAR(2)) || '-' ||
CAST(CAST(dia AS FORMAT '9(2)') AS CHAR(2))
||' '||
cast(CAST(to_number(hora) AS FORMAT '9(2)') as char(2)) || ':' ||
cast(CAST(to_number(minuto) AS FORMAT '9(2)') as char(2)) || ':00'
as timestamp);

--from flights;

select min(dep_datetime),max(dep_datetime) from flights;
select extract(month from dep_datetime), count(1) from flights group by 1 order by 1;
select mes, count(1) from flights group by 1 order by 1;


---------------------------------------------------------------------------------------------------------------------

3.	Impute os valores não existentes na coluna dep_time usando as colunas hora, minuto de acordo com o formato esperado pela coluna dep_time.

ALTER TABLE flights
ADD dep_time TIME(0);

UPDATE flights 
SET dep_time = CAST(cast(to_number(hora) AS FORMAT'9(2)')as char(2))||':'|| 
	CAST(cast(to_number(minuto) AS FORMAT'9(2)')as char(2))||':'||'00'
;

select dep_time, hora, minuto from flights;

----------------------------------------------------MARCOS------------------------------------------------------

select distinct hora, minuto from flights
where dep_time = 'NA'
order by 1, 2;

update flights set dep_time = '000'
where dep_time = 'NA'; -- 29

-------------------------------------------------------------------------------------------------------------------
4.	Impute os valores não existentes nas colunas dep_delay e arr_delay por 0.

select dep_delay, arr_delay
from flights
where dep_delay = 'NA'
or dep_delay is null
and arr_delay = 'NA'
and arr_delay = ''
;

---29 alteraçoes

update flights set dep_delay = '0'
where dep_delay = 'NA' 
or dep_delay is null
;

update flights set arr_delay = '0'
where arr_delay = 'NA'
and arr_delay = ''
;
--40 
---------------------------------------------------------------------------------------------------------------------

5.	Crie a coluna air_time_projected de acordo com a fórmula distance x 0.1 + 20. Validar usando valores mínimo, máximo, soma e média.


alter table flights
add air_time_projected DECIMAL(18,2);

---4821
update flights set air_time_projected = distance * 0.1 + 20;

SELECT MIN(air_time_projected) as Minino, MAX(air_time_projected) as Maximo, SUM(air_time_projected) as Soma , AVG(air_time_projected) as Media
FROM flights;

-------------------------------------------------não funcionou--------------------------------------------------------------------

6.	Crie a coluna air_time_expected de acordo com a média de valores dos voos com mesma origem e destino. 
Sugestão: usar uma tabela volátil para cálculo das médias. 
Validar usando valores mínimo, máximo, soma e média.

drop table vt_air_time_avg;

CREATE VOLATILE TABLE vt_air_time_avg
(
    origin VARCHAR(50),
    dest VARCHAR(50),
    air_time_avg DECIMAL(10,2)
)


INSERT INTO vt_air_time_avg
SELECT origin, dest, Avg(to_number(air_time))
FROM flights
GROUP BY origin, dest;

select * from vt_air_time_avg

ALTER TABLE flights
ADD air_time_expected integer;

UPDATE flights
SET air_time_expected = vt.air_time_avg
FROM vt_air_time_avg vt
WHERE flights.origin = vt.origin
AND flights.dest = vt.dest;

SELECT MIN(air_time_expected), MAX(air_time_expected), SUM(air_time_expected), AVG(air_time_expected)
FROM flights;

-----------------------------------------------------------------------------------------------------------------------

CREATE VOLATILE TABLE vt_airtime
AS (
  SELECT origin, dest, AVG(to_number(air_time)) AS avg_air_time
  FROM flights
  GROUP BY origin, dest
) WITH DATA PRIMARY INDEX (origin, dest) ON COMMIT PRESERVE ROWS
;

SELECT f.*, v.avg_air_time AS air_time
FROM flights AS f
INNER JOIN vt_airtime AS v
ON f.origin = v.origin AND f.dest = v.dest;

SELECT MIN(air_time_expected), MAX(air_time_expected), SUM(air_time_expected), AVG(air_time_expected)
FROM (
  SELECT f.*, v.avg_air_time AS air_time_expected
  FROM flights AS f
  INNER JOIN vt_airtime AS v
  ON f.origin = v.origin AND f.dest = v.dest
) AS t;



------------------------------------------------------------------------------------------------------------------------

7.	Impute os valores não existentes na coluna air_time de acordo com o maior valor entre air_time_projected e air_time_expected, utilizando apenas a parte inteira do valor. 
Garantir que não sobraram linhas sem valor no air_time. Verificar se os valores ficaram de acordo com a regra, usando o indicador de qualidade correspondente para filtrar.


sel air_time,air_time_projected,air_time_expectedfrom flights where qa_air_time is not null;

ALTER TABLE flights
ADD air_time_expected float;

insert into flights (air_time_expected)
SELECT v.avg_air_time AS air_time_expected
  FROM flights AS f
  INNER JOIN vt_airtime AS v
  ON f.origin = v.origin AND f.dest = v.dest;
  
select air_time_expected from flights;
  


UPDATE flights
SET air_time = CAST(
  CASE WHEN air_time_projected IS NOT NULL AND air_time_expected IS NOT NULL
    THEN GREATEST(air_time_projected, air_time_expected)
    ELSE COALESCE(air_time_projected, air_time_expected)
  END AS INTEGER
)
WHERE air_time IS NULL;


----------------------------------------------------------------------------------------------------------------------------
8.	Impute os valores não existentes na coluna arr_time de acordo com a fórmula dep_time + air_time, utilizando a nova coluna dep_datetime
 e o tipo INTERVAL MINUTE (https://www.docs.teradata.com/r/Teradata-Database-SQL-Data-Types-and- Literals/June-2017/DateTime-and-Interval-Data-Types/INTERVAL-MINUTE-Data- Type). 
 Garantir ao final que não sobraram linhas sem valor no arr_time e que a transformação foi efetiva (pode ser filtrado através do indicador de qualidade).
 
alter table flights
add arr_time INTERVAL MINUTE(2);

update flights
set arr_time = (dep_time + air_time) MINUTE;

--UPDATE fligthsSET arr_time = dep_datetime + INTERVAL '1' MINUTE * air_time WHERE arr_time IS NULL;

select COUNT(*) from flights
where arr_time is null;

 ------------------------------------------------------------------------------------------------------------------------------
 
 9.	Crie a coluna haul_duration com base na coluna air_time de acordo com as regras abaixo:
•	SHORT: 20 min – 2h59
•	MEDIUM: 3 horas – 5h59
•	LONG: 6+ horas
Verificar frequência do novo campo, validar verificando as faixas mínima e máxima de duração das categorias.
Obs.: recomendado utilizar COMPRESS.


select air_time,
	CASE
	    WHEN COMPRESS(air_time) BETWEEN '20' AND '179' THEN 'SHORT'
	    WHEN COMPRESS(air_time) BETWEEN '180' AND '359' THEN 'MEDIUM'
	    ELSE 'LONG'
	END AS haul_duration
FROM flights
;

select haul_duration, COUNT(*)
from(
	select air_time,
	 Case
	 	WHEN COMPRESS(air_time) BETWEEN '20' AND '179' THEN 'SHORT'
      	WHEN COMPRESS(air_time) BETWEEN '180' AND '359' THEN 'MEDIUM'
      	ELSE 'LONG'
     END AS haul_duration
	FROM flights 
) t
group by haul_duration

;


select haul_duration, MIN(air_time), MAX(air_time)
from(
	select air_time,
	 Case
	 	WHEN COMPRESS(air_time) BETWEEN '20' AND '179' THEN 'SHORT'
      	WHEN COMPRESS(air_time) BETWEEN '180' AND '359' THEN 'MEDIUM'
      	ELSE 'LONG'
     END AS haul_duration
	FROM flights 
) t
group by haul_duration

;

select haul_duration from flights;
---------------------------------------------------------------------------------------------------------------------------------
10.	Crie a coluna dep_season de acordo com as regras abaixo:
•	WINTER : De 21 de Dez às 09:48 PM até 20 de Mar às 03:33 PM.
•	SPRING : De 20 de Mar às 03:34 PM até 21 de Jun às 10:14 AM.
•	SUMMER : De 21 de Jun às 10:15 AM até 23 de Set às 02:04 AM.
•	AUTUMN : De 23 de Set às 02:05 AM até 21 de Dez às 09:47 PM.
Verificar frequência do novo campo, validar verificando as faixas mínimas e máximas de duração das categorias.
Obs.: recomendado utilizar COMPRESS.


SELECT *,
  CASE 
    WHEN DEPARTURE_DATE BETWEEN '2022-12-21 09:48:00' AND '2023-03-20 15:33:00' THEN 'WINTER'
    WHEN DEPARTURE_DATE BETWEEN '2023-03-20 15:34:00' AND '2023-06-21 10:14:00' THEN 'SPRING'
    WHEN DEPARTURE_DATE BETWEEN '2023-06-21 10:15:00' AND '2023-09-23 02:04:00' THEN 'SUMMER'
    WHEN DEPARTURE_DATE BETWEEN '2023-09-23 02:05:00' AND '2022-12-21 21:47:00' THEN 'AUTUMN'
    ELSE 'OUT OF SEASON'
  END AS DEP_SEASON
FROM flights
;


SELECT DEP_SEASON, COUNT(*) AS COUNT
FROM (
  SELECT *,
    CASE 
      WHEN DEPARTURE_DATE BETWEEN '2022-12-21 09:48:00' AND '2023-03-20 15:33:00' THEN 'WINTER'
      WHEN DEPARTURE_DATE BETWEEN '2023-03-20 15:34:00' AND '2023-06-21 10:14:00' THEN 'SPRING'
      WHEN DEPARTURE_DATE BETWEEN '2023-06-21 10:15:00' AND '2023-09-23 02:04:00' THEN 'SUMMER'
      WHEN DEPARTURE_DATE BETWEEN '2023-09-23 02:05:00' AND '2022-12-21 21:47:00' THEN 'AUTUMN'
      ELSE 'OUT OF SEASON'
    END AS DEP_SEASON
  FROM flights
) AS T
GROUP BY DEP_SEASON
;

SELECT DEP_SEASON from flights;

-------------------------------------------------------------------------------------------------------------------------------------
11.	Crie a coluna dep_delay_category com base na coluna dep_delay de acordo com as regras abaixo:
•	ANTEC : Menor que 0.
•	INTIME : Igual a 0.
•	MINOR : Maior que 0 e menor que 60.
•	MAJOR : Maior ou igual a 60.
Verificar frequência do novo campo, validar verificando as faixas mínimas e máximas de atraso das categorias.
Obs.: recomendado utilizar COMPRESS.


Além das transformações nas 3 tabelas, vamos já deixar criada uma tabela de domínio para o campo carrier (cia aérea), com os valores abaixo:
AA : American Airlines AS : Alaska Airlines B6 : Jetblue Airways DL : Delta Airlines
F9 : Frontier Airlines HA : Hawaiian Airlines OO : Skywest Airlines UA : United Airlines US : US Airways
VX : Virgin America
WN : Southwest Airlines

alter table flights
add dep_delay_category char(6) format $6.;
    
update flights
set dep_delay_category = compress(
    case
        when dep_delay < 0 then 'ANTEC'
        when dep_delay = 0 then 'INTIME'
        when dep_delay > 0 and dep_delay < 60 then 'MINOR'
        when dep_delay >= 60 then 'MAJOR'
        else ''
    end
);

select dep_delay_category from flights;


