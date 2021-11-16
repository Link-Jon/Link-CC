
function apiHandler(args[..])
	os.loadAPI(".system/notes")
	local fileList = {"mtext","help","https","blue"}
	

	if not args[]
		loadAPI()
	elseif args.getn() == 1 then --WARNING, need to find a better wayto find array length. function depreciated and doesnt exist in many places.
		print("sigh.")
	end
end