
	    cd C:/MD/Jobs/dir2500/2693

	    if {[catch {
		# Key variables
		namespace eval job {}
		set ::job::id 2693
		set ::job::serverId 1025
		array set MDPriv {path C:/MD/2.0/JobServer logfile C:/MD/2.0/JobServer/logs/MedeAPC.log}

		namespace eval ::MedeA {}
		set ::MedeA::platform Windows-x86
		array set ::MedeA::Directory {binarylib C:/MD/2.0/bin/Windows-x86/Windows-x86.kit MedeA C:/MD/2.0 root C:/MD/2.0 platform C:/MD/2.0/bin/Windows-x86/Windows-x86.kit bin C:/MD/2.0/bin/Windows-x86 generic C:/MD/2.0/bin/generic tcllib C:/MD/2.0/bin/generic/tcllib.kit data C:/MD/2.0/data JobServer C:/MD/2.0/bin/generic/JobServer.kit medealib C:/MD/2.0/bin/generic/MedeALib.kit wd C:/MD/2.0/JobServer}
		
		# The MedeA/GoVASP mode
		set ::MedeA::mode1 {medea}
		set ::MedeA::app_name {MedeA}
		
		# the main libraries
		source C:/MD/2.0/bin/Windows-x86/Windows-x86.kit
		source C:/MD/2.0/bin/generic/MedeALib.kit
		source [file join C:/MD/2.0/bin/generic JobServer.kit]

		# the path...
		set env(PATH) {C:\MD\2.0\bin\Windows-x86;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\Program Files\Common Files\Roxio Shared\DLLShared\;C:\Program Files\Common Files\Roxio Shared\10.0\DLLShared\;C:\Program Files\QuickTime\QTSystem\;c:\Program Files\Microsoft SQL Server\90\Tools\binn\;C:\MD\Windows-x86}
		set auto_path {C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib C:/MD/2.0/bin/Windows-x86/mdJobServer.exe/lib/tcl8.4 C:/MD/2.0/bin/Windows-x86/mdJobServer.exe/lib C:/MD/2.0/bin/generic/JobServer.kit/lib C:/MD/2.0/bin/generic/JobServer.kit/lib/tcllib1.10 C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/Windows-x86/Windows-x86.kit/lib C:/MD/2.0/bin/generic/MedeALib.kit/lib C:/MD/2.0/bin/generic/MedeALib.kit/lib C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/tcllib.kit/lib C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../custom C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/tcllib1.10 C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/bin/../lib/til C:/MD/2.0/bin/generic/JobServer.kit/lib/til}

		# the packages...
		package require log
		package require JobUtilities

		# and the rest of the initialization
		initialize
		# Do the work!
		run
	    } msg]} {
		puts "==============================================================="
		puts "ERROR!!!
$::errorInfo"
		error $msg $::errorInfo
	    }
	
