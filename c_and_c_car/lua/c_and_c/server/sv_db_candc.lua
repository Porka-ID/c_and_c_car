
local function DBInitialize() 

	sql.Query([[ CREATE TABLE if not exists 
			candc_car(
				id INTEGER, 
				steamid VARCHAR(32) NOT NULL, 
				color TEXT,
				PRIMARY KEY(id)
			)
		]])

end
hook.Add("InitPostEntity", "InitPostEntity::SetupDB", DBInitialize)


local function BuyVehicle()
	print("buyVehicle")
end 
c_and_c:Register(c_and_c.func_config.buyVehicle, BuyVehicle)