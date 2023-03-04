database "marcos.nagato@capgemini.com";

-- drop table airports
create table airports (
faa varchar(5),
name varchar(51),
lat float,
lon float,
alt int,
tz int compress (-5,-6,-4,-8,-7,-10,-9,6,7,8,5,-11),
dst char(1))
primary index(faa);
--show table airports

delete from airports;
select * from airports;

-- Verificações Qualidade

-- faa
alter table airports add qa_faa varchar(1);
update airports set qa_faa = 
case when faa is null or trim(faa) = '' then 'M'
when length(faa) < 3 then 'F' end
where faa is null or trim(faa) = '' or length(faa) < 3;

-- name
alter table airports add qa_name varchar(1);
update airports set qa_name = 'M'
where name is null or trim(name) = '';

-- lat
alter table airports add qa_lat varchar(1);
update airports set qa_lat = 'M'
where lat is null;
update airports set qa_lat = 'I'
where lat not between -180 and 180;
-- verificação alfanumérico ignorar (campo numérico)

-- lon
alter table airports add qa_lon varchar(1);
update airports set qa_lon = 'M'
where lon is null;
update airports set qa_lon = 'I'
where lon not between -180 and 180;
-- verificação alfanumérico ignorar (campo numérico)

-- alt
alter table airports add qa_alt varchar(1);
update airports set qa_alt = 'M'
where alt is null;
update airports set qa_alt = 'I'
where alt< -100;
-- verificação alfanumérico ignorar (campo numérico)

-- tz
alter table airports add qa_tz varchar(1);
update airports set qa_tz = 'M'
where alt is null;
update airports set qa_tz = 'I'
where tz not between -11 and 14;
-- verificação alfanumérico ignorar (campo numérico)

-- dst
alter table airports add qa_dst varchar(1);
update airports set qa_dst = 'M'
where dst is null;
update airports set qa_dst = 'C'
where dst not in ('E','A','S','O','Z','N','U');
update airports set qa_dst = 'N'
where to_number(dst) < 10;
