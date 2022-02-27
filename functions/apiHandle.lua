
function apiHandler(args[..])
	os.loadAPI(".system/notes")
	local fileList = {"mtext","help","https","blue"}
	

	if not args[]
		loadAPI()
	elseif #args == 1 then 
		print("sigh.")
	end
end