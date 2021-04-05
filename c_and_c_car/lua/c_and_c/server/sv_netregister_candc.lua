--[[

	ENREGISTREMENT DES NETS

]]

util.AddNetworkString("CandC::SendingNet::NetworKing")

hook.Add("PlayerSay", "PlayerSay::SendNet", function(ply, text)

	if not IsValid(ply) then return end

	if string.upper(text) == "/NET" then 
		 c_and_c:SendNet(c_and_c.func_config.MainMenu, function()
		 		net.WriteString("try?")
		 end, ply)
	end  

end)