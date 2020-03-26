/* 
Subject: Strings operations (concatenation, TRIM, SUBSTR, UPPER, LOWER, UCASE, ...), date/time functions (DATE, TIME, DATETIME, STRFTIME, ...) and CASE
Author: Aldo Zaimi
Database: Chinook database (Source: https://www.sqlitetutorial.net/sqlite-sample-database/)

*/


-- Combining 2 string columns together and putting everything upper case
SELECT CustomerId, FirstName, LastName, Address, City, Country, UPPER(City || ' ' || Country) AS CityCountry
FROM customers;

-- Extracting substrings, concatenating them together and putting everything lower case
SELECT EmployeeId, FirstName, LastName, LOWER(SUBSTR(FirstName,1,4) || SUBSTR(LastName,1,2)) AS NewId
FROM employees;

-- Compute the number of years from hire date to the today date
SELECT FirstName, LastName, HireDate, 
(STRFTIME('%Y', 'now') - STRFTIME('%Y', HireDate)) - (STRFTIME('%m-%d', 'now') < STRFTIME('%m-%d', HireDate)) AS YearsWorked
FROM Employees
WHERE YearsWorked >= 15
ORDER BY LastName ASC;

-- Count the number of days since a datetime variable and today
SELECT 	FirstName, LastName, (ROUND(JULIANDAY('now') - JULIANDAY(HireDate))) AS nbr_days_since_hiring
FROM Employees;

-- Create individual variables to extract the year, month and day
SELECT 	FirstName, LastName, STRFTIME('%Y',HireDate) AS Year, STRFTIME('%m',HireDate) AS Month, STRFTIME('%d',HireDate) AS Day
FROM Employees;

-- Using CASE statements to create new categories
SELECT FirstName, LastName, City,
CASE
WHEN City =='Prague' THEN 'From Prague'
WHEN City <> 'Prague' THEN 'OTHER'
END AS CityCategory
FROM customers;




