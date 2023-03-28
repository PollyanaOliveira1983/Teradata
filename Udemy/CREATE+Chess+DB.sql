database "pollyana.ferreira@capgemini.com";

show table airports;


CREATE DATABASE "CHESS"
    FROM "UDM" AS
    PERMANENT = 1000000000,
    SPOOL = 39662995374,
    TEMPORARY = 39662995374,
    ACCOUNT = 'UDM',
    FALLBACK,
    NO BEFORE JOURNAL,
    NO AFTER JOURNAL;