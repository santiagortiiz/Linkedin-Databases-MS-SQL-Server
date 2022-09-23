-- Functions
SELECT CONCAT('abc', ' ', 'def') AS string

SELECT RAND()

SELECT GETDATE()

SELECT * FROM fn_my_permissions(NULL, 'SERVER')

SELECT DB_NAME()

-- 1. Create Function
/* Template
CREATE FUNCTION schema.func_name(@parameter_name AS parameter_data_type, ...)
RETURNS return_data_type
BEGIN
	function_body
	RETURN scalar_expression
END;
*/

/*
The function needs to be either the only function in the query window OR 
the only statement in the batch. If there are more statements in the query window, 
you can make it the only one "in the batch" by surrounding it with GO's.
https://stackoverflow.com/questions/25002881/create-function-must-be-the-only-statement-in-the-batch
*/
GO
CREATE FUNCTION my_sum_function(@a INT, @b INT)
	RETURNS INT
AS
BEGIN
	DECLARE @result INT = 0
	SET @result = @a + @b
	RETURN @result
END;
GO

SELECT dbo.my_sum_function(10, 5) AS my_sum;

-- 2. Delete a function
DROP FUNCTION my_sum_function

-- 3. Table-valued functions
/* Template
CREATE FUNCTION schema.func_name(@parameter_name AS parameter_data_type, ...)
RETURNS TABLE
AS
RETURN (sql_expression);
*/
GO
CREATE FUNCTION dbo.GetClientById(@ClientId AS INT)
	RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM Client
		WHERE Client.ClientID = @ClientId
);
GO

SELECT * FROM GetClientById(1);

DROP FUNCTION GetClientById;

-- Multi Statement Table Function
/* Template
CREATE FUNCTION schema.func_name(@parameter_name AS parameter_data_type, ...)
RETURNS @return_variable TABLE (table_structure)
AS
BEGIN
	function_body
	RETURN ;
END;
*/
CREATE FUNCTION dbo.GetClientReservations(@ClientId AS INT)
RETURNS @ClientReservation TABLE
(
	ClientId			INT			NOT NULL,
	ClientName			TEXT		NOT NULL,
	ReservationDateIn	DATETIME	NOT NULL,
	ReservationDateOut	DATETIME	NOT NULL
)
AS
BEGIN
	INSERT @ClientReservation
	SELECT a.ClientId, a.ClientName, b.ReservationDateIn, b.ReservationDateOut
	FROM Client a
		INNER JOIN Reservation b
			ON a.ClientID = b.ReservationClientID
	WHERE ClientId = @ClientId	--parameter usage
	RETURN
END;

SELECT * FROM GetClientReservations(1)

DROP FUNCTION GetClientReservations