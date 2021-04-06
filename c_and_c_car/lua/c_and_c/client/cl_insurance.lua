
local col_green = Color(0,150,0)
local col_red   = Color(150,0,0)
local id 

local function OutlinedBox( x, y, w, h, thickness, clr )

    surface.SetDrawColor( clr )

    for i=0, thickness - 1 do

        surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )

    end

end 

local function PreviewVeh(frame, panel, accept, class, i)
	accept:SetText("Assurance : " ..i)
	panel:Clear()

	local model = vgui.Create("DModelPanel", panel)
	model:SetModel(list.Get("Vehicles")[class].Model)
	model:SetWide(panel:GetWide())
	model:SetTall(panel:GetTall())
	print(model:GetModel())
    local mn, mx = model.Entity:GetRenderBounds()
    local size = 0
    size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
    size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
    size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
    model:SetFOV( 45 )
    model:SetCamPos( Vector( size, size, size - 64 ) )
    model:SetLookAt( (mn + mx) * 0.5 )
    model.Angle = Angle( 0, 0, 0 )
    function model:LayoutEntity( ent )
        if input.IsMouseDown( MOUSE_LEFT ) then
            local mx = gui.MouseX()
            self.Angle = self.Angle - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )

            self.PressX = gui.MousePos()
        end

        return ent:SetAngles( self.Angle )
    end
end 

local function InsuranceOpen()

	local t = c_and_c:ReadTable()

	local frame = vgui.Create("CANDC.Frame")
		frame:SetSize(ScrW()*.5, ScrH()*.5)
		frame:Center()
		frame:MakePopup()

	local scroll = vgui.Create("DScrollPanel", frame)
		scroll:Dock(LEFT)
		scroll:SetWide(scroll:GetWide()*3) 
		scroll:GetVBar():SetWide(0)
		scroll.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h, c_and_c.Theme.base.header)
		end

	local panel = vgui.Create("DPanel", frame)
		panel:SetWide(frame:GetWide()-scroll:GetWide())
		panel:SetTall(frame:GetTall()-85 ) 
		panel:SetPos(scroll:GetWide(), scroll:GetTall())
		panel.Paint = function(s,w,h) 
			OutlinedBox( 0,0, w, h, 1, color_black )
	    end 

	local accept = vgui.Create("DButton", frame)
		accept:SetText("Assurance : "..(t[1].insurance or "Aucun véhicule") ) 
		accept:SetTextColor(color_white)	 
		accept:SetWide(frame:GetWide()*0.25)
		accept:SetTall(frame:GetTall() * 0.1)
		accept:SetPos(panel:GetWide()*0.5, panel:GetTall()*1.12)
		accept.DoClick = function(s)
			if not LocalPlayer():canAfford(c_and_c.func_config.price_insurance) then return end 
			if not isnumber(id) then print("yes?") end 
			s:SetText("Assurance : "..t[1].insurance)
			c_and_c:SendNet(c_and_c.func_config.InsuranceVehicle, function()
				net.WriteUInt(id, 8)
			end)
		end 
		accept.Paint = function(s,w,h)
			draw.RoundedBox(8,0,0,w,h, col_green)
		end

	local decline = vgui.Create("DButton", frame)
		decline:SetText("Annuler")
		decline:SetTextColor(color_white)
		decline:SetWide(frame:GetWide()*0.25)
		decline:SetTall(frame:GetTall()*0.1)
		decline:SetPos(panel:GetWide()*0.925, panel:GetTall()*1.12)
		decline.Paint = function(s,w,h)
			draw.RoundedBox(8,0,0,w,h, col_red)
		end
		decline.DoClick = function()
			frame:Remove()
		end

	if not istable(t) then return end 	
	PreviewVeh(frame, panel, accept, t[1].class, t[1].insurance)

	for k,v in pairs(t) do 
		local p = vgui.Create("DButton", scroll)
			p:Dock(TOP)
			p:SetTall(frame:GetTall()*0.2)
			--p:DockMargin(0,0,0, 2.5)
			p:SetText(v.class)
			p:SetTextColor(color_white)
			p.Paint = function(s,w,h)
				draw.RoundedBox(0,0,0,w,h, c_and_c.Theme.base.header)
				OutlinedBox( 0, 0, w, h, 1, c_and_c.Theme.base.colorPrimary )
			end
			p.DoClick = function()
				id = tonumber(v.id) 
				PreviewVeh(frame, panel, accept, v.class, v.insurance)	
			end
	end 
end 
c_and_c:Register( c_and_c.func_config.Insurance,InsuranceOpen)