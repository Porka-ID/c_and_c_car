
local function InsuranceOpen()

	local t = c_and_c:ReadTable()

	local frame = vgui.Create("CANDC.Frame")
		frame:SetSize(ScrW()*.5, ScrH()*.5)
		frame:Center()
		frame:MakePopup()

	for k,v in pairs(t or {}) do 

	end  

end 
c_and_c:Register( c_and_c.func_config.Insurance,InsuranceOpen)