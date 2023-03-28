
-- TIME Functions
-- Internally stores 3 fields: hour, minute, second
-- Takes 6 bytes (1 for hour, 1 for minute, 4 for second which is DECIMAL(8,6)
-- Supports up to 6 decimal precision for second


SELECT CURRENT_TIME;



SELECT *
FROM DBC.QryLogEvents;


SELECT TYPE(EventTime)
FROM dbc.qrylogevents sample 2;



SELECT EventTime,
CAST(EventTime AS TIME)
FROM DBC.QryLogEvents;


SELECT EventTime,
CAST(EventTime AS TIME WITH TIME ZONE)
FROM DBC.QryLogEvents;


HELP SESSION;


SET TIME ZONE INTERVAL -'05:00' HOUR TO MINUTE;



SELECT EventTime,
TYPE(EventTime),
CAST(EventTime AS TIME),
TYPE(CAST(EventTime AS TIME))
FROM DBC.QryLogEvents;



SELECT EventTime,
TYPE(CAST(EventTime AS TIME)),
CAST(EventTime AS TIME(0)) --field overflow happens because of the decimals
FROM DBC.QryLogEvents;




SELECT EventTime,
CAST( SUBSTRING(TO_CHAR(CAST(EventTime AS TIME)),1,8) AS TIME(0)) TIME_0
FROM DBC.QryLogEvents;




SELECT EventTime,

CAST(EventTime AS TIME) Just_Time,

TO_CHAR(CAST(EventTime AS TIME)) String_Time6,

SUBSTRING(TO_CHAR(CAST(EventTime AS TIME)),1,8) Time0_String,

CAST( SUBSTRING(TO_CHAR(CAST(EventTime AS TIME)),1,8) AS TIME(0)) --if TIME given without (0) TIME(6) is assumed

FROM DBC.QryLogEvents;



-- EXTRACT: extracts hour/minute/second from a TIME field

SELECT 
CURRENT_TIME,
EXTRACT(HOUR FROM CURRENT_TIME),
EXTRACT(MINUTE FROM CURRENT_TIME),
EXTRACT(SECOND FROM CURRENT_TIME);



--Add/subtract to/from a TIME field

SELECT
CURRENT_TIME,
CURRENT_TIME + '01:00:00'; -- Not so easy!



-- INTERVAL

SELECT 
CURRENT_TIME,
CURRENT_TIME + INTERVAL '1' HOUR,
CURRENT_TIME + INTERVAL '10' MINUTE,
CURRENT_TIME + INTERVAL '600' SECOND;




-- Hour/minute/second can simply be individually added 

SELECT
CURRENT_TIME,
CURRENT_TIME - (INTERVAL '4' HOUR) + (INTERVAL '30' MINUTE) +(INTERVAL '1' SECOND);



-- Hour/minute/second can be combined using HOUR TO SECOND 

SELECT 
CURRENT_TIME,
CURRENT_TIME + INTERVAL '01:10:10' HOUR TO SECOND;



-- TIME ZONE

SELECT CURRENT_TIME,
FORMAT(CURRENT_TIME);

