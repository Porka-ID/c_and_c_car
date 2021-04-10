
local function DBInitialize() 
	sql.Query([[ CREATE TABLE if not exists 
			candc_car(
				id INTEGER PRIMARY KEY AUTOINCREMENT,  
				steamid VARCHAR(32) NOT NULL, 
				color TEXT,
				class TEXT,
				insurance TEXT
			)
		]])

	file.CreateDir("candc") 

	if file.Exists("candc/vehicules.json", "DATA") then 
		c_and_c.dataVeh = util.JSONToTable( file.Read("candc/vehicules.json", "DATA") )
	end 

	if file.Exists("candc/group.json", "DATA") then 
		c_and_c.group = util.JSONToTable(file.Read("candc/group.json", "DATA") ) 
	else 
		local t = {
			["superadmin"] = true 
		}
		file.Write("candc/group.json", util.TableToJSON(t) ) 
		c_and_c.group = t 
	end 
end
hook.Add("InitPostEntity", "InitPostEntity::SetupDB", DBInitialize)

local function BuyVehicle(len, ply)
	local class = net.ReadString()

	sql.Query(string.format("INSERT INTO candc_car(steamid, color, class, insurance) VALUES(%s, 'white', %s, 'false')", SQLStr(ply:SteamID64()), SQLStr(class) ) )
end 
c_and_c:Register(c_and_c.func_config.buyVehicle, BuyVehicle)

local function InsuranceVehicle(len, ply)

		 local id = net.ReadUInt(8)
		-- if not ply:canAfford(c_and_c.func_config.price_insurance) then return end 
		-- ply:addMoney(-c_and_c.func_config.price_insurance)
	sql.Query(string.format("UPDATE candc_car SET insurance = 'true' WHERE id = %s AND steamid = %s",  SQLStr( id ), SQLStr( ply:SteamID64() ) ) )

end 
c_and_c:Register(c_and_c.func_config.InsuranceVehicle, InsuranceVehicle)

local function RemoveVehicle(len, ply)

	local id = net.ReadUInt(8)


	sql.Query(string.format("DELETE FROM candc_car WHERE id = %s AND steamid = %s", SQLStr(id), SQLStr( ply:SteamID64() ) ) )
end 
c_and_c:Register(c_and_c.func_config.RemoveVehicle, RemoveVehicle)