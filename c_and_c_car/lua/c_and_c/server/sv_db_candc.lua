
local function DBInitialize() 
	sql.Query([[ CREATE TABLE if not exists 
			candc_car(
				id INTEGER ,  
				steamid VARCHAR(32) NOT NULL, 
				color TEXT,
				class TEXT,
				insurance TEXT, 
				PRIMARY KEY(id)
		
			)
		]])

end
hook.Add("InitPostEntity", "InitPostEntity::SetupDB", DBInitialize)


local function BuyVehicle(len, ply)
	local class = net.ReadString()

	local r = sql.Query("SELECT * FROM candc_car ")
	local m 
	if istable(r) then m = #r+1 else m = 1 end 
	sql.Query(string.format("INSERT INTO candc_car( id, steamid, color, class, insurance) VALUES(%s, %s, 'white', %s, 'false')", SQLStr(m),SQLStr(ply:SteamID64()), SQLStr(class) ) )
end 
c_and_c:Register(c_and_c.func_config.buyVehicle, BuyVehicle)

local function InsuranceVehicle(len, ply)

		 local id = net.ReadUInt(8)
		-- if not ply:canAfford(c_and_c.func_config.price_insurance) then return end 
		-- ply:addMoney(-c_and_c.func_config.price_insurance)
	sql.Query(string.format("UPDATE candc_car SET insurance = 'true' WHERE id = %s AND steamid = %s",  SQLStr( id ), SQLStr( ply:SteamID64() ) ) )

end 
c_and_c:Register(c_and_c.func_config.InsuranceVehicle, InsuranceVehicle)