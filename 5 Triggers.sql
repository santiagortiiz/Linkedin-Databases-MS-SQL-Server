-- Triggers
/* Template
CREATE TRIGGER trigger_name
	ON subject_table
{FOR | AFTER} {INSERT | UPDATE | DELETE }
AS
BEGIN
	sql_statement
END
*/

-- INSERT AFTER INSERT
CREATE TRIGGER dbo.Reservation_INSERT
	ON dbo.Reservation
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ClientId INT;

	SELECT @ClientId = inserted.ReservationClientId
	FROM inserted

	INSERT INTO dbo.Log
	VALUES('Automatic inserte log', 'Client ' + CAST(@ClientId AS VARCHAR) + 'was updated')
END

DROP TRIGGER dbo.Reservation_INSERT;

-- INSERT AFTER UPDATE
CREATE TRIGGER dbo.Room_UPDATE
	ON dbo.Room
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @RoomID INT
	DECLARE @Action VARCHAR(100)

	SELECT @RoomId = inserted.RoomID
	FROM inserted

	IF UPDATE(RoomName)
	BEGIN
		SET @Action = 'Updated Name'
	END

	IF UPDATE(RoomDescription)	
	BEGIN
		SET @Action = 'Updated Description'
	END

	INSERT INTO dbo.Log
	VALUES('Automatic update log', @Action + ' on Room ' + CAST(@RoomID AS VARCHAR))
END

DROP TRIGGER dbo.Room_UPDATE;

-- INSERT AFTER DELETE
CREATE TRIGGER dbo.Reservation_DELETE
	ON dbo.Reservation
AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @RoomID INT

	SELECT @RoomId = deleted.ReservationRoomID
	FROM deleted

	INSERT INTO dbo.Log
	VALUES('Automatic delete log', 'Room ' + CAST(@RoomID AS VARCHAR) + ' is now available')
END

DROP TRIGGER dbo.Reservation_DELETE;
