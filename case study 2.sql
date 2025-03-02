create database swiggy

use swiggy

 CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City) VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');


CREATE TABLE DEPARTMENT (
    Department_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Location_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);

INSERT INTO DEPARTMENT (Department_ID, Name, Location_ID) VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);


CREATE TABLE JOB (
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(50)
);

INSERT INTO JOB (Job_ID, Designation) VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');


CREATE TABLE EMPLOYEE (
    Employee_ID INT PRIMARY KEY,
    Last_Name VARCHAR(50),
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Job_ID INT,
    Hire_Date DATE,
    Salary DECIMAL(10,2),
    Commission DECIMAL(10,2),
    Department_ID INT,
    FOREIGN KEY (Job_ID) REFERENCES JOB(Job_ID),
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID)
);

INSERT INTO EMPLOYEE (Employee_ID, Last_Name, First_Name, Middle_Name, Job_ID, Hire_Date, Salary, Commission, Department_ID) VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800.00, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600.00, 300.00, 30),
(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850.00, NULL, 30),
(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750.00, NULL, 30),
(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200.00, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250.00, 50.00, 30);


SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM LOCATION;

SELECT First_Name, Last_Name, Salary, Commission
FROM EMPLOYEE;

SELECT Employee_ID AS ID, Last_Name AS LastName, Department_ID AS DeptID
FROM EMPLOYEE;

SELECT Employee_ID AS "ID of the Employee", Last_Name AS "Name of the Employee", Department_ID AS Dep_id
FROM EMPLOYEE;

SELECT First_Name, Last_Name, Salary * 12 AS Annual_Salary
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE Last_Name = 'Smith';


SELECT *
FROM EMPLOYEE
WHERE Department_ID = 20;


SELECT *
FROM EMPLOYEE
WHERE Salary BETWEEN 2000 AND 3000;


SELECT *
FROM EMPLOYEE
WHERE Department_ID IN (10, 20);


SELECT *
FROM EMPLOYEE
WHERE Department_ID NOT IN (10, 30);


SELECT *
FROM EMPLOYEE
WHERE First_Name LIKE 'L%';


SELECT *
FROM EMPLOYEE
WHERE First_Name LIKE 'L%E';


SELECT *
FROM EMPLOYEE
WHERE LEN(First_Name) = 4 AND First_Name LIKE 'J%';


SELECT *
FROM EMPLOYEE
WHERE Department_ID = 30 AND Salary > 2500;


SELECT *
FROM EMPLOYEE
WHERE Commission IS NULL;


SELECT Employee_ID, Last_Name
FROM EMPLOYEE
ORDER BY Employee_ID ASC;


SELECT Employee_ID, CONCAT(First_Name, ' ', Last_Name) AS Name
FROM EMPLOYEE
ORDER BY Salary DESC;


SELECT *
FROM EMPLOYEE
ORDER BY Last_Name ASC;


SELECT *
FROM EMPLOYEE
ORDER BY Last_Name ASC, Department_ID DESC;


SELECT Department_ID,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary,
       AVG(Salary) AS Avg_Salary
FROM EMPLOYEE
GROUP BY Department_ID;


SELECT Job_ID,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary,
       AVG(Salary) AS Avg_Salary
FROM EMPLOYEE
GROUP BY Job_ID;


SELECT 
    DATEPART(YEAR, Hire_Date) AS Join_Year,
    DATEPART(MONTH, Hire_Date) AS Join_Month,
    COUNT(*) AS Num_Employees
FROM 
    EMPLOYEE
GROUP BY 
    DATEPART(YEAR, Hire_Date),
    DATEPART(MONTH, Hire_Date)
ORDER BY 
    Join_Year ASC,
    Join_Month ASC;



SELECT Department_ID
FROM EMPLOYEE
GROUP BY Department_ID
HAVING COUNT(*) >= 4;



SELECT COUNT(*) AS Num_Employees_February
FROM EMPLOYEE
WHERE MONTH(Hire_Date) = 2;



SELECT COUNT(*) AS Num_Employees_May_June
FROM EMPLOYEE
WHERE MONTH(Hire_Date) IN (5, 6);


SELECT COUNT(*) AS Num_Employees_1985
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985;



SELECT 
    MONTH(Hire_Date) AS Join_Month,
    COUNT(*) AS Num_Employees
FROM 
    EMPLOYEE
WHERE 
    YEAR(Hire_Date) = 1985
GROUP BY 
    MONTH(Hire_Date);
SELECT COUNT(*) AS Num_Employees_April_1985
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
AND MONTH(Hire_Date) = 4;
SELECT Department_ID
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
AND MONTH(Hire_Date) = 4
GROUP BY Department_ID
HAVING COUNT(*) >= 3;


SELECT 
    E.Employee_ID,
    E.Last_Name,
    E.First_Name,
    D.Name AS Department_Name
FROM 
    EMPLOYEE E
INNER JOIN 
    DEPARTMENT D ON E.Department_ID = D.Department_ID;


SELECT 
    E.Employee_ID,
    E.Last_Name,
    E.First_Name,
    J.Designation AS Job_Title
