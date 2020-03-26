/* 
Subject: SQL standard & filtering clauses (WHERE, BETWEEN, IN, LIKE, ORDER BY, GROUP BY, HAVING)
Author: Aldo Zaimi
Database: Chinook database (Source: https://www.sqlitetutorial.net/sqlite-sample-database/)

*/

-- Filter entries with a simple condition
SELECT Milliseconds
FROM Tracks
WHERE Milliseconds >= 5000000;

-- Filter entries between 2 values (for numeric)
SELECT Total
FROM Invoices
WHERE Total BETWEEN 5 AND 15;

-- Filter entries using a list of values (for strings)
SELECT CustomerId, FirstName, LastName, State, Company
FROM Customers
WHERE State IN ('RJ','DF','AB','BC','CA','WA','NY');

-- Filter entries using a combination of logical operators
SELECT CustomerId, InvoiceId, InvoiceDate, Total
FROM Invoices
WHERE CustomerId IN ('56','58') AND Total BETWEEN 1.00 AND 5.00;

-- Filter entries using aliases
SELECT TrackId, Name
FROM Tracks
WHERE Name LIKE 'All%';

-- Filter entries using aliases
SELECT Email, CustomerId
FROM Customers
WHERE Email LIKE 'J%gmail.com';

-- Filter entries and order rows by descending order
SELECT InvoiceId, BillingCity, Total
FROM Invoices
WHERE BillingCity IN ('Brasília','Edmonton','Vancouver')
ORDER BY InvoiceId DESC;

-- Show all distinct values of a column
SELECT DISTINCT State
FROM customers;

-- Find minimun value of a column
SELECT MIN(Total)
FROM Invoices;

-- Find maximum value of a column
SELECT MAX(Total)
FROM Invoices;

-- Find minimun value of a column using a condition
Select MIN(Total)
FROM Invoices
WHERE Total <> 0.99;

-- Filter column with a condition
SELECT InvoiceId, CustomerId, Total
FROM Invoices
WHERE Total = 0.99;

-- Filter with a condition and order by ascending order based on a specific column
SELECT InvoiceId, CustomerId, Total
FROM Invoices
WHERE Total = 0.99
ORDER BY CustomerId ASC;

-- Create new column for calculations
SELECT (MAX(Total) - MIN(Total)) AS Range
FROM Invoices;

-- Count all rows of a table
SELECT COUNT(*) AS nbr_invoices
FROM Invoices;

-- Count all non NULL values for a column
SELECT COUNT(CustomerId) AS nbr_customers
FROM Invoices;

-- Using the GROUP BY clause to group entries based on a specific metric (one row = one group)
SELECT AlbumId, COUNT(Trackid) AS Nbr_tracks
FROM Tracks
GROUP BY AlbumId;

-- Grouping by a metric and filtering the groups
SELECT AlbumId, COUNT(Trackid) AS Nbr_tracks
FROM Tracks
GROUP BY AlbumId
HAVING Nbr_tracks >= 12;

-- Grouping by a metric, filtering the groups and ordering the groups
SELECT AlbumId, COUNT(Trackid) AS Nbr_tracks
FROM Tracks
GROUP BY AlbumId
HAVING Nbr_tracks >= 19
ORDER BY Nbr_tracks ASC;





