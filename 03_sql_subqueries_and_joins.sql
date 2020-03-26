/* 
Subject: SQL subqueries, joins (CROSS, INNER, LEFT, SELF) and unions (UNION)
Author: Aldo Zaimi
Database: Chinook database (Source: https://www.sqlitetutorial.net/sqlite-sample-database/)

*/

-- PART 1: SUBQUERIES - * - * - * - 

-- Example of standard subquery
-- The link between the 2 tables is albumid
-- Nested query: return albumid for specific title
-- Outer query: return tracks that have that albumid
SELECT trackid, name, albumid
FROM tracks
WHERE albumid = (
	SELECT albumid 
	FROM albums 
	WHERE title = 'Let There Be Rock'
	);

-- Example of subquery using IN
-- Link between Customers and Employees table: SupportRepId
-- Nested query: find SupportRepId of employees that are in Canada
-- Outer query: find Customers that were managed by those SupportRepId
SELECT CustomerId, FirstName, LastName
FROM Customers
WHERE SupportRepId IN (
	SELECT EmployeeId 
	FROM Employees 
	WHERE Country = 'Canada'
	);

-- Previous example without using subqueries
-- First query: find all SupportRepId in Canada
-- Second query: use these SupportRepId to create new quary to extract Customers

SELECT EmployeeId 
FROM Employees 
WHERE Country = 'Canada';

SELECT CustomerId, FirstName, LastName
FROM Customers
WHERE SupportRepId IN (1,2,3,4,5,6,7,8);


-- Same example with subqueries, adding order by
SELECT CustomerId, FirstName, LastName, SupportRepId
FROM Customers
WHERE SupportRepId IN (
	SELECT EmployeeId 
	FROM Employees 
	WHERE Country = 'Canada'
	)
ORDER BY SupportRepId ASC;

-- Using subqueries to Combine aggregate functions
-- First step: Compute the SUM() of each album based on tracks it has and group by AlbumId
-- Second step: Get the AVG() of the album sizes
SELECT AVG(album_size)
FROM (
	SELECT SUM(Bytes) AS album_size 
	FROM tracks 
	GROUP BY AlbumId
	) 
AS album_average_size;

-- PART 2: JOINS (CROSS, INNER, LEFT, SELF) - * - * - * - 

-- Example of cross join: important to specify table in SELECT if same column in both tables
SELECT albums.AlbumId, trackid
FROM albums
CROSS JOIN tracks;

-- Inner join: join tracks and albums based on the album id
SELECT trackid, name, title
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid;

-- Same example: you can see that it matches the albumid column of tracks with the albumid column of albums
SELECT trackid, name, tracks.albumid AS album_id_tracks, albums.albumid AS album_id_albums, title
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid;

-- Another inner join example
SELECT Title, Name
FROM albums
INNER JOIN artists ON artists.ArtistId = albums.ArtistId;

-- Same example but now using aliases to simplify (l for albums and r for artists)
SELECT l.Title, r.Name
FROM albums l
INNER JOIN artists r ON r.ArtistId = l.ArtistId;

-- Same example: no need to specify table if both columns have the same name
SELECT Title, Name
FROM albums
INNER JOIN artists USING (ArtistId);

-- inner join with 3 tables: tracks, albums and artists
-- Link between albums table and artists table is ArtistId
-- Link between tracks table and albums table is AlbumId
SELECT trackid, tracks.name AS track, albums.title AS album, artists.name AS artist
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid;

-- Same example, filtering results by adding a where clause at the end
SELECT trackid, tracks.name AS Track, albums.title AS Album, artists.name AS Artist
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid
WHERE artists.artistid = 10;

-- Left join: all rows in table artists are included in the result set whether there are matching rows in table albums or not
SELECT Name, Title
FROM artists
LEFT JOIN albums ON artists.ArtistId = albums.ArtistId
ORDER BY Name;

-- Left join and adding a WHERE clause
SELECT Name, Title
FROM artists
LEFT JOIN albums ON artists.ArtistId = albums.ArtistId
WHERE Title IS NULL   
ORDER BY Name;

-- Cross join example
SELECT albums.AlbumId
FROM albums
CROSS JOIN tracks;

