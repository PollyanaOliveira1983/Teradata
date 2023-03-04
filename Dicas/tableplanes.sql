database pollyana.ferreira@capgemini.com;

show table "marcos.nagato@capgemini.com".planes;

CREATE SET TABLE "pollyana.ferreira@capgemini.com".planes ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      tailnum VARCHAR(6) CHARACTER SET LATIN NOT CASESPECIFIC,
      ano VARCHAR(4) CHARACTER SET LATIN NOT CASESPECIFIC,
      tipo VARCHAR(24) CHARACTER SET LATIN NOT CASESPECIFIC COMPRESS ('Fixed wing multi engine','Fixed wing single engine','Rotorcraft'),
      manufacturer VARCHAR(29) CHARACTER SET LATIN NOT CASESPECIFIC COMPRESS ('AIRBUS INDUSTRIE','BOEING','AIRBUS','BOMBARDIER INC','CESSNA','EMBRAER','SIKORSKY','CANADAIR','PIPER','MCDONNELL DOUGLAS','BELL','CIRRUS DESIGN CORP','KILDALL GARY','LAMBERT RICHARD','BARKER JACK L','ROBINSON HELICOPTER CO','GULFSTREAM AEROSPACE','MARZ BARRY','MCDONNELL DOUGLAS AIRCRAFT CO'),
      model VARCHAR(14) CHARACTER SET LATIN NOT CASESPECIFIC,
      engines SMALLINT,
      seats SMALLINT,
      speed VARCHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
      engine VARCHAR(13) CHARACTER SET LATIN NOT CASESPECIFIC COMPRESS ('Turbo-fan','Turbo-jet','Reciprocating','Turbo-prop','Turbo-shaft','4 Cycle'))
PRIMARY INDEX ( tailnum );


--Tarefas 1. 
--Crie a coluna qa_tailnum e aponte inconsistências da coluna tailnum de acordo com as regras abaixo: 

select * from planes;

ALTER TABLE planes
ADD qa_tailnum VARCHAR(6) CHARACTER SET LATIN NOT CASESPECIFIC
;

--M : Indica que está com dado faltante. 

update planes set qa_tailnum = 'M'
where (tailnum is Null
or trim(tailnum) = ''
or length(trim(tailnum))= 0 
);

--S : Indica que não tem exatamente 5 ou 6 caracteres. 

update planes set qa_tailnum = 'S'
where (tailnum) is not null
and trim(tailnum) <> ''
and (length(trim(tailnum)) < 5
or length(trim(tailnum)) > 6
);

--FN : Indica que não inicia com a letra "N".
update planes set qa_tailnum = null;

update planes set qa_tailnum = 'FN'
where tailnum not like 'N%'
;

--FE : Indica que contém caracteres inválidos ("I", "O", ou 0 como primeiro digito). 

update planes set qa_tailnum = null;

update planes set qa_tailnum = 'FE'
where substr(tailnum,2,1) = '0' 
or tailnum like '%o%' 
or tailnum like '%i%'
;

--FD : Indica caracteres não numéricos em posições onde tem que haver dígito. 

update planes
set qa_tailnum = 'FD'
where TO_NUMBER(SUBSTRING(tailnum FROM 2 For 4)) is null;

--2. Crie a coluna qa_ano e aponte inconsistências da coluna ano de acordo com as regras abaixo: 

ALTER TABLE planes
ADD qa_ano VARCHAR(4) CHARACTER SET LATIN NOT CASESPECIFIC

;

--M : Indica que não possui informação de ano. 60

update planes set qa_ano = 'M'
where (ano is Null
or trim(ano) = ''
or to_number(ano) is null
);

--I : Indica que o valor excede o intervalo [1950,+∞).

select * from planes;

update planes set qa_ano = null;

update planes set qa_ano = 'I'
where ano > 1950
;

--3. Crie a coluna qa_tipo e aponte inconsistências da coluna tipo de acordo com as regras abaixo: 
ALTER TABLE planes
ADD qa_tipo VARCHAR(24);

--M : Indica que está com dado faltante. 
update planes set qa_tipo = 'M'
where (tipo is Null
or trim(tipo) = ''
or length(trim(tipo))= 0 
);

--C : Indica que o valor não pertence a nenhuma categoria esperada:  Fixed wing multi engine /   Fixed wing single engine  /  Rotorcraft  

select * from planes;

update planes set qa_tipo = null;

update planes set qa_tipo = 'C'
where tipo NOT IN ('Fixed wing multi engine', 'Fixed wing single engine', 'Rotorcraft ')
;

--4. Crie a coluna qa_manufacturer e aponte inconsistências da coluna manufacturer de acordo com as regras abaixo: 

ALTER TABLE planes 
ADD qa_manufacturer VARCHAR(29) 
;

--M : Indica que está com dado faltante. 

update planes
set qa_manufacturer = 'M'
where (manufacturer is Null
or trim(manufacturer) = ''
or length(trim(manufacturer))= 0 
);

--C : Indica que o valor não pertence a nenhuma categoria esperada: 
-- AIRBUS /  BOEING  /  BOMBARDIER /  CESSNA /  EMBRAER  /  SIKORSKY /  CANADAIR /  PIPER / 
-- MCDONNELL DOUGLAS /  CIRRUS /  BELL  /  KILDALL GARY /  LAMBERT RICHARD /  BARKER JACK /
-- ROBINSON HELICOPTER /  GULFSTREAM /  MARZ BARRY 

