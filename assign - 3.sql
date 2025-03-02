select * from restaurants

ALTER TABLE Restaurants
ADD OwnerEmail VARCHAR(255);



CREATE PROCEDURE GetRestaurantsWithTableBooking
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        RestaurantName,
        RestaurantType,
        CuisineType
    FROM 
        Jomato
    WHERE 
        TableBooking <> 0;
END;

DROP PROCEDURE GetRestaurantsWithTableBooking;



CREATE PROCEDURE GetRestaurantsWithTableBooking
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        RestaurantName,
        RestaurantType,
        CuisineType
    FROM 
        jomato.dbo.Restaurants
    WHERE 
        TableBooking <> 0;
END;

EXEC GetRestaurantsWithTableBooking;


BEGIN TRANSACTION;

UPDATE restaurants
SET CuisineType = 'Cafeteria'
WHERE CuisineType = 'Cafe';

SELECT * FROM restaurants

rollback


alter table restaurants add area varchar(255)

UPDATE restaurants
SET area = 'chennai'
WHERE no =1

UPDATE restaurants
SET area = 'avadi'
WHERE no =2

UPDATE restaurants
SET area = 'ambattur'
WHERE no =3

UPDATE restaurants
SET area = 'kumkakonam'
WHERE no =4

UPDATE restaurants
SET area = 'kurattur'
WHERE no =5

UPDATE restaurants
SET area = 'anna nagar'
WHERE no =6

UPDATE restaurants
SET area = 'bessy'
WHERE
no =7



WITH RankedRestaurants AS (
    SELECT 
        area,
        Ratings,
        ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Ratings DESC) AS RowNumber
    FROM 
        restaurants
)
SELECT 
    area,
    Ratings
FROM 
    RankedRestaurants
WHERE 
    RowNumber <= 5;



	DECLARE @counter INT = 1;

WHILE @counter <= 50
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END;


CREATE VIEW TopRatingView AS
WITH RankedRestaurants AS (
    SELECT 
        RestaurantName,
        CuisineType,
        Ratings,
        ROW_NUMBER() OVER (ORDER BY Ratings DESC) AS RowNumber
    FROM 
        Restaurants
)
SELECT 
    RestaurantName,
    CuisineType,
    Ratings
FROM 
    RankedRestaurants
WHERE 
    RowNumber <= 5;

	SELECT * FROM TopRatingView;

	CREATE TRIGGER SendEmailOnInsert
ON Restaurants
AFTER INSERT
AS
BEGIN
    DECLARE @OwnerEmail NVARCHAR(255);
    DECLARE @RestaurantName NVARCHAR(255);
    DECLARE @Subject NVARCHAR(255);
    DECLARE @Body NVARCHAR(MAX);

   
    SELECT @OwnerEmail = OwnerEmail, @RestaurantName = RestaurantName
    FROM inserted;

    SET @Subject = 'New Restaurant Added: ' + @RestaurantName;
    SET @Body = 'Dear Restaurant Owner,' + CHAR(13) + CHAR(10) +
                'A new restaurant (' + @RestaurantName + ') has been added to the database.';


    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'dhivya',
        @recipients = @OwnerEmail,
        @subject = @Subject,
        @body = @Body;
END;


SELECT * 
FROM sys.triggers 
WHERE name = 'SendEmailOnInsert';
