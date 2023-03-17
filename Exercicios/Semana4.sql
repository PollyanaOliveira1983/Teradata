Análise de aeroportos e aeronaves

1. Qual região possui mais aeroportos militares? Qual possui maior percentual de
aeroportos militares?


select region, Count(*) as total_aeroportos,
SUM(
	Case
		When military = 'Y' then 1
		else 0
	end
) AS total_militares,
(Cast(SUM(Case
	when military = 'Y' then 1 
	else 0
	end)
	as float) *100) / count(*) AS percentual_militares
from airports
group by region
order by total_militares DESC, percentual_militares DESC
;

------------------------------------------------------------------------------------------

2. Qual região possui mais aeroportos internacionais? Qual possui maior percentual de
aeroportos internacionais?

select region as Regiao, 
sum(case 
	when military = 'Y' then 1 
	else 0 
	end) as Qtd_militar, 
	count(1) as Qtd_regiao, 
	Qtd_militar * 100.00 / Qtd_regiao as Percentual_militar
	from airports 
group by 1;

--order by 2 desc 

-- para checar região com maior quantidade 
--order by 4 desc;

--------------------------------------------------------------------------------------------

3. Qual fabricante possui a frota mais nova na média?

select top 1 manufacturer, 
AVG(age) AS media_idade_frota
from planes
group by manufacturer
order by media_idade_frota ASC
;

------------------------------------------------------------------
4. Qual fabricante possui a frota em atividade mais nova na média?

-- Premissa: frota em atividade = apenas aviões com voos
-- 1a forma: ponderando automaticamente o peso dos aviões de acordo com as ocorrências de voos
select manufacturer as Fabricante, avg(age) as idade_media
from planes p
inner join flights f
on p.tailnum = f.tailnum
group by 1 
order by 2;

-- 2a forma: considerando com o mesmo peso todos os aviões com pelo menos 1 voo encontrado

select manufacturer as Fabricante, avg(age) as idade_media
from planes p
where p.tailnum 
in (sel f.tailnum 
from flights f)
group by 1 
order by 2;
----------------------------------------------------------------------
5. Qual é o modelo de avião mais popular considerando sua capacidade?

select manufacturer as Fabricante, model as Modelo,
SUM(seats) as Total_assentos
from planes p
inner join flights f on planes. tailnum = flights.tailnum
group by 1, 2
order by 3 Desc
;
-- Premissa: apenas considerados os modelos que aparecem na tabela flights, considerando o total de assentos de acordo com os voos na tabela

--------------------------------------verificar depois ------------------------------
6. Qual é o número médio de motores para cada categoria de haul_duration? engines 

select haul_duration as Categoria_duracao, count(1) as qtd, 
avg(cast(engines as decimal(18,8))) as Avg_engines_com_erro,
cast(sum(engines) as decimal(18,8)) / qtd as media_engines_calculada
from planes p
inner join flights f
on p.tailnum = f.tailnum
group by 1;
--------------------------------------------------------------------------------------

select flights.haul_duration as total_hal_duration,
avg(engines) as media_motores
from flights
inner join planes
on flights.tailnum =  planes.tailnum
group by total_hal_duration
;

------------------------------------------------------------------------------------

7. Qual é o tipo de motor mais utilizado? E para cada categoria de haul_duration?

--motor mais utilizado
select top 1 engine, Count(*) as total_motor_usado
from planes
group by engine
order by total_motor_usado DESC
;

-------------------------------------------------------------------------------------
--categoria de hall duration

SELECT DISTINCT p.engine AS Motor, COUNT(P.engine) AS Motor_Mais_Utilizado,
f.haul_duration AS duracao_voo
FROM flights f
INNER JOIN planes p
ON f.tailnum = p.tailnum
GROUP BY Motor
ORDER BY Motor_Mais_Utilizado DESC;

-----ou--------------------

select engine as Tipo_motor, count(1) as Qtd
from planes p
inner join flights f
on p.tailnum = f.tailnum
group by 1 order by 2 desc;

select haul_duration as Categoria_duracao, engine as Tipo_motor, count(1) as Qtd from planes p
inner join flights f on p.tailnum = f.tailnum
group by 1, 2 order by 1, 3 desc;

-- Para filtrar apenas os tipos mais utilizados para cada categoria de duração

select haul_duration as categoria_duracao, engine as tipo_motor, count(1) as qtd 
from planes p
inner join flights f on p.tailnum = f.tailnum
group by 1, 2
qualify rank() over(partition by haul_duration order by qtd desc) = 1;
----------------------------------------------------------------------------------------------------

Análise de distâncias e destinos
8. Quais os códigos e nomes dos destinos mais distantes de PDX e de SEA?

