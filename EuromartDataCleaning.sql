--Q1.eastablish relationship between tables as per diagram 

ALTER TABLE ORDERLIST 
ADD CONSTRAINT PK_ORDERID PRIMARY KEY (ORDERID)

ALTER TABLE EACHORDERBREAKDOWN
ADD CONSTRAINT FK_ORDERID FOREIGN KEY (ORDERID) REFERENCES ORDERLIST(ORDERID) 

--Q2.split city states country into 3 individual columns namely 'city','state','country'.

SELECT * FROM Orderlist

ALTER TABLE ORDERLIST
ADD CITY NVARCHAR(50),
    STATE NVARCHAR(50),
    COUNTRY NVARCHAR(50)

UPDATE Orderlist
SET COUNTRY=PARSENAME (REPLACE (City_State_Country,',','.'),1),
    STATE=PARSENAME (REPLACE (City_State_Country,',','.'),2),
    CITY=PARSENAME (REPLACE (City_State_Country,',','.'),3)

ALTER TABLE ORDERLIST
DROP COLUMN CITY_STATE_COUNTRY 

-- Q3.add new category column using the following mapping as per first 3 characters in product name column
--TEC-technology 
--OFS-office supplies 
--FUR-furniture 

SELECT * FROM EachOrderBreakdown

ALTER TABLE EachOrderBreakdown
ADD CATEGORY NVARCHAR(50)

UPDATE EachOrderBreakdown
SET CATEGORY = CASE WHEN LEFT(PRODUCTNAME,3)='OFS'THEN 'OFFICE SUPPLIES'
                    WHEN LEFT(PRODUCTNAME,3)='TEC'THEN 'TECHNOLOGY'
                    WHEN LEFT(PRODUCTNAME,3)='FUR'THEN 'FURNITURE'
END 

--Q4.Extract the  characters after '-' from productname column 
 
UPDATE EachOrderBreakdown
SET ProductName=RIGHT(PRODUCTNAME,LEN(PRODUCTNAME)-CHARINDEX('-',PRODUCTNAME)) 

--Q5.Remove duplicate rows from EachOrderBreakdown table,if all column values are macthing 
  
WITH CTE_DUPLICATE AS (
 SELECT  *, ROW_NUMBER() OVER 
 (PARTITION BY  OrderID,ProductName,Discount,Sales,
 Profit,Quantity,SubCategory,Category ORDER BY Orderid) 
 As RN 
 FROM EachOrderBreakdown)
 DELETE FROM CTE_DUPLICATE
 WHERE RN>1


--Q6 REPLACE BLANK WITH NA IN ORDERPRIORITY COLUMN IN ORDERLIST

SELECT * FROM Orderlist
UPDATE Orderlist
SET OrderPriority='NA'
WHERE OrderPriority IS NULL;