-- Union to combine results between queries
-- The JOIN clause combines columns from multiple related tables, 
-- while UNION combines rows from multiple similar tables.
SELECT FirstName, LastName, 'Employee' AS Type
FROM employees
UNION
SELECT FirstName, LastName, 'Customer'
FROM customers;

-- Same as last example, order by added at the end
SELECT FirstName, LastName, 'Employee' AS Type
FROM employees
UNION
SELECT FirstName, LastName, 'Customer'
FROM customers
ORDER BY FirstName, LastName;

-- PART 3: Examples from the SQL for Data Science course in Coursera - * - * - * - 


-- Find how many albums artist Led Zeppelin has
-- artists table: ArtistId, Name
-- albums table: AlbumId, Title, ArtistId
-- 1) Find ArtistId for Name Led Zeppelin
-- 2) Find albums for that ArtistId
SELECT COUNT(*) AS Nbr_albums_zeppelin
FROM albums
WHERE ArtistId = (
SELECT ArtistId 
FROM artists 
WHERE Name = 'Led Zeppelin'
)

-- We need a table of Album titles and unit prices for a specific artist
-- artists --- albums --- tracks
SELECT albums.Title, tracks.UnitPrice
FROM Albums
INNER JOIN Tracks ON albums.AlbumId = tracks.AlbumId -- join albums and tracks based on album id
INNER JOIN Artists ON artists.ArtistID = albums.ArtistID -- join artists and albums based on artist id
WHERE artists.Name = 'Audioslave' -- find artist id for that name

-- Find the first and last name of any customer who does not have an invoice
SELECT n.FirstName, n.LastName, i.Invoiceid
FROM customers n 
	LEFT JOIN invoices i ON n.Customerid = i.Customerid
WHERE InvoiceId IS NULL

-- Find the total price for each album.
SELECT t.Title, SUM(p.UnitPrice)
FROM albums t
	INNER JOIN tracks p ON t.Albumid = p.Albumid
WHERE t.Title = 'Big Ones'
GROUP BY t.Title

-- Find many records are created when you apply a Cartesian join to the invoice and invoice items table
SELECT a.invoiceId D
FROM invoices a CROSS JOIN invoice_items b;

-- Using a subquery, find the names of all the tracks for the album "Californication"
SELECT tracks.Name FROM tracks where tracks.AlbumId =
(SELECT AlbumId FROM albums WHERE albums.Title = 'Californication')

--Find the total number of invoices for each customer along with the customer's full name, city and email.
-- invoices and customers: customerid in common
-- we want to find the customers who have invoices = inner join
SELECT FirstName, LastName, City, Email, COUNT(I.CustomerId) AS Nbr_Invoices
FROM Customers C 
INNER JOIN Invoices I
ON C.CustomerId = I.CustomerId
GROUP BY C.CustomerId

--Retrieve the track name, album, artistID, and trackID for all the albums.
SELECT A.Title, T.Name, A.AlbumId, A.ArtistId, T.TrackId
FROM albums A
INNER JOIN tracks T
ON T.AlbumId = A.AlbumId

--Retrieve a list with the managers last name, and the last name of the employees who report to him or her.
SELECT M.LastName AS Manager, E.LastName AS Employee
FROM Employees E 
INNER JOIN Employees M 
ON E.ReportsTo = M.EmployeeID

--Find the name and ID of the artists who do not have albums.
SELECT Name AS Artist,
       Artists.ArtistId,
       Albums.Title AS Album
FROM Artists
LEFT JOIN Albums
ON Artists.ArtistId = Albums.ArtistId
WHERE Album IS NULL

--Using a UNION to create a list of all the employee's and customer's first names 
-- and last names ordered by the last name in descending order.
SELECT FirstName, LastName
FROM employees
UNION
SELECT FirstName, LastName
FROM customers
ORDER BY LastName DESC

--See if there are any customers who have a different city listed in their billing city versus their customer city.
SELECT C.FirstName, C.LastName, C.City AS CustomerCity, I.BillingCity
FROM Customers C
INNER JOIN Invoices I
ON C.CustomerId = I.CustomerId
WHERE CustomerCity <> BillingCity




