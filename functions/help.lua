function help()
	mprint("license")
	mprint("prints the latest license straight from the hub")
	sleep(2)
	mprint("\nhelp (tier 0 required)")
	sleep(1)

	mprint("chat (tier 1 required)")
	mprint("chat. Requires a modem of some kind.")
	if perp==true then
		mprint("This may or may not work with lan cables...")
	end
	mprint("Anyone else that wants to join they must have the host name.")
	--mprint("I usually use 'Internet', which is why I call it internet.")
	sleep(3)

	mprint("\nrun (tier 1 required)")
	mprint("Notice: you must type 'run' first to start the command.")
	sleep(4)

	mprint("")
	mprint("exit (reboots computer; tier 0 required)")
	mprint("If you are tier 2+, then it will simply exit the program.")
	sleep(4)

	mprint("")
	mprint("reboot (tier 0 required)")
	mprint("Reboots the computer. Purpose is being a reboot command for tier 2+")
	sleep(4)
        
	mprint("\ndiscord (gives you a discord link. (tier 0 required)\n")
	sleep(1)

	mprint("\nclear (clears the screen. tier 0 required\n")
	sleep(1)

	mprint("\nlog (log of my edits. generalized. (tier 0 required)\n")
	sleep(1)

	mprint("\ntimer (starts a timer for x seconds.)")
	mprint("Timer shown in both minutes and seconds (its a bit odd though)")
	
	sleep(3)
	mprint("\nNotes: no caps in commands.\n")
	mprint("Enter the command first, then add the arguments.")
	mprint("Such as:")
	sleep(2)
	mprint(">timer")
	mprint("Amount of time? in seconds.")
	mprint(">30")
	sleep(4)
end
