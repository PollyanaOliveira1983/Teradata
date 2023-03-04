database "marcos.nagato@capgemini.com";

--drop table planes;
create table planes (
tailnum varchar(6),
ano varchar(4),
tipo varchar(24) compress('Fixed wing multi engine','Fixed wing single engine','Rotorcraft'),
manufacturer varchar(29) compress('AIRBUS INDUSTRIE','BOEING','AIRBUS','BOMBARDIER INC','CESSNA','EMBRAER','SIKORSKY','CANADAIR','PIPER','MCDONNELL DOUGLAS','BELL',
'CIRRUS DESIGN CORP','KILDALL GARY','LAMBERT RICHARD','BARKER JACK L','ROBINSON HELICOPTER CO','GULFSTREAM AEROSPACE','MARZ BARRY','MCDONNELL DOUGLAS AIRCRAFT CO'),
model varchar(14),
engines smallint,
seats smallint,
speed varchar(3),
engine varchar(13) compress('Turbo-fan','Turbo-jet','Reciprocating','Turbo-prop','Turbo-shaft','4 Cycle')
)
primary index(tailnum);
--show table planes

select * from planes;

-- Verificações Qualidade

-- tailnum
alter table planes add qa_tailnum varchar(2);
update planes set qa_tailnum = 'M'
where tailnum is null or trim(tailnum) = '';
update planes set qa_tailnum = 'S'
where length(tailnum) not in (5, 6);
update planes set qa_tailnum = 'FN'
where substr(tailnum,1,1) <> 'N';
update planes set qa_tailnum = 'FE'
where substr(tailnum,2,1) = '0' or tailnum like '%o%' or tailnum like '%i%';
update planes set qa_tailnum = 'FD'
where cast(substr(tailnum,2,3) as integer) is null;

-- ano
alter table planes add qa_ano varchar(2);
update planes set qa_ano = 'M'
where to_number(ano) is null; -- 60 com NA
update planes set qa_ano = 'I'
where ano <> 'NA' and ano < '1950'; -- 1 com 0	

-- tipo
alter table planes add qa_tipo varchar(1);
update planes set qa_tipo = 'M'
where tipo is null or trim(tipo) = '';
create table tipo_cat (tipo_cat varchar(50));
insert into tipo_cat values ('Fixed wing multi engine');
insert into tipo_cat values ('Fixed wing single engine');
insert into tipo_cat values ('Rotorcraft');
update planes set qa_tipo = 'C'
where tipo not in (select tipo_cat from tipo_cat);

-- manufacturer
alter table planes add qa_manufacturer varchar(1);
update planes set qa_manufacturer = 'M'
where manufacturer is null or trim(manufacturer) = '';
create table plane_cat (plane_cat varchar(50));
insert into plane_cat values ('AIRBUS             ');
insert into plane_cat values ('BOEING             ');
insert into plane_cat values ('BOMBARDIER         ');
insert into plane_cat values ('CESSNA             ');
insert into plane_cat values ('EMBRAER            ');
insert into plane_cat values ('SIKORSKY           ');
insert into plane_cat values ('CANADAIR           ');
insert into plane_cat values ('PIPER              ');
insert into plane_cat values ('MCDONNELL DOUGLAS  ');
insert into plane_cat values ('CIRRUS             ');
insert into plane_cat values ('BELL               ');
insert into plane_cat values ('KILDALL GARY       ');
insert into plane_cat values ('LAMBERT RICHARD    ');
insert into plane_cat values ('BARKER JACK        ');
insert into plane_cat values ('ROBINSON HELICOPTER');
insert into plane_cat values ('GULFSTREAM         ');
insert into plane_cat values ('MARZ BARRY         ');
update planes set qa_manufacturer = 'C'
where manufacturer not in (select trim(plane_cat) from plane_cat);

-- model
alter table planes add qa_model varchar(1);
update planes set qa_model = 'M'
where model is null or trim(model) = '';
update planes set qa_model = 'F'
where (manufacturer = 'AIRBUS' and substr(model,1,1) <> 'A')
or (manufacturer = 'BOEING' and substr(model,1,1) <> '7')
or (manufacturer in ('BOMBARDIER','CANADAIR') and substr(model,1,2) <> 'CL')
or (manufacturer = 'MCDONNELL DOUGLAS' and substr(model,1,2) not in ('MD','DC')); -- 15 da Boeing
--select * from planes where qa_model = 'F'

-- engines
alter table planes add qa_engines varchar(1);
update planes set qa_engines = 'M'
where engines is null;
update planes set qa_engines = 'I'
where engines not between 1 and 4;

-- seats
alter table planes add qa_seats varchar(1);
update planes set qa_seats = 'M'
where seats is null;
update planes set qa_seats = 'I'
where seats not between 2 and 500;

-- speed
alter table planes add qa_speed varchar(1);
update planes set qa_speed = 'M'
where speed is null or trim(speed) = '' or speed = 'NA'; -- 2622
-- ou usando to_number
update planes set qa_speed = 'M'
where speed is null or trim(speed) = '' or to_number(speed) is null; -- 2622
update planes set qa_speed = 'I'
where to_number(speed) not between 50 and 150;

-- engine 
alter table planes add qa_engine varchar(1);
update planes set qa_engine = 'M'
where engine is null or trim(engine) = '';
create table engine_cat ( engine_cat varchar(50) );
insert into engine_cat values ('Turbo-fan');
insert into engine_cat values ('Turbo-jet');
insert into engine_cat values ('Turbo-prop');
insert into engine_cat values ('Turbo-shaft');
insert into engine_cat values ('4 Cycle');
update planes set qa_engine = 'C'
where trim(engine) not in (select trim(engine_cat) from engine_cat); -- 10 = Reciprocating
--select * from planes where qa_engine = 'C'

