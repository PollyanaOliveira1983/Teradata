

-- TYPE: returns the data type of a value

SELECT TOP 1
	TYPE(FIDE_ID),
	TYPE(First_Name),
	TYPE(Last_Name),
	TYPE(Country),
	TYPE(GENDER),
	TYPE(Rating),
	TYPE(Birth_Year),
	TYPE("Title"),
	TYPE(Inactive_IND)
FROM CHESS.Players; --SHOW TABLE/VIEW is usually easier



--CONCAT (or ||, two vertical bars): attaches multiple strings

SELECT 
First_Name,
Last_Name,
First_Name||' '||Last_Name  Full_Name_1,
CONCAT(First_Name, ' ', Last_Name) Full_Name_2
FROM CHESS.Players
ORDER BY RATING DESC;



-- SUBSTRING(value, N, M): gets substring value from Nth character for a length of M. 

SELECT 
First_Name,
Last_Name,
SUBSTRING(First_Name, 3) Third_to_End, --if M is not specified, the rest of the string is returned
SUBSTRING(First_Name, 3,2) Third_to_Fourth,
SUBSTRING(First_Name, 1,3) First_to_Third
FROM CHESS.Players
ORDER BY RATING DESC;



-- SUBSTR(value, N, M): gets substring value from Nth character for a length of M. 

SELECT 
First_Name,
Last_Name,
SUBSTR(First_Name, 3) Third_to_End, --if M is not specified, the rest of the string is returned
SUBSTR(First_Name, 3,2) Third_to_Fourth,
SUBSTR(First_Name, 1,3) First_to_Third
FROM CHESS.Players
ORDER BY RATING DESC;



-- TRIM: removes extra leading (left) or trailing (right) spaces from a string

SELECT 
First_Name,
'  '||First_Name||' ' FN_Wtih_Spaces,
TRIM('  '||First_Name||' ') Trimmed_FN,
LTRIM('  '||First_Name||' ') Left_Trimmed_FN,
RTRIM('  '||First_Name||' ') Right_Trimmed_FN
FROM CHESS.Players
ORDER BY RATING DESC;



-- UPPER/LOWER: changes characters to UPPER/LOWER case

SELECT
First_Name,
UPPER(First_Name) First_Name_UPPER,
LOWER(First_Name) First_Name_LOWER
FROM CHESS.Players
ORDER BY RATING DESC;



-- INDEX: returns the starting position of a substring in a string. If not found, returns 0.

SELECT
First_Name,
INDEX(First_Name, 'a') start_of_a,
INDEX(First_Name, 'li') start_of_li
FROM CHESS.Players
ORDER BY RATING DESC;



-- POSITION: similar to INDEX, returns the starting position of a substring in a string. If not found, returns 0.

SELECT
First_Name,
POSITION('a' IN First_Name) start_of_a,
POSITION('li' IN First_Name) start_of_li
FROM CHESS.Players
ORDER BY RATING DESC;



-- LENGTH: returns length of a string

SELECT
First_Name,
LENGTH(First_Name) FN_Length
FROM CHESS.Players
ORDER BY RATING DESC;



-- OTRANSLATE: to replace characters in a string

SELECT 
First_Name,
OTRANSLATE(First_Name, 'a', 'x'), --'a' characters are replacled by 'x'
OTRANSLATE(First_Name, 'a', ''), -- 'a' characters are replaced by '' (which means deleted)
OTRANSLATE(First_Name, 'ao', 'xq') --'a' characters are replacled by 'x', 'o' characters are replacled by 'q'
FROM CHESS.Players
ORDER BY RATING DESC;



-- OREPLACE: replaces every occurance of search_string in the source_string with the replace_string

SELECT 
First_Name,
OREPLACE(First_Name, 'lad', ' This One is a Master ')
FROM CHESS.Players
ORDER BY RATING DESC;


SELECT
'www.google.com',
OREPLACE('www.google.com', '.com', '.io')