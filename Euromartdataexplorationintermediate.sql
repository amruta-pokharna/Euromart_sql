--Q1.Identify the customer with highest total sales across all orders 

select * from Orderlist
select * from EachOrderBreakdown

select top 1 CustomerName ,SUM(SALES) AS TOTALSALES 
from Orderlist ol
Join EachOrderBreakdown ob
ON 
ol.OrderID=ob.OrderID
Group By CustomerName
Order by TOTALSALES desc


--Q2.Find the month with highest average sales in orderlist table 

SELECT  MONTH(ORDERDATE) AS MONTH,
AVG(SALES) AS AVERAGESALES 
FROM Orderlist OL 
JOIN EachOrderBreakdown OB
ON 
OL.OrderID=OB.OrderID
GROUP BY MONTH(ORDERDATE)
ORDER BY AVERAGESALES DESC

--Q3.Find out the average quantity ordered by customers whose first name starts with an alphabet 's ?
SELECT 
AVG(QUANTITY) AS AVERAGEQUANTITY
FROM Orderlist OL
JOIN EachOrderBreakdown OB
ON 
OL.OrderID=OB.OrderID
WHERE LEFT (CUSTOMERNAME,1)='S'
ORDER BY AVERAGEQUANTITY 