----------------------------------------------------------------------------------------
select DISTINCT 
	dest as "Codigo",
	name as "Nome",
	distance as "Distancia"
from flights f
inner join airports a
on a.faa = f.dest
where origin in ('PDX', 'SEA')
order by distance desc;

-----------------------------------------------------------------------------------------

select f.origin as Origem, 
	o.name as Nome_origem, 
	f.dest as Destino, 
	d.name as Nome_destino, 
	f.distance as Distancia
	from flights f,
	airports o, airports d 
	where f.dest = d.faa
	and f.origin = o.faa
	group by 1,2,3,4,5 qualify rank() over(partition by f.origin 
	order by f.distance desc) <= 3;
	
	order by 1, 5 desc;
-----------------------------------------------------------------------------------------

9. Qual a maior diferença de horário (timezone) de um voo e quais destinos envolve? 

select f.origin as ORIGEM, f.dest as DESTINO,
	MAX(abs(o.tz - a.tz)) as max_zona
from flights f
	join airports o on f.origin = o.faa
	join airports a on f.dest = a.faa
GROUP BY f.origin, f.dest
order by max_zona desc;

-------------------------------------------------------------------------------------

10. Quais os 5 destinos com maior frequência de voos para cada estação?

select f.dep_season as Estacao, f.dest as Destino, a.name as Nome_destino, Count(1) quantidade_voo
from flights f, airports a
where f.dest = a.faa
group by 1,2,3
order by 1,4 DESC
qualify row_number() over(partition by f.dep_season order by quantidade_voo desc) <= 5
;


---------------------------------------------------------------------------------------
11. Quais são as maiores diferenças de altitude dos voos (entre origem e destino)? Qual ou quais destinos envolve?


select f.origin as origem, f.dest as destino,
Max(o.alt) - MIN(a.alt) as Maior_diferenca_altitude
from flights f
join airports o on f.origin = o.faa
join airports a on f.dest = a.faa
group by f.origin, f.dest
order by Maior_diferenca_altitude
;

---------------------------------------------------------------------------------------
12. Qual é a distância de voo médio e acumulada para cada região?

select Distinct a.region,
Cast(AVG(f.distance) as Decimal(10,2)) as distancia_media,
SUM(f.distance) as distancia_acumulada
from flights f
inner join airports a on a.faa = f.dest 
group by a.region
;

-----------------------------------------------------------------------------------------
13. Qual companhia acumula mais milhas voadas?

select f.carrier, a.name, sum(f.distance) as total_miles
from flights f
inner join airports a on a.faa = f.dest
group by carrier, a.name
order by total_miles Desc
;

-------------------------------------------------------------------------------------------

14. Qual fabricante acumula mais milhas voadas?

select top 1 manufacturer, sum(air_time) as total_miles_manufacturer
from flights, planes
group by manufacturer
order by total_miles_manufacturer DESC
;

BOEING	982.203.320,00


fabricante manufacturer planes
air_time tempo de voo
tailnum ident f aviao / planes 

select Distinct p.manufacturer, f.tailnum, SUM(f.air_time) as total_miles
from flights f
inner join planes p on f.tailnum = p.tailnum
group by f.tailnum, p.manufacturer, air_time
order by f.air_time
;

----------------------------------------------------------------------------------

Análise de passageiros (considerando capacidade)

15. Qual é o número de passageiros acumulado?

select Distinct tailnum, model, seats
from planes
order by seats Desc
;

N675NW	747-451	450


16. Quais os destinos que recebem mais passageiros? E o mesmo para cada região.

select Distinct dest, Count(*) 
from flights
group by dest Desc
;

SFO	353


17. Qual é a região que recebe mais passageiros? E por estação?

select Distinct dep_season, Count(*) as total_passgeiros
from flights, airports
group by dep_season
;

SUMMER	1.765.808
AUTUMN	1.661.033
SPRING	1.600.962
WINTER	1.105.027


18. Quais as 5 companhias com mais passageiros?


select Distinct carrier, Count(*) as total
from flights
group by carrier
order by total DESC
;

19. Qual a estação mais popular para voos? E a menos popular?

select top 1 flight, Count(*) as estacao_mais_popular
from( 
select origin as flight
from flights
union all
Select dest as flight
from flights
) as flight
group by flight
order by estacao_mais_popular DESC
;

select top 1 flight, Count(*) estacao_menos_popular
from(
 Select origin as flight
 from flights
 union all
 Select dest as flight
 from flights
 ) as flight
 group by flight
order by estacao_menos_popular
;

20. Quais as faixas de altitude mais acessadas em cada estação? Considerar: até 200 pés = ‘COSTA’, até 650 pés = ‘BAIXA’, até 2450 pés = ‘MEDIA’, acima disto ‘ALTA’.

