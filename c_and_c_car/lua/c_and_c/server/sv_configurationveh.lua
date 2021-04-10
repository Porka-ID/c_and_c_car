hook.Add("PlayerSay", "PlayerSay::SendMenuConfiguration", function(ply, text)
	if c_and_c.group[ply:GetUserGroup()] and string.upper(text) == "!CANDC" then
		if file.Exists("candc/vehicules.json", "DATA") then 
			c_and_c.dataVeh = util.JSONToTable(file.Read("candc/vehicules.json", "DATA"))
		end 
		c_and_c:SendNet(c_and_c.func_config.ConfigurationMenu, function()
			c_and_c:WriteTable(c_and_c.dataVeh or {})
			c_and_c:WriteTable(c_and_c.group)
		end, ply)
	end 
end)

local function SaveVeh(len, ply)

	if not c_and_c.group[ply:GetUserGroup()] then return end 

	local t = c_and_c:ReadTable()
	local group = c_and_c:ReadTable()

	if file.Exists("candc/group.json", "DATA") and ply:GetUserGroup() == "superadmin" then 
		c_and_c.group = group 
		file.Write("candc/group.json", util.TableToJSON(group) )
	end 
		c_and_c.dataVeh = t  	
		file.Write("candc/vehicules.json", util.TableToJSON(t))

end 
c_and_c:Register(c_and_c.func_config.SaveVehiculesGroup, SaveVeh)