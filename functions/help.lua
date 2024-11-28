function help()
	--man this is ugly
	mtext.mprint("license")
	mtext.mprint("prints the latest license straight from the hub")
	sleep(2)
	mtext.mprint("\nhelp (tier 0 required)")
	sleep(1)

	mtext.mprint("chat (tier 0 required)")
	mtext.mprint("chat. Requires a modem of some kind.")
	mtext.mprint("Anyone else that wants to join they must have the host name.")
	--mtext.mprint("I usually use 'Internet', which is why I call it internet.")
	sleep(3)

	mtext.mprint("\nrun (tier 1 required)")
	mtext.mprint("Notice: you must type 'run' first to start the command.")
	sleep(4)

	mtext.mprint("")
	mtext.mprint("exit (reboots computer; tier 0 required)")
	mtext.mprint("If you are tier 2+, then it will simply exit the program.")
	sleep(4)

	mtext.mprint("")
	mtext.mprint("reboot (tier 0 required)")
	mtext.mprint("Reboots the computer. Purpose is being a reboot command for tier 2+")
	sleep(4)
        
	mtext.mprint("\ndiscord (gives you a discord link. (tier 0 required)\n")
	sleep(1)

	mtext.mprint("\nclear (clears the screen.)\n")
	sleep(1)



	mtext.mprint("\ntimer (starts a timer for x seconds.)")
	mtext.mprint("Timer shown in both minutes and seconds (its a bit odd though)")
	
	sleep(3)
	mtext.mprint("\nNotes: no caps in commands.\n")
	mtext.mprint("Enter the command first, then add the arguments.")
	mtext.mprint("Such as:")
	sleep(2)
	mtext.mprint(">timer")
	mtext.mprint("Amount of time? in seconds.")
	mtext.mprint(">30")
	sleep(4)
end
--SETUP HELP API!!!