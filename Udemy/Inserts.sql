 database "pollyana.ferreira@capgemini.com";
 
CREATE SET TABLE CHESS.Products
    (
    PROD_ID SMALLINT PRIMARY KEY NOT NULL,
    PROD_DESC VARCHAR(50),
    PRICE DEC(8,2) COMPRESS(0,1.00),
    DISCOUNT_IND CHAR(1),
    EXPIRE_DT DATE FORMAT 'YYYY-MM-DD',
    ENTRY_TS TIMESTAMP(6)
    );
    



--INSERT INTO "CHESS"."Products"  
--("PROD_ID", "PROD_DESC", "PRICE", "DISCOUNT_IND", "EXPIRE_DT", "ENTRY_TS")  
--VALUES(1,'Honey',9.99,'Y','2025-06-30','2021-01-17 18:00:00.000000') ;
--
--INSERT INTO "CHESS"."Products"  
--("PROD_ID", "PROD_DESC", "PRICE", "DISCOUNT_IND", "EXPIRE_DT", "ENTRY_TS")  
--VALUES(2,'Bicycle',399.998,'Y','2099-01-01',NULL) ;
----
--INSERT INTO "CHESS"."Products"  
--VALUES(3,'Tomato paste',2.49,'y','2022-01-01',NULL) ;
--
--INSERT INTO "CHESS"."Products"  
--("PROD_ID", "PROD_DESC", "PRICE", "DISCOUNT_IND", "EXPIRE_DT")  
--VALUES(4,'Shampoo',6.00,,'2028-01-01') ;
----
--INSERT INTO "CHESS"."Products"  
--VALUES(5,'Tomato paste',2.49,,CURRENT_DATE,CAST('01/15/2022' AS TIMESTAMP(6) FORMAT 'MM/DD/YYYY')) ;
