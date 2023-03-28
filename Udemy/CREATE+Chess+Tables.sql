
--CHESS.Players Table
CREATE TABLE CHESS.Players
    ( FIDE_ID INT NOT NULL,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Country CHAR(3),
    GENDER CHAR(1),
    Rating SMALLINT,
    Birth_Year SMALLINT,
    "Title" VARCHAR(3) UPPERCASE,
    Inactive_IND CHAR(1) 
  	)
PRIMARY INDEX (FIDE_ID);


    
--CHESS.Countries Table
CREATE TABLE CHESS.Countries
    (
    Country_CD CHAR(3) NOT NULL,
    Country_Name VARCHAR(100) NOT NULL,
    Continent VARCHAR(10)
    )
PRIMARY INDEX(country_CD);



--CHESS.Games Table
CREATE TABLE CHESS.Games
    (
    Event_ID INT,
    Event_Name VARCHAR(100),
    Site VARCHAR(50),
    Game_Date DATE,
    Game_Round VARCHAR(10),
    White_ID INT,
    Black_ID INT,
    Game_Result VARCHAR(10),
    ECO CHAR(3),
    Opening VARCHAR(20),
    PGN VARCHAR(10000)
    )
PRIMARY INDEX (Event_ID);

