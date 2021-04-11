
local configPanel = c_and_c.PANEL 

local col_green = Color(0,200,0)
local CAMIPanel = CAMIPanel or {}


local function OutlinedBox( x, y, w, h, thickness, clr )

    surface.SetDrawColor( clr )

    for i=0, thickness - 1 do

        surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )

    end

end 


local config_func = {
	["Permissions"] = function(group, _)
		if not LocalPlayer():GetUserGroup() == "superadmin" then return end 
		configPanel.panel:Clear() 
		configPanel.bottom:Clear()

		local m = vgui.Create("DScrollPanel", configPanel.panel)
			m:Dock(FILL)
			m:GetVBar():SetWide(0)

		for k,v in pairs(CAMI.GetUsergroups() or {}) do	
			if k ~= "superadmin" then 	 
				 p = vgui.Create("DButton", m)
				 p:SetWide(configPanel.panel:GetWide()*0.25)
				 p:SetTall(configPanel.panel:GetTall()*0.33)
				 p:Dock(TOP)
				 p:SetText( string.upper(k) ) 
				 p:SetTextColor(color_black)
				 p.DoClick = function(s)
					m.size = p:GetTall()
					if s.anim then 
						s.anim = false 
					else 
						s.anim = true 
					end
				 	m.lerp = true 
				 	m.lerpcur = FrameTime()
				 	if m.child then 
				 		m.anim = true
				 		m.check = m.child 
				 		m.time = m.childcur 
				    end 

				 	if m.child == k then 
				 		m.anim = false 
				 	end 	

				 		m.child = k
				 		m.childcur = FrameTime() 
				 end
				 p.Paint = function(s,w,h)
				 	OutlinedBox( 0,0, w, h, 1, color_black )
				 	if m.anim and m.check == k then 
				 		s.anim = false 
				 		s:SetTall(Lerp(FrameTime()*3, s:GetTall(), m.size))
				 		if m.time*3 <= FrameTime() then 
				 			m.anim = nil  
				 			m.check = nil   
				 			m.time = nil 
				 		end 
				 	end 
				 	if m.lerp then 
				 		if s.anim then 
				 			s:SetTall(Lerp(FrameTime()*3, s:GetTall(), m.size*2))
				 		else 
				 			s:SetTall(Lerp(FrameTime()*3, s:GetTall(), m.size))
				 		end 
				 		if m.lerpcur*3 <= FrameTime() then 
				 			m.lerp = false 
				 		end 
				 	end 
			     end 
			end 
		end 
	end, 
	["Vehicles"] = function( _, veh)

		local veh_tbl = table.Copy(list.Get("Vehicles") )
		for k,v in ipairs(veh) do 
			if veh_tbl[v.class] then 
				veh_tbl[v.class] = nil 
			end 	
		end 
		configPanel.panel:Clear()
		configPanel.bottom:Clear()
		local m = vgui.Create("DScrollPanel", configPanel.panel)
			m:Dock(FILL)
			m:GetVBar():SetWide(0)
		local icon = vgui.Create("DIconLayout", m)
			icon:Dock(FILL)

		for k,v in pairs( veh_tbl ) do
			 
				local p = vgui.Create("DButton", icon)
					p:SetWide(configPanel.panel:GetWide()*0.25)
					p:SetTall(configPanel.panel:GetTall()*0.33)
					p:SetText("")
					p.Paint = function() return  end 
					p.DoClick = function()
						if configPanel.frame.size then c_and_c:SetParameter(k, veh) return end 
						    configPanel.frame.size = configPanel.frame:GetWide()
						   configPanel.frame:SizeTo( configPanel.frame.size+configPanel.frame:GetWide()*0.25, -1, 2, 0.5, -1, function()
							c_and_c:SetParameter(k,  veh) 
						end)
						-- veh[#veh+1] = k 
					end

				local model = vgui.Create("DModelPanel", p)
					model:SetModel(list.Get("Vehicles")[k].Model)
					model:SetWide(p:GetWide())
					model:SetTall(p:GetTall())
				    local mn, mx = model.Entity:GetRenderBounds()
				    local size = 0
				    size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
				    size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
				    size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
				    model:SetFOV( 45 )
				    model:SetCamPos( Vector( size, size, size - 64 ) )
				    model:SetLookAt( (mn + mx) * 0.5 )
				    model.Angle = Angle( 0, 0, 0 )
				    model:SetMouseInputEnabled(false)
				    function model:LayoutEntity( ent )
				        if input.IsMouseDown( MOUSE_LEFT ) then
				            local mx = gui.MouseX()
				            self.Angle = self.Angle - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )

				            self.PressX = gui.MousePos()
				        end

				        return ent:SetAngles( self.Angle )
				    end
			 
		end 


		c_and_c:ChangeIndex(veh, index)
		 
	end
}

