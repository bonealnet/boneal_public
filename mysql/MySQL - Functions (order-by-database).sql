SELECT
	ROUTINE_SCHEMA,
	ROUTINE_NAME,
	ROUTINE_COMMENT
FROM 
	information_schema.ROUTINES
WHERE
	ROUTINE_SCHEMA = 'boneal_dev'
AND 
	ROUTINE_TYPE = 'FUNCTION'