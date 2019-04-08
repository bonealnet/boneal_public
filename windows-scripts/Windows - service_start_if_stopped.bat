@echo off
REM /* MAKE A SCHEDULED TASK TO RUN THIS EVERY [X] MINUTES TO KEEP SERVICE ALIVE (x=5 originally)*/	

	set labtech_folder=C:\Windows\LTSvc
	
	set service1="ltservice"
	set service2="ltsvcmon"
	set tray="LTTray.exe"

	Call:stop_tray_if_services_are_stopped %tray% %service1% %service2%
	
	Call:service_start_if_stopped %service1%

	Call:service_start_if_stopped %service2%
	
	Exit

: service_start_if_stopped
	sc query %1 | findstr "RUNNING" > nul
	echo.
	if not ERRORLEVEL 1 (
		echo   Service  %1  is running. Great!
		timeout 1
	) else (
		echo   Service  %1  is not running. Starting it ...
		sc start %1
	)
	rem timeout 5
	Exit /B
	
: stop_tray_if_services_are_stopped
	sc query %2 | findstr "RUNNING" > nul
	if ERRORLEVEL 1 (
		sc query %3 | findstr "RUNNING" > nul
		if ERRORLEVEL 1 (
			echo   %1 must be stopped before services are restarted...
			taskkill /im %1
		)
	)
	rem timeout 5
	Exit /B