function c_and_c:ChangeIndex( veh, index)

	configPanel.bottom:Clear()
	configPanel.panel.index = index 

	if not veh then return end 
	for i = (index or 1), #veh do 
		local b_p = vgui.Create("DButton", configPanel.bottom)
			b_p:SetWide(configPanel.bottom:GetWide()*0.25) 
			b_p:SetTall(configPanel.bottom:GetTall())
			b_p:Dock(LEFT)
			b_p:SetText("")
			b_p:SetTextColor(color_white)
			b_p.Paint = nil 
			b_p.DoClick = function()
				table.remove(veh, i)
				config_func["Vehicles"]( _, veh)
				c_and_c:ChangeIndex( veh, index)
			end
			local model = vgui.Create("DModelPanel", b_p)
				model:SetModel(list.Get("Vehicles")[veh[i].class].Model)
				model:SetWide(b_p:GetWide())
				model:SetTall(b_p:GetTall())
			    local mn, mx = model.Entity:GetRenderBounds()
			    local size = 0
			    size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
			    size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
			    size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
			    model:SetFOV( 45 )
			    model:SetCamPos( Vector( size, size, size - 64 ) )
			    model:SetLookAt( (mn + mx) * 0.5 )
			    model.Angle = Angle( 0, 0, 0 )
			    model:SetMouseInputEnabled(false)
			    function model:LayoutEntity( ent )
			        if input.IsMouseDown( MOUSE_LEFT ) then
			            local mx = gui.MouseX()
			            self.Angle = self.Angle - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 )

			            self.PressX = gui.MousePos()
			        end

			        return ent:SetAngles( self.Angle )
			    end
	end 

	local preview = vgui.Create("DButton", configPanel.bottom)
		preview:SetWide(configPanel.bottom:GetWide()*0.05)
		preview:SetTall(configPanel.bottom:GetTall()*0.15)
		preview:SetPos(configPanel.bottom:GetWide()*0.48, configPanel.bottom:GetTall()*0.85)
		preview:SetText("< "..(index or 1) ) 
		preview:SetTextColor(color_white)
		preview.Paint = function() return end  
		preview.DoClick = function()
			local m = (index or 1) 
			if m-4 >= 1 then m = m - 4 else return end 
			c_and_c:ChangeIndex(veh, m)
		end

	local next_btn = vgui.Create("DButton", configPanel.bottom)
			next_btn:SetWide(configPanel.bottom:GetWide()*0.05)
			next_btn:SetTall(configPanel.bottom:GetTall()*0.15)
			next_btn:SetPos(configPanel.bottom:GetWide()*0.505, configPanel.bottom:GetTall()*0.85)
			next_btn:SetText(" >")
			next_btn:SetTextColor(color_white)
			next_btn.Paint = function() return end 
			next_btn.DoClick = function()
				local m = (index or 1)  
				if m+4 <= #veh then m = m+4 else return end 
				c_and_c:ChangeIndex( veh, m)
			end

end 

