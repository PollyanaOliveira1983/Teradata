database "marcos.nagato@capgemini.com";

--drop table flights
create table flights 
(ano int compress(2014),
mes int compress(1,2,3,4,5,6,7,8,9,10,11,12),
dia int compress(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31),
dep_time varchar(4),
dep_delay varchar(3),
arr_time varchar(4),
arr_delay varchar(3),
carrier varchar(2),
tailnum varchar(6) compress('NA'),
flight varchar(4),
origin varchar(3) compress('SEA','PDX'),
dest varchar(3),
air_time varchar(3),
distance int,
hora varchar(2),
minuto varchar(2))
primary index (flight);
--show table flights;

select * from flights;
delete from flights;

-- Verificações qualidade

-- ano/mes/dia
alter table flights add qa_year_month_day varchar(2);
update flights set qa_year_month_day = 'MY' where ano is null;
update flights set qa_year_month_day = 'MM' where mes is null;
update flights set qa_year_month_day = 'MD' where dia is null;
update flights set qa_year_month_day = 'IY' where ano < 1950;
update flights set qa_year_month_day = 'IM' where mes not between 1 and 12;
update flights set qa_year_month_day = 'ID' where mes in(1,3,5,7,8,10,12) and dia not between 1 and 31;
update flights set qa_year_month_day = 'ID' where mes in(2) and dia not between 1 and 29;
update flights set qa_year_month_day = 'ID' where mes in(4,6,9,11) and dia not between 1 and 30;

-- hora/minuto
alter table flights add qa_hour_minute varchar(2);
update flights set qa_hour_minute = 'MH' where hora is null or trim(hora) = '' or hora = 'NA'; -- 33
update flights set qa_hour_minute = 'MM' where minuto is null or trim(minuto) = '' or minuto = 'NA'; -- 33
update flights set qa_hour_minute = 'IH' where to_number(hora) not between 0 and 23; -- 1
update flights set qa_hour_minute = 'IM' where to_number(minuto) not between 0 and 59;
--select * from flights where qa_hour_minute = 'IH';

-- partida e chegada
alter table flights add qa_dep_arr_time varchar(2);
update flights set qa_dep_arr_time = 'MD' where dep_time is null or trim(dep_time) = '' or dep_time = 'NA'; -- 33
update flights set qa_dep_arr_time = 'MA' where arr_time is null or trim(arr_time) = '' or arr_time = 'NA'; -- 36
update flights set qa_dep_arr_time = 'FD' where length(dep_time) not in (3,4) or (to_number(dep_time) is null and dep_time <> 'NA'); -- 84
update flights set qa_dep_arr_time = 'FA' where length(arr_time) not in (3,4) or (to_number(arr_time) is null and arr_time <> 'NA'); -- 108
update flights set qa_dep_arr_time = 'ID' where length(dep_time) = 4 and (to_number(substr(dep_time,1,2)) > 23 or to_number(substr(dep_time,3,2)) > 59); -- 1
update flights set qa_dep_arr_time = 'ID' where length(dep_time) = 3 and to_number(substr(dep_time,2,2)) > 59;
update flights set qa_dep_arr_time = 'IA' where length(arr_time) = 4 and (to_number(substr(arr_time,1,2)) > 23 or to_number(substr(arr_time,3,2)) > 59); -- 1
update flights set qa_dep_arr_time = 'IA' where length(arr_time) = 3 and to_number(substr(arr_time,2,2)) > 59;
--select * from flights where qa_dep_arr_time = 'IA';

-- delay partida /chegada
alter table flights add qa_dep_arr_delay varchar(2);
update flights set qa_dep_arr_delay = 'MD' where dep_delay is null or trim(dep_delay) = '' or dep_delay = 'NA'; -- 33
update flights set qa_dep_arr_delay = 'MA' where arr_delay is null or trim(arr_delay) = '' or arr_delay = 'NA'; -- 48
update flights set qa_dep_arr_delay = 'FD' where to_number(dep_delay) is null and dep_delay <> 'NA';
update flights set qa_dep_arr_delay = 'FA' where to_number(arr_delay) is null and arr_delay <> 'NA';
--select * from flights where qa_dep_arr_delay in ('FD','FA')

-- carrier
alter table flights add qa_carrier varchar(1);
update flights set qa_carrier = 'M' where carrier is null or trim(carrier) = '';
update flights set qa_carrier = 'F' where length(carrier) = 1;

delete from flights where mes = 12;

-- tailnum (consistencia FK)
alter table flights add qa_tailnum varchar(1);
update flights set qa_tailnum = 'M' where tailnum is null or trim(tailnum) = '' or tailnum = 'NA'; -- 10
update flights set qa_tailnum = 'R' where tailnum not in (select tailnum from planes); -- 334
--select * from flights where qa_tailnum = 'R';

-- flight
alter table flights add qa_flight varchar(1);
update flights set qa_flight = 'M' where flight is null or trim(flight) = '';
update flights set qa_flight = 'F' where to_number(flight) is null;


-- qa_origin_dest
alter table flights add qa_origin_dest varchar(2);
update flights set qa_origin_dest = 'MO' where origin is null or trim(origin) = '';
update flights set qa_origin_dest = 'MD' where dest is null or trim(dest) = '';
update flights set qa_origin_dest = 'RO' where origin not in (select faa from airports);
update flights set qa_origin_dest = 'RD' where dest not in (select faa from airports);

-- air_time
alter table flights add qa_air_time varchar(1);
update flights set qa_air_time = 'M' where air_time is null or trim(air_time) = '' or air_time = 'NA'; -- 48
update flights set qa_air_time = 'I' where to_number(air_time) not between 20 and 500;
update flights set qa_air_time = 'F' where to_number(air_time) is null and air_time <> 'NA';
--select * from flights where qa_air_time = 'F';

-- distance
alter table flights add qa_distance varchar(1);
update flights set qa_distance = 'M' where distance is null;
update flights set qa_distance = 'I' where distance not between 50 and 3000;

-- qa_distance_airtime
alter table flights add qa_distance_airtime varchar(2);
update flights set qa_distance_airtime = 'M' where qa_air_time = 'M' or qa_distance = 'M'; -- 48
--select qa_distance_airtime , count(1) from flights group by 1;
