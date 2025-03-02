create database casestudy1 

use casestudy1

select * from fact
select * from location
select * from product

select count('state') as [no of state] from location

select count(product) as product_count from product where Type = 'regular'

select sum (marketing) as marketing_spend from fact where productId = 1

select min(sales) as min_sales from fact

select max(cogs) as max_cogs from fact

SELECT * FROM Product
WHERE Product_Type= 'COFFEE'

SELECT * FROM Fact
WHERE Total_Expenses > 40

SELECT AVG(SALES) AS SALESVALUE FROM Fact
WHERE Area_Code = 719

SELECT SUM(PROFIT) AS 'PROFITBYCOLORADOSTATE'
FROM Fact F
INNER JOIN
Location L
ON
F.Area_Code=L.Area_Code
WHERE State='Colorado'


SELECT AVG(Inventory) AS AVG_INVENTORY_SALE,ProductId
FROM Fact
GROUP BY ProductId
ORDER BY ProductId


SELECT DISTINCT STATE 
FROM Location
ORDER BY State 

SELECT AVG(BUDGET_MARGIN) AS MARGIN ,ProductId
FROM Fact
GROUP BY PRODUCTID
HAVING AVG(BUDGET_MARGIN)>100


SELECT SUM(SALES) AS SALESVALUE
FROM Fact
WHERE Date ='2010-01-01'


SELECT AVG(TOTAL_EXPENSES) AS AVGPRICE,ProductId,Date
FROM Fact
GROUP BY ProductId,Date
ORDER BY ProductId


SELECT F.Date,F.ProductId,P.Product_Type,P.Product,F.Sales,F.Profit,L.State,L.Area_Code
FROM Fact f
INNER JOIN 
Product p
ON
F.ProductId=P.ProductId
INNER JOIN
Location l
ON
l.Area_Code=F.Area_Code


select sales, dense_rank()over(order by sales asc) as salesrank from fact
order by sales desc

select sum(f.profit) as 'profit' , sum(f.sales) as'sales',
l.state
from fact f
inner join 
location l
on
f.area_code=l.area_code
group by l.state



select sum(profit) as 'profit' , sum(f.sales) as 'sales',
l.state,p.product
from fact f
inner join
product p
on 
p.productId=f.productId
inner join
location l
on
l.Area_Code=f.Area_Code
group by l.state,p.product



select sales,(sales*1.05) as increseinper
from fact

SELECT MAX(F.PROFIT) AS PROFIT,p.ProductId,P.Product_Type
FROM Fact f
INNER JOIN
Product P
ON
P.ProductId=F.ProductId
GROUP BY  p.ProductId,P.Product_Type
ORDER BY P.ProductId




CREATE PROC PRODUCT_TYPE(@PRO_TYP VARCHAR(30))
AS
SELECT * FROM Product
WHERE Product_Type=@PRO_TYP

EXEC PRODUCT_TYPE @PRO_TYP='COFFEE'




SELECT Total_Expenses,IIF(TOTAL_EXPENSES<60,'PROFIT','LOSS') AS STATUS
FROM Fact


SELECT DATEPART(WEEK,DATE) AS DATE_PART,SUM(SALES) AS SUM_SALES,ProductID
FROM Fact
GROUP BY ProductId ,DATEPART(WEEK,DATE) WITH ROLLUP



SELECT AREA_CODE FROM Fact
UNION
SELECT AREA_CODE FROM Location

SELECT AREA_CODE FROM Fact
INTERSECT
SELECT AREA_CODE FROM Location


CREATE FUNCTION GETPRODUCTBYTYPE(@PRODUCTTYP VARCHAR(30))
RETURNS TABLE
AS
RETURN
SELECT * FROM Product
WHERE Product_Type= @PRODUCTTYP

SELECT * FROM DBO.GETPRODUCTBYTYPE ('COFFEE') 