update planes set qa_manufacturer = null;

update planes set qa_manufacturer = 'C'
where manufacturer NOT IN ('AIRBUS', 'BOEING', 'BOMBARDIER', 'CESSNA', 'EMBRAER', 'SIKORSKY', 'CANADAIR', 'PIPER', 'MCDONNELL DOUGLAS',
'CIRRUS', 'BELL', 'KILDALL GARY', 'LAMBERT RICHARD', 'BARKER JACK', 'ROBINSON HELICOPTER', 'GULFSTREAM', 'MARZ BARRY'
)
;

--5. Crie a coluna qa_model e aponte inconsistências da coluna model de acordo com as regras abaixo: 

ALTER TABLE planes 
ADD qa_model VARCHAR(14)
;

--M : Indica que está com dado faltante. 

update planes
set qa_model = 'M'
where (model is Null
or trim(model) = ''
or length(trim(manufacturer))= 0 
);

--F : Indica que não respeita o formato esperado /  Modelos AIRBUS devem começar com "A" / Modelos BOEING devem começar com "7" 
-- Modelos BOMBARDIER e CANADAIR devem começar com "CL" /  Modelos MCDONNELL DOUGLAS devem começar com "MD" ou "DC"  ---15

update planes set qa_model = null;

select manufacturer, model, qa_model from planes;

update planes 
set qa_model = 'F'
where (manufacturer like 'AIRBUS' and model not like 'A%')
or (manufacturer like 'BOEING' and model not like '7%')
or (manufacturer like 'BOMBARDIER' and model not like 'CL%')
or (manufacturer like 'CANADAIR' and model not like 'CL%')
or (manufacturer like 'MCDONNELL DOUGLAS' and model not like 'MD%'
and manufacturer like 'MCDONNELL DOUGLAS' and model not like 'DC%');

----------------------ou ----------------------

update planes set qa_model = 'F'
where (manufacturer = 'AIRBUS' and substr(model,1,1) <> 'A')
or (manufacturer = 'BOEING' and substr(model,1,1) <> '7')
or (manufacturer in ('BOMBARDIER','CANADAIR') and substr(model,1,2) <> 'CL')
or (manufacturer = 'MCDONNELL DOUGLAS' and substr(model,1,2) not in ('MD','DC'));

--6. Crie a coluna qa_engines e aponte inconsistências da coluna engines de acordo com as regras abaixo: 

ALTER TABLE planes
ADD qa_engines char(1);

--M : Indica que está com dado faltante. 

update planes set qa_engines = 'M'
where (engines is Null
or trim(engines) = ''
or length(trim(engines))= 0 
);

--I : Indica que o valor excede o intervalo [1, 4]. 

update planes set qa_engines = 'I'
where (engines) is not null
and trim(engines) <> ''
and (length(trim(engines)) not between 1 and 4

);

--7. Crie a coluna qa_seats e aponte inconsistências da coluna seats de acordo com as regras abaixo:

ALTER TABLE planes
ADD qa_seats char(1);

--M : Indica que está com dado faltante.
update planes set qa_seats = 'M'
where (seats is Null
or trim(seats) = ''
or length(trim(seats))= 0 
);

--I : Indica que o valor excede o intervalo [2, 500]. 

update planes set qa_seats = 'I'
where (seats) is not null
and trim(seats) <> ''
and (length(trim(seats)) not between 2 and 500

);

--8. Crie a coluna qa_speed e aponte inconsistências da coluna speed de acordo com as regras abaixo:
 
ALTER TABLE planes
ADD qa_speed VARCHAR(3)
;

--M : Indica que está sem informação de velocidade. 2622
 
update planes
 set qa_speed = 'M'
 Where (speed is null 
 or speed = '0' 
 or to_number(speed) is null 
 );
 
--I : Indica que o valor excede o intervalo [50, 150]. 

update planes set qa_speed = null;

update planes set qa_speed = 'I'
where to_number(speed) not between 50 and 150
;

select * from planes;

--9. Crie a coluna qa_engine e aponte inconsistências da coluna engine de acordo com as regras abaixo:

ALTER TABLE planes
ADD qa_engine VARCHAR(13)
;
--M : Indica que está com dado faltante. 

update planes
 set qa_engine = 'M'
 Where (engine is null 
 or trim(engine) = '' 
 );
 
--C : Indica que o valor não pertence a nenhuma categoria esperada:  Turbo-fan  /  Turbo-jet  /  Turbo-prop /  Turbo-shaft 
-- 4 Cycle

update planes 
set qa_engine = 'C'
where engine not like '%Turbo-fan%'
and engine not like '%Turbo-jet%'
and engine not like '%Turbo-prop%'
and engine not like '%Turbo-shaft%'
and engine not like '%Cycle%'
;



-----------------------------OUUUUU------------------------------------------------------
create table engine_cat ( engine_cat varchar(50) );
insert into engine_cat values ('Turbo-fan');
insert into engine_cat values ('Turbo-jet');
insert into engine_cat values ('Turbo-prop');
insert into engine_cat values ('Turbo-shaft');
insert into engine_cat values ('4 Cycle');

update planes set qa_engine = 'C'
where trim(engine) not in (select trim(engine_cat) 
from engine_cat);
