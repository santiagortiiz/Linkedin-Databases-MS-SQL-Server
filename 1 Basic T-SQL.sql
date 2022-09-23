USE AdventureWorks2019

SELECT top 5 * FROM Person.StateProvince;
SELECT top 5 WITH TIES IsOnlyStateProvinceFlag
	,StateProvinceCode
	,CountryRegionCode
	,Name
FROM Person.StateProvince 
ORDER BY IsOnlyStateProvinceFlag;

SELECT top 20 SafetyStockLevel, ReorderPoint FROM Production.Product

SELECT CustomerID
	,PersonID
	,AccountNumber
FROM Sales.Customer;

-- Functions
SELECT LEFT(EmailAddress, 5) FROM Person.EmailAddress

-- Nested function
SELECT LEFT(UPPER(EmailAddress), CHARINDEX('@', EmailAddress, 1) - 1) FROM Person.EmailAddress

-- Simple CASE Expression
SELECT StateProvinceId
	,CountryRegionCode
	,CASE CountryRegionCode
		WHEN 'US' THEN 'My Home'
		ELSE 'Other Region'
		END AS country
FROM Person.StateProvince 
ORDER BY StateProvinceId ASC;

-- Searched CASE Expression
SELECT SafetyStockLevel
	,ReorderPoint
	,CASE 
		WHEN ReorderPoint < 600 THEN 'lower'
		WHEN ReorderPoint = 600 THEN 'enough'
		WHEN ReorderPoint > 600 THEN 'abundant'
	ELSE 'not defined'
	END AS priceRange
FROM Production.Product

-- Groups and aggregations
SELECT SafetyStockLevel, SUM(ReorderPoint) AS sum_of_reorder_points
FROM Production.Product
GROUP BY SafetyStockLevel

-- Filtering groups
SELECT SafetyStockLevel, SUM(ReorderPoint) AS sum_of_reorder_points
FROM Production.Product
GROUP BY SafetyStockLevel
HAVING SUM(ReorderPoint) > 500