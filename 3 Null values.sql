DECLARE @a INT = NULL
DECLARE @b INT = NULL
DECLARE @c INT = 1

IF(@a = @b)
BEGIN
	PRINT('both are null')
END

IF(@a IS NULL)
BEGIN
	PRINT('@a is null')
END