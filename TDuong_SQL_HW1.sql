#PART 1: Querying the World and Chinook Databases
#WORLD DATABASE QUESTIONS:
#Easy
#1. List all countries in South America. 
SELECT name FROM country WHERE continent = "South America";
#2. Find the population of 'Germany'.
SELECT population FROM country WHERE name = "Germany";
#3. Retrieve all cities in the country 'Japan'. 
SELECT name FROM city WHERE CountryCode = "JPN";
#Medium
#4. Find the 3 most populated countries in the 'Africa' region. 
SELECT Name, Population FROM country WHERE Continent = "Africa" ORDER BY Population DESC LIMIT 3;
#5. Retrieve the country and its life expectancy where the population is between 1 and 5 million. 
SELECT name, LifeExpectancy, Population FROM country WHERE Population BETWEEN 1000000 and 5000000;
#6. List countries with an official language of 'French'
SELECT name,LANGUAGE, countrylanguage.IsOfficial FROM country
JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T";

#CHINOOK DATABASE QUESTIONS
#7. Retrieve all album titles by the artist 'AC/DC'. 
SELECT Title FROM Album
JOIN Artist ON Album.ArtistId = Artist.ArtistId
WHERE Artist.Name = "AC/DC";
#8. Find the name and email of customers located in 'Brazil'. 
SELECT FirstName, LastName, Email FROM Customer WHERE Country = 'Brazil';
#9. List all playlists in the database. 
SELECT Name FROM Playlist;
#10. Find the total number of tracks in the 'Rock' genre. 
SELECT COUNT(Track.Name) FROM Track
JOIN Genre ON Genre.GenreID = Track.GenreId
WHERE Genre.Name = "Rock";
#11. List all employees who report to 'Nancy Edwards'. 
SELECT FirstName, LastName FROM Employee WHERE ReportsTo IN (SELECT EmployeeID FROM Employee WHERE FirstName = "Nancy" AND LastName = "Edwards");
#12. Calculate the total sales per customer by summing the total amount in invoices. 
SELECT SUM(Total), CustomerID FROM Invoice GROUP BY CustomerID;

#PART 2: CREATE YOUR OWN DATABASE 
CREATE DATABASE Lemonade_Stand;
USE Lemonade_Stand;

#Table No. 1 describes all sales of the lemonade stand small business.
CREATE TABLE Sales (
SalesID INT,
CustomerID INT,
SaleDate DATE,
SaleTime TIME,
FlavorID INT,
Total DECIMAL(6,2)
);

ALTER TABLE Sales
ADD PRIMARY KEY (SalesID);

INSERT INTO Sales (
SalesID, CustomerID, SaleDate, SaleTime, FlavorID, Total
) VALUES
(1, 1, "2024-09-06", "08:00:00", 1, "2.00"),
(2, 2, "2024-09-06", "11:00:00", 5, "3.00"),
(3, 1, "2024-09-07", "08:30:00", 3, "2.50"),
(4, 3, "2024-09-07", "09:00:00", 4, "2.50"),
(5, 4, "2024-09-07", "12:00:00", 2, "2.50"),
(6, 5, "2024-09-07", "15:20:00", 5, "3.00")
;

#Table No. 2 describes Customers of the lemonade stand.
CREATE TABLE Customers (
CustomerID INT,
FirstName VARCHAR(6),
LastName VARCHAR(10)
 );
 
ALTER TABLE Customers
ADD PRIMARY KEY (CustomerID);
 
INSERT INTO Customers (CustomerID, FirstName, LastName)
 VALUES 
 (1, "Thuha", "Nguyen"),
 (2, "Luong", "Khuu"),
 (3, "Kateri", "Milligan"),
 (4, "Vy", "Khanh"),
 (5, "Emma", "Khan");
 
 ALTER TABLE Sales
ADD FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

 #Table No. 3 describes Flavor types of lemonade sold at the lemonade stand.
 CREATE TABLE Flavors(
 FlavorID INT,
 Flavor VARCHAR(10)
 );
 
ALTER TABLE Flavors
ADD PRIMARY KEY (FlavorID);

INSERT INTO Flavors (FlavorID, Flavor) 
VALUES 
(1, "Lemon"),
(2, "Strawberry"),
(3, "Watermelon"),
(4, "Raspberry"),
(5, "Mint");

ALTER TABLE Sales
ADD FOREIGN KEY (FlavorID) REFERENCES Flavors(FlavorID);

#3 Queries extracting data from database.
#What is the total revenue from sales on September 7?
SELECT SUM(Total) FROM Sales WHERE SaleDate = "2024-09-07";

#What is the most popular flavor lemonade from all sales?
SELECT Sales.FlavorID, Flavors.Flavor, COUNT(Sales.FlavorID) AS `Count` FROM Sales
JOIN Flavors ON Flavors.FlavorID = Sales.FlavorID
GROUP BY Sales.FlavorID
ORDER BY `count` DESC LIMIT 1;

#What is the full name of the customer who purchased Watermelon lemonade?
SELECT Sales.CustomerID, Customers.FirstName, Customers.LastName FROM Sales
JOIN Customers ON Customers.CustomerID = Sales.CustomerID
WHERE FlavorID = 3;
