
@ECHO  OFF
	SET FolderToDelete=%programdata%\LabTech Client\Cache\
	CALL:recursive_dir_delete "%FolderToDelete%"
	TIMEOUT /T 10
	EXIT

	: recursive_dir_delete
	ECHO.
	ECHO  In Runtime:
	ECHO  DeleteIfExists %1
	ECHO.
	IF EXIST %1 (
		ECHO  Calling:
		ECHO  RMDIR %1 /S /Q
		RMDIR %1 /S /Q
		IF EXIST %1 (
			ECHO  Success - Directory was deleted
		) ELSE (
			ECHO  Failed - Directory delete operation failed
		)
	) ELSE (
		ECHO  Failed - Can't delete a directory which doesn't already exist
	)
	ECHO.
	EXIT /B

