--- Restore Backup: Follow the below steps to restore a backup of your database using SQLServer Management Studio:
--a. Open SQL Server Management Studio and connect to the target SQL Server instance --b. Right-click on the Databases Node and select Restore Database
--c. Select Device and click on the ellipsis (...) d. In the dialog box, select Backup devices, click on Add, navigate to the database backup in the file system of the server, select the backup, and click on OK.
 --e. If needed, change the target location for the data and log files in the Files pane
--Note: It is a best practice to place the data and log files on different drives. -- f. Now, click on OK

--Perform the following with help of the above database: -- a. Get all the details from the person table including email ID, phone number and phone number type
--b. Get the details of the sales header order made in May 2011 --c. Get the details of the sales details order made in the month of May 2011
 --d. Get the total sales made in May 2011 -- e. Get the total sales made in the year 2011 by month order by increasing sales 
 -- f. Get the total sales made to the customer with the first name='Gustavo' and lastname = 'Achong'  



SELECT 
    p.*, 
    e.EmailAddress, 
    ph.PhoneNumber, 
    pnt.Name AS PhoneNumberType
FROM 
    Person.Person AS p
LEFT JOIN 
    Person.EmailAddress AS e ON p.BusinessEntityID = e.BusinessEntityID
LEFT JOIN 
    Person.PersonPhone AS ph ON p.BusinessEntityID = ph.BusinessEntityID
LEFT JOIN 
    Person.PhoneNumberType AS pnt ON ph.PhoneNumberTypeID = pnt.PhoneNumberTypeID;



	SELECT * 
FROM Sales.SalesOrderHeader 
WHERE OrderDate BETWEEN '2011-05-01' AND '2011-05-31';

SELECT sod.* 
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE soh.OrderDate BETWEEN '2011-05-01' AND '2011-05-31';


SELECT 
    SUM(TotalDue) AS TotalSales 
FROM 
    Sales.SalesOrderHeader 
WHERE 
    OrderDate BETWEEN '2011-05-01' AND '2011-05-31';

SELECT 
    MONTH(OrderDate) AS Month, 
    SUM(TotalDue) AS MonthlySales 
FROM 
    Sales.SalesOrderHeader 
WHERE 
    YEAR(OrderDate) = 2011
GROUP BY 
    MONTH(OrderDate)
ORDER BY 
    MonthlySales ASC;


SELECT 
    SUM(soh.TotalDue) AS TotalSales 
FROM 
    Sales.SalesOrderHeader AS soh
JOIN 
    Person.Person AS p ON soh.CustomerID = p.BusinessEntityID
WHERE 
    p.FirstName = 'Gustavo' AND p.LastName = 'Achong';
