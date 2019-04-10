@ECHO OFF
REM
REM
REM		W32TM  :::  Windows Time Service
REM		|
REM		|--> Can query external NTP server(s) as well as modify local workstation NTP config
REM

REM
REM	View current workstation's NTP Configuration
W32TM /query /configuration

REM
REM	View current workstation's NTP Status (Server shown next to 'source: ....')
W32TM /query /status

REM
REM	View peers (which the time-server is syncing to)
W32TM /query /peers

REM NTP host to query the current workstation's time against (hostname or IP)
SET NTP_SERVER=time.google.com


REM --> Grab the [ response delay ] from the NTP server
PING %NTP_SERVER% -n 1


REM --> Grab the [ current time ] from the NTP server
W32TM /stripchart /computer:%NTP_SERVER% /dataonly /samples:5

W32TM /resync /force

PAUSE

EXIT

@ECHO OFF
REM
REM		W32TM  :::  Windows Time Service
REM		|
REM		|--> Updating a workstation's NTP Server (aka update the server which a workstation syncs its time-to)
REM


SET NEW_NTP_SERVER=time.google.com

REG ADD HKLM\SYSTEM\CurrentControlSet\Services\w32time\Parameters /v NtpServer /t REG_SZ /d "%NTP_SERVER%,0x9 NtpServer1,0x9 NtpServer2,0x9 " /f >nul 2>&1

NET STOP W32TIME

NET START W32TIME

EXIT


REM 
REM   NTP-Server - Response testing, 2019-03-15 12:02:39
REM    |
REM    |-->  Google Public NTP, Global    ==>   ping time.google.com && ping time1.google.com && ping time2.google.com && ping time3.google.com && ping time4.google.com
REM    |      |-->   27ms   :::    time.google.com    :::   IPv4 Proxied
REM    |      |-->   26ms   :::    time1.google.com   :::   216.239.35.0
REM    |      |-->   22ms   :::    time2.google.com   :::   216.239.35.4
REM    |      |-->   22ms   :::    time3.google.com   :::   216.239.35.8
REM    |      |-->   21ms   :::    time4.google.com   :::   216.239.35.12
REM    |
REM    |-->  NTP-Pool-Project, Global     ==>   ping pool.ntp.org && ping us.pool.ntp.org
REM    |      |-->   53ms  :::   pool.ntp.org        :::   IPv4 Proxied
REM    |      |-->   59ms  :::   us.pool.ntp.org     :::   IPv4 Proxied
REM    |
REM    |-->  NTP-Pool-Project, USA        ==>   SET NP="us.pool.ntp.org" && ping 0.%NP% && ping 1.%NP% && ping 2.%NP% 3.%NP%
REM    |      |-->   93ms   :::   0.us.pool.ntp.org   :::   74.117.214.2
REM    |      |-->   43ms   :::   1.us.pool.ntp.org   :::   64.6.144.6
REM    |      |-->   63ms   :::   2.us.pool.ntp.org   :::   65.223.27.156
REM    |      |-->   27ms   :::   3.us.pool.ntp.org   :::   45.79.187.10
REM    |
REM    |-->  NTP-Pool-Project, Ubiquiti   ==>   ping 0.ubnt.pool.ntp.org && ping 1.ubnt.pool.ntp.org && ping 2.ubnt.pool.ntp.org && ping 3.ubnt.pool.ntp.org
REM    |      |-->   14ms   :::   0.ubnt.pool.ntp.org   :::   38.229.71.1
REM    |      |-->   19ms   :::   1.ubnt.pool.ntp.org   :::   206.55.191.142
REM    |      |-->   77ms   :::   2.ubnt.pool.ntp.org   :::   69.10.161.7
REM    |      |-->   19ms   :::   3.ubnt.pool.ntp.org   :::   206.55.191.142
REM    |
REM    |-->  Windows Default NTP   ==>   ping time.windows.com && ping time.nist.gov
REM    |      |-->   ERROR  :::   time.windows.com   :::   ??? No Response to ICMP-8 (Ping)
REM    |      |-->   ERROR  :::   time.nist.gov      :::   ??? No Response to ICMP-8 (Ping)
REM


REM Citation(s)
REM
REM		developers.google.com
REM 		"Google Public NTP - Configuring Clients"
REM			 https://developers.google.com/time/guides
REM
REM		docs.microsoft.com
REM			"Windows Time Service Tools and Settings"
REM			 https://docs.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings
REM
REM		support.4it.com
REM			"Check A NTP Server Date And Time Using The Windows Command Prompt"
REM			 https://support.4it.com.au/article/check-a-ntp-server-date-and-time-using-the-windows-command-prompt/
REM