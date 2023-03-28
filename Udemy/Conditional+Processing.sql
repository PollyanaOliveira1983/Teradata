
-- CASE Statements: enables conditional processing of the rows

-- Valued CASE Expression: evaluates a set of expressions for equality to return a result

SELECT P.*,
CASE 
	WHEN "Title"='GM' THEN 'Grand Master'
	WHEN "Title"='IM' THEN 'International Master'
	WHEN "Title"='FM' THEN 'Fide Master'
	ELSE "Title"
END AS Full_Title
FROM CHESS.Players P;



-- Searched CASE Expression: evaluates a search condition to return a result

SELECT P.*,
CASE "Title"
	WHEN 'GM' THEN 'Grand Master'
	WHEN 'IM' THEN 'International Master'
	WHEN 'FM' THEN 'Fide Master'
	ELSE "Title"
END AS Full_Title
FROM CHESS.Players P;



-- COALESCE: returns the first non_NULL value of the inputs. If all NULL, returns NULL

SELECT
COALESCE(1, NULL),
COALESCE(NULL, 1),
COALESCE(NULL, NULL, NULL),
COALESCE(NULL, NULL, NULL, 'Hey!');



SELECT 
TableName,
CommentString,
COALESCE(CommentString, 'No description') Nicer_Answer --adding some description to the output
FROM DBC.Tables;



-- NULLIF: returns NULL if the two given values are equal (to convert a certain value to NULL)

SELECT 
P.*,
NULLIF(Inactive_IND,'') Inactive_IND_Updated
FROM CHESS.Players P;

