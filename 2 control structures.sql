-- Variables
DECLARE @clientId INT;
DECLARE @clientName VARCHAR(50);

SET @clientName = 'Santiago'
SET @clientId = 1

PRINT @ClientId;
PRINT @clientName;

-- Declare multiple variables at once
DECLARE @clientId INT,
		@clientName VARCHAR(50),
		@name VARCHAR(50) = 'Santiago Ortiz';

PRINT @name

-- IF statement
DECLARE @flag INT = 1;

IF(@flag = 1)
BEGIN
	PRINT 'True'
END

-- IF, ELSE Statements
DECLARE @flag2 INT = 1;

IF(@flag2 = 1)
BEGIN
	PRINT 'True'
END
ELSE
BEGIN
	PRINT 'False'
END

-- While Loop
DECLARE @counter INT = 1;

WHILE(@counter <= 3)
BEGIN
	PRINT @counter
	SET @counter = @counter + 1
END

-- CASE
DECLARE @var INT = 1
SELECT
	CASE @var
		WHEN 1 THEN 'one'
		WHEN 2 THEN 'two'
		WHEN 3 THEN 'three'
	END AS variable