
--How to match patterns including wildcard characters of % or _ ?

select * from chess.games;


--For example rows matching _

select * from chess.games
where game_result like '%_%'


--Syntax for escape characters

select * from chess.games
where game_result like '%z_%' escape 'z'


--Let's copy the players table

create table chess.players_copy as (select * from chess.players) with data;


--players_copy

select * from chess.players_copy


--Add % to a last name

update chess.players_copy set last_name='Naj%er' where fide_id=4118987



--Add _ to a lastname

update chess.players_copy set last_name='Khairu_lin' where fide_id=4151348



--Add % and _ to a lastname
update chess.players_copy set last_name='Ng__%io%%___en' where fide_id=12401110


--select all changed rows
select * from chess.players_copy where fide_id in (4118987, 4151348, 12401110)


--Match those patterns

select * from chess.players_copy where last_name like '%x%%' escape 'x'


select * from chess.players_copy where last_name like '%z_%' escape 'z'


select * from chess.players_copy where last_name like '%z_%z%%' escape 'z'


--Drop the copied table

drop table chess.players_copy
