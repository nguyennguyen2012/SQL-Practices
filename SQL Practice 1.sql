/* Exercise 1. From table DimEmployee, select all records that satisfy one of the following conditions: 
• DepartmentName is equal to 'ToolDesign' 
• Status does NOT include the value NULL 
• StartDate in the period from '2009-01-01' to '2009-12-31' 
And must have VacationHours > 10 */ 

SELECT * 
FROM dbo.DimEmployee
WHERE (DepartmentName = 'Tool Design'
OR Status IS NOT NULL
OR StartDate BETWEEN '2009-01-01' AND '2009-12-31')
AND VacationHours > 10 

/* Exercise 2. From DimEmployee table, get EmployeeKey, then: 
- Generate a new field named 'Full Name' which combined FirstName, MiddleName, LastName columns 
(Noted that MiddleName might contain NULL) 
- Calculate age of each Employee when they are hired using HireDate, BirthDate columns  
- Calculate age of each Employee today using BirthDate column 
- Get user name of each employee. Username is last part of login ID: adventure-works\jun0 -> Username = jun0 
*/ 

SELECT 
-- Ý 1
FirstName, 
MiddleName, 
LastName, 
-- FirstName + ' ' + MiddleName + ' ' + LastName,
-- REPLACE (CONCAT(FirstName, ' ', MiddleName, ' ', LastName), '  ', ' '),  -- Cách 1 
-- FirstName + ISNULL(' ' + MiddleName, '') + ' ' + LastName, -- Cách 2 
CONCAT_WS(' ', FirstName, MiddleName, LastName) as FullName, 
-- Ý 2
DATEDIFF(year, BirthDate, HireDate) as AgeHired,
-- Ý 3  
DATEDIFF(year, BirthDate, GETDATE()) as AgeToday,
-- Ý 4 
SUBSTRING(loginID, CHARINDEX('\', loginID) + 1, LEN(LoginID)) as UserName_substring, -- Cách 1
RIGHT(LoginID, LEN(LoginID) - CHARINDEX('\', loginID)) as UserName_right -- Cách 2
FROM DimEmployee


/*Exercise 3. From DimProduct display ProductKey, ProductAlternateKey and EnglishProductName of products  
which have ProductAlternateKey begins with 'BK-' followed by any character other than 'T' and ends with a '-' followed by any two numerals.  
And satisfy one of the following conditions: 
· color are black, red, or white  
· size from 48 to 57  */

SELECT ProductKey, 
ProductAlternateKey, 
EnglishProductName, 
Color, 
Size  
FROM DimProduct
WHERE ProductAlternateKey LIKE 'BK-[^T]%-[0-9][0-9]' --regex
AND (
    Color IN ('Black', 'White', 'Red')
    OR Size BETWEEN 48 and 57
)


/*Exercise4. From DimProduct, get ProductKey of products which have Color is 'Red' */ 

SELECT ProductKey
FROM dbo.DimProduct
WHERE Color = 'Red'


/*Exercise5. From FactInternetSales get all records that have sold products which have Color equal to "red" 
*/ 

SELECT * 
FROM dbo.FactInternetSales 
WHERE ProductKey IN (SELECT ProductKey
FROM dbo.DimProduct
WHERE Color = 'Red')

-- Cách 2 sử dụng 

SELECT FIS.*
FROM dbo.FactInternetSales as FIS
JOIN dbo.DimProduct as DP
ON FIS.ProductKey = DP.ProductKey 
WHERE Color = 'Red'