FROM 
    EMPLOYEE E
INNER JOIN 
    JOB J ON E.Job_ID = J.Job_ID;



SELECT 
    E.Employee_ID,
    E.Last_Name,
    E.First_Name,
    D.Name AS Department_Name,
    L.City
FROM 
    EMPLOYEE E
INNER JOIN 
    DEPARTMENT D ON E.Department_ID = D.Department_ID
INNER JOIN 
    LOCATION L ON D.Location_ID = L.Location_ID;



SELECT 
    D.Name AS Department_Name,
    COUNT(*) AS Num_Employees
FROM 
    EMPLOYEE E
INNER JOIN 
    DEPARTMENT D ON E.Department_ID = D.Department_ID
GROUP BY 
    D.Name;



SELECT COUNT(*) AS Num_Employees_Sales
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_ID = D.Department_ID
WHERE D.Name = 'Sales';


SELECT D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_ID = D.Department_ID
GROUP BY D.Name
HAVING COUNT(*) >= 3
ORDER BY Department_Name ASC;



SELECT COUNT(*) AS Num_Employees_Dallas
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_ID = D.Department_ID
JOIN LOCATION L ON D.Location_ID = L.Location_ID
WHERE L.City = 'Dallas';



SELECT 
    E.Employee_ID,
    E.Last_Name,
    E.First_Name,
    D.Name AS Department_Name
FROM 
    EMPLOYEE E
INNER JOIN 
    DEPARTMENT D ON E.Department_ID = D.Department_ID
WHERE 
    D.Name IN ('Sales', 'Operations');



SELECT 
    Employee_ID,
    Last_Name,
    First_Name,
    Salary,
    CASE
        WHEN Salary >= 3000 THEN 'A'
        WHEN Salary >= 2000 AND Salary < 3000 THEN 'B'
        WHEN Salary >= 1000 AND Salary < 2000 THEN 'C'
        ELSE 'D'
    END AS Grade
FROM 
    EMPLOYEE;



	SELECT 
    CASE
        WHEN Salary >= 3000 THEN 'A'
        WHEN Salary >= 2000 THEN 'B'
        WHEN Salary >= 1000 THEN 'C'
        ELSE 'D'
    END AS Grade,
    COUNT(*) AS Num_Employees
FROM 
    EMPLOYEE
GROUP BY 
    CASE
        WHEN Salary >= 3000 THEN 'A'
        WHEN Salary >= 2000 THEN 'B'
        WHEN Salary >= 1000 THEN 'C'
        ELSE 'D'
    END;



	SELECT 
    CASE
        WHEN Salary >= 5000 THEN 'A'
        WHEN Salary >= 4000 THEN 'B'
        WHEN Salary >= 3000 THEN 'C'
        WHEN Salary >= 2000 THEN 'D'
        ELSE 'E'
    END AS Grade,
    COUNT(*) AS Num_Employees
FROM 
    EMPLOYEE
WHERE 
    Salary BETWEEN 2000 AND 5000
GROUP BY 
    CASE
        WHEN Salary >= 5000 THEN 'A'
        WHEN Salary >= 4000 THEN 'B'
        WHEN Salary >= 3000 THEN 'C'
        WHEN Salary >= 2000 THEN 'D'
        ELSE 'E'
    END;



SELECT *
FROM EMPLOYEE
WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE);


SELECT *
FROM EMPLOYEE
WHERE Department_ID = (
    SELECT Department_ID
    FROM DEPARTMENT
    WHERE Name = 'Sales'
);


SELECT *
FROM EMPLOYEE
WHERE Job_ID = (
    SELECT Job_ID
    FROM JOB
    WHERE Designation = 'Clerk'
);


SELECT *
FROM EMPLOYEE
WHERE Department_ID IN (
    SELECT Department_ID
    FROM DEPARTMENT
    WHERE Location_ID IN (
        SELECT Location_ID
        FROM LOCATION
        WHERE City = 'Boston'
    )
);


SELECT COUNT(*) AS Num_Employees_Sales
FROM EMPLOYEE
WHERE Department_ID = (
    SELECT Department_ID
    FROM DEPARTMENT
    WHERE Name = 'Sales'
);


UPDATE EMPLOYEE
SET Salary = Salary * 1.10
WHERE Job_ID = (
    SELECT Job_ID
    FROM JOB
    WHERE Designation = 'Clerk'
);


SELECT *
FROM EMPLOYEE
WHERE Salary = (
    SELECT MAX(Salary)
    FROM EMPLOYEE
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM EMPLOYEE
    )
);



SELECT *
FROM EMPLOYEE
WHERE Salary > ALL (
    SELECT Salary
    FROM EMPLOYEE
    WHERE Department_ID = 30
);



SELECT D.Name AS Department_Name
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.Department_ID = E.Department_ID
WHERE E.Employee_ID IS NULL;



SELECT *
FROM EMPLOYEE E
WHERE Salary > (
    SELECT AVG(Salary)
    FROM EMPLOYEE
    WHERE Department_ID = E.Department_ID
);

