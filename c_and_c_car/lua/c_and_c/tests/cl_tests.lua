c_and_c.Theme.frame = function()
    local frame = vgui.Create('CANDC.Frame')
	frame:SetSize(ScrW()*.8, ScrH()*.8)
	frame:Center()
	frame:MakePopup()
end

concommand.Add('candcframe', c_and_c.Theme.frame)