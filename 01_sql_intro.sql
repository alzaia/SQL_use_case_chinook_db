/* 
Subject: SQL basics (SELECT, FROM, WHERE)
Author: Aldo Zaimi
Database: Chinook database (Source: https://www.sqlitetutorial.net/sqlite-sample-database/)

*/

-- Select a column from a table
SELECT AlbumId
FROM albums;

-- Select a column from a table
SELECT ArtistId
FROM artists;

-- Select multiple columns from a table
SELECT AlbumId, ArtistId, Title
FROM albums;
