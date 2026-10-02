--Find out how many new customers were acquired in year 2014?
 SELECT * FROM Orderlist
 SELECT COUNT(*) AS NUMBEROFNEWCUSTOMERS 
 FROM(
 SELECT CustomerName ,MIN(orderdate) 
 As Firstorder
 FROM Orderlist
 GROUP BY CustomerName
HAVING YEAR(MIN(ORDERDATE))= '2014'
) AS CUSTOMER2014


--Calculate the percentage of total profit contributed by each sub-category to overall profit

SELECT * FROM EachOrderBreakdown


SELECT SubCategory,
SUM(PROFIT) AS TOTALPROFIT,
SUM(PROFIT)/(SELECT SUM(PROFIT) FROM EachOrderBreakdown)*100 AS PERCETAGEOFTOTAL
FROM EachOrderBreakdown
GROUP BY SUBCATEGORY 



---Q3.Find average sales per customer ,considering only customers who have made more than one order.

WITH CUSTOMERAVGSALES AS(
SELECT CustomerName ,
COUNT (DISTINCT OL.ORDERID) AS NOOFORDERS,
AVG (SALES) AS AVGSALES 
FROM Orderlist OL
JOIN EachOrderBreakdown OB 
ON OL.OrderID=OB.OrderID
GROUP BY CustomerName
)
SELECT CustomerName,AVGSALES,NOOFORDERS
FROM CUSTOMERAVGSALES 
WHERE NOOFORDERS>1



--Identify the top performing subcategory in each category based on total sales .
--Include the sub category name,total sales and a ranking of sub category within each category 


select * from EachOrderBreakdown


WITH TopPerformers 
AS
(
SELECT  CATEGORY,
SubCategory ,
SUM(SALES) AS TOTALSALES,
RANK() OVER (PARTITION BY CATEGORY 
ORDER BY SUM(SALES) DESC) 
AS SUBCATEGORYRANK
FROM EachOrderBreakdown
GROUP BY CATEGORY,SubCategory
)

SELECT * FROM TopPerformers
WHERE SUBCATEGORYRANK=1