function c_and_c:SetParameter(veh_class, veh)

	local param_panel = vgui.Create("DPanel",configPanel.frame)
		param_panel:SetWide(configPanel.frame:GetWide()*0.25)
		param_panel:SetTall(configPanel.frame:GetTall() )
		param_panel:SetPos(configPanel.panel:GetWide()+configPanel.scroll:GetWide(),configPanel.frame:GetTall()*0.06 )
		param_panel.Paint = function() return end 


	local name = vgui.Create("DTextEntry", param_panel)	
		name:SetWide(param_panel:GetWide()*0.75)
		name:SetTall(param_panel:GetTall()*0.1)
		name:SetPos(param_panel:GetWide()*0.025, param_panel:GetTall()*0.1)
		name:SetDrawLanguageID(false)
		name:SetPlaceholderText("Nom du véhicule")

	local price = vgui.Create("DTextEntry", param_panel)
		price:SetNumeric(true)
		price:SetWide(param_panel:GetWide()*0.75)
		price:SetTall(param_panel:GetTall()*0.1)
		price:SetPos(param_panel:GetWide()*0.025, param_panel:GetTall()*0.25)
		price:SetPlaceholderText("Prix du vehicule")
		price:SetDrawLanguageID(false)

	local save = vgui.Create("DButton", param_panel)
		save:SetWide(param_panel:GetWide()*0.75)
		save:SetTall(param_panel:GetTall()*0.1)
		save:SetPos(param_panel:GetWide()*0.025, param_panel:GetTall()*0.825)
		save:SetText("Sauvegarder")
		save:SetTextColor(color_white)
		save.DoClick = function()
			if  price:GetValue() == "" or string.StartWith(price:GetValue(), " ") then return end 
			if  name:GetValue()  == "" or string.StartWith(name:GetValue(), " ")  then return end 
			veh[#veh+1] = {
				name  = name:GetValue(), 
				price = tonumber(price:GetValue()), 
				class = veh_class 
			}
			config_func["Vehicles"](_,veh)
			configPanel.frame:SizeTo(configPanel.frame.size, -1, 1.5, 0, -1, function()
				param_panel:Remove()
				configPanel.frame.size = nil 
			    c_and_c:ChangeIndex(veh, configPanel.panel.index)
			end)
		end
		save.Paint = function(s,w,h)
			draw.RoundedBox(4,0,0,w,h, col_green)
		end

end 

local function configuration_veh(len, ply)
	local t     = c_and_c:ReadTable()
	local group = c_and_c:ReadTable()

	if not group[LocalPlayer():GetUserGroup()] then return end 
	
	configPanel.frame = vgui.Create("CANDC.Base")
		configPanel.frame:SetSize(ScrW()*.5, ScrH()*.5)
		configPanel.frame:Center()
		configPanel.frame:MakePopup()

	configPanel.scroll = vgui.Create("DPanel",configPanel.frame)
		configPanel.scroll:Dock(LEFT)
		configPanel.scroll:SetWide(configPanel.scroll:GetWide()*3) 
		configPanel.scroll.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h, c_and_c.Theme.base.header)
		end

	 configPanel.panel = vgui.Create("DPanel",configPanel.frame)
		configPanel.panel:SetWide(configPanel.frame:GetWide()-configPanel.scroll:GetWide())
		configPanel.panel:SetTall(configPanel.frame:GetTall()-configPanel.frame:GetTall()*0.4 ) 
		configPanel.panel:SetPos(configPanel.scroll:GetWide(), configPanel.scroll:GetTall())
		configPanel.panel.Paint = function(s,w,h) 
			OutlinedBox( 0,0, w, h, 1, color_black )
	    end 

	 configPanel.bottom = vgui.Create("DPanel",configPanel.frame)
		configPanel.bottom:SetWide(configPanel.frame:GetWide()-configPanel.scroll:GetWide())
		configPanel.bottom:SetTall(configPanel.frame:GetTall()*0.35)
		configPanel.bottom:SetPos(configPanel.scroll:GetWide(), configPanel.panel:GetTall()+configPanel.scroll:GetTall())
		configPanel.bottom.Paint = function() end 


	local save = vgui.Create("DButton", configPanel.scroll)
		save:Dock(BOTTOM)
		save:SetTall(configPanel.frame:GetTall()*0.1)
		save:SetText("Sauvegarder")
		save:SetTextColor(color_white)
		save.Paint = function(s,w,h)
			draw.RoundedBox(4,0,0,w,h, col_green)
		end
		save.DoClick = function()
			c_and_c:SendNet(c_and_c.func_config.SaveVehiculesGroup, function()
					c_and_c:WriteTable(t)
					c_and_c:WriteTable(group)
			end)
		end

	for k,v in pairs(config_func) do 
		local p = vgui.Create("DButton", configPanel.scroll)
				p:Dock(TOP)
				p:SetTall(configPanel.frame:GetTall()*0.2)
				--p:DockMargin(0,0,0, 2.5)
				p:SetText(k)
				p:SetTextColor(color_white)
				p.Paint = function(s,w,h)
					draw.RoundedBox(0,0,0,w,h, c_and_c.Theme.base.header)
				end
				p.DoClick = function()
					if configPanel.frame.size then 
						configPanel.frame.size = nil 
						configPanel.frame:SizeTo(configPanel.frame.size, -1, 3, 0, -1, function()
							if not IsValid(param_panel) then return end 
							param_panel:Remove()
						end)
					end 
					config_func[k](group, t)
				end
	end 
end
c_and_c:Register(c_and_c.func_config.ConfigurationMenu, configuration_veh)