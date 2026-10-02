--Q1.List the top 10 orders with highest sales  from eachorderbreakdown
 
 SELECT * FROM EachOrderBreakdown

  SELECT TOP 10 * 
  FROM EachOrderBreakdown 
  ORDER BY SALES DESC
   
--Q2 Show number of orders for each product category in eachorderbreakdown table 
 
 Select CATEGORY ,COUNT(*) AS TOTALORDERS 
 from EachOrderBreakdown
 GROUP BY CATEGORY

 --Q3.Find total profit for each sub category in eachorderbreakdown table 


 Select SubCategory,SUM(Profit) AS totalprofit from EachOrderBreakdown
 Group By SubCategory
  