select
	Case
		When alt <= 200 then 'Costa'
		when alt <= 650 then 'Baixa'
		when alt <= 2450 then 'Media'
		else 'Alta'
	end as faixa_altitude,
	region,
	alt
from airports
group by faixa_altitude, region, alt
order by region 
;


21. Em que período do dia (manhã, tarde, noite, madrugada) os passageiros mais viajam? Analisar por categoria de duração (haul_duration). Análise de tempo e atraso
 --------período do dia que os passageiros mais viajam

SELECT
  CASE
    WHEN hora BETWEEN 5 AND 11 THEN 'MANHA'
    WHEN hora BETWEEN 12 AND 17 THEN 'TARDE'
    WHEN hora BETWEEN 18 AND 23 THEN 'NOITE'
    ELSE 'MADRUGADA'
  END AS periodo,
   haul_duration AS duracao_categoria,
  Count(*) as num_viagens,
  SUM(dep_delay) AS total_minutos_atraso,
  AVG(dep_delay) AS media_atraso
  from flights
  group by periodo, duracao_categoria
 ;
 
----------------------------------------------------------------------------------

SELECT
  CASE
    WHEN hora BETWEEN 5 AND 11 THEN 'MANHA'
    WHEN hora BETWEEN 12 AND 17 THEN 'TARDE'
    WHEN hora BETWEEN 18 AND 23 THEN 'NOITE'
    ELSE 'MADRUGADA'
  END AS periodo,
  Count(*) as num_viagens
  from flights
  group by periodo
  order by num_viagens DESC
   ;
 
 SELECT
  haul_duration AS duracao_categoria,
  COUNT(*) AS num_viagens,
  SUM(dep_delay) AS total_minutos_atraso,
  AVG(dep_delay) AS media_atraso
FROM flights
GROUP BY duracao_categoria;
  
----------------------------------------------------------------------------------
22. Qual é o atraso médio?

 SELECT
   AVG(dep_delay) AS media_atraso
FROM flights
;

------------------------------------------------------------------------------
23. Qual é o atraso médio para cada região?

SELECT region,
AVG(dep_delay) AS media_atraso
FROM flights, airports
group by region
;

--------------------------------------------------------------------
24. Qual é o atraso médio por estação? Em qual estação há maior incidência de atrasos?

SELECT name,carrier,
AVG(dep_delay) AS media_atraso
FROM flights, airports
group by carrier, name
;

------------------------------------------------------------------
25. Qual a rota com maior atraso total? E atraso médio?

select top 1 origin, dest, sum(arr_delay) as atraso_total
from flights
group by origin, dest
order by atraso_total DESC
;

select top 1 origin, dest, avg(arr_delay) as atraso_medio
from flights
group by origin, dest
order by atraso_medio DESC
;

------------------------------------------------------------------

with atrasos_totais as (
select top 1 origin, dest, sum(arr_delay) as atraso_total
from flights
group by origin, dest
order by atraso_total DESC
), atrasos_medios as (
select top 1 origin, dest, avg(arr_delay) as atraso_medio
from flights
group by origin, dest
order by atraso_medio DESC
)
Select 'Maior atraso total' AS tipo_atraso, origin, dest, atraso_total
from atrasos_totais
UNION ALL
Select 'Maior atraso médio' AS tipo_atraso, origin, dest, atraso_medio
from atrasos_medios;

-------------------------------------------------------------------------

26. Qual a companhia com mais ocorrências de atrasos graves?

select top 1 origin, dest, sum(arr_delay) as atraso_total
from flights
group by origin, dest
order by atraso_total DESC
;

----------------------------------------------------------------------------
27. Qual a companhia com maior atraso médio considerando total de voos? E se considerarmos apenas voos com atraso? 

select top 1 carrier, COUNT(*) as total_voos, AVG(arr_delay) as atraso_medio
from flights
group by carrier
order by atraso_medio DESC
;

select carrier, COUNT(*) as total_voos_com_atraso, AVG(arr_delay) as atraso_medio_com_atraso
from flights
where arr_delay > 0
group by carrier
order by atraso_medio_com_atraso DESC;

----------------------------------------------------------------------------
28. Qual é o tempo de voo médio por haul_duration?

select top 1 haul_duration, distance
from flights
where haul_duration = 'MEDIUM'
order by distance DESC
;

----------------------------------------------------------------------------
29. Qual é o tempo de voo médio e acumulado para cada região?

select Distinct origin,
AVG(air_time)
from flights
group by origin
;

----------------------------------------------------------------------------
30. Há muitas ocorrências de recuperação de atraso na saída? Verificar este dado por companhia.

