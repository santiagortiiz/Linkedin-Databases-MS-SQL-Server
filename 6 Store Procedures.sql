-- Store Procedures

/* Template
CREATE PROCEDURE procedure_name
@parameter_A data_type = default
@parameter_B data_type = default)
OUT | OUTPUT
AS
BEGIN

END;

Notes:
- procedure_name must not begin with sp
*/

-- Simple
CREATE PROCEDURE dbo.uspGetClients
AS
SELECT * FROM Client

EXEC dbo.uspGetClients
EXECUTE dbo.uspGetClients

DROP PROCEDURE dbo.uspGetClients;

-- With parameters
CREATE PROCEDURE dbo.uspGetClientsByNames
	@LastName NVARCHAR(50),
	@Name NVARCHAR(50)
AS
SELECT ClientName, ClientLastName, ClientEmail, ClientCountryAddress
FROM Client
WHERE ClientName = @Name AND ClientLastName = @LastName

EXEC dbo.uspGetClientsByNames @LastName = N'Lynch', @Name =	N'Steven';

DROP PROCEDURE dbo.uspGetClientsByNames;

-- Calling functions from inside
CREATE PROCEDURE dbo.GetFullNameByEmail
	@Email NVARCHAR(50) = ''
AS
SELECT CONCAT(ClientName, ClientLastName) AS FullName, ClientEmail
FROM Client
WHERE ClientName LIKE '%' + @Email + '%'

EXEC dbo.GetFullNameByEmail
EXEC dbo.GetFullNameByEmail @Email = N'john'

DROP PROCEDURE dbo.GetFullNameByEmail;

-- Using Output for nested procedure calls
CREATE PROC dbo.uspGetReservationsCount
@ClientID INT,
@ReservationsCount INT OUTPUT --Allows another executions to use the result of this one
AS
SELECT @ReservationsCount = COUNT(*)
FROM dbo.Reservation
WHERE ReservationClientID = @ClientID

DECLARE @reservations INT
EXEC dbo.uspGetReservationsCount @ClientID = 1, @ReservationsCount = @reservations OUTPUT
SELECT @reservations AS reservations_number

-- Call functions without the name of the parameters
DECLARE @ReservationsCount INT
EXEC dbo.uspGetReservationsCount 2, @ReservationsCount = @ReservationsCount OUTPUT
SELECT @ReservationsCount AS reservations_number

DROP PROCEDURE dbo.uspGetReservationsCount;

-- Errors
CREATE PROCEDURE dbo.uspError
AS
SELECT 1/0

EXEC dbo.uspError

DROP PROCEDURE dbo.uspError;

-- Error Handling
CREATE PROCEDURE dbo.uspErrorHandled
AS
BEGIN TRY
	SELECT 1/0
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS error_number
	,ERROR_STATE() AS error_state
	,ERROR_MESSAGE() AS error_message
	,ERROR_SEVERITY() AS error_severity
	,ERROR_LINE() AS error_line
	,ERROR_PROCEDURE() AS error_procedure;
END CATCH

EXEC dbo.uspErrorHandled

DROP PROCEDURE dbo.uspErrorHandled;