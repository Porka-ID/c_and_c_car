local x, y = ScrW(), ScrH()
local PANEL = {}

function PANEL:Init()
	self.header = self:Add('Panel')
	self.header:Dock(TOP)
	self.header.Paint = function(pnl, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, c_and_c.Theme.base.header, true, true, false, false)
	end

	self.header.closeBtn = self.header:Add('DButton')
	self.header.closeBtn:Dock(RIGHT)
	self.header.closeBtn:SetText('X')
	self.header.closeBtn:SetTextColor(c_and_c.Theme.base.colorText)
	self.header.closeBtn.DoClick = function(pnl)
		self:Remove()
	end
	self.header.closeBtn.Paint = function(pnl, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, c_and_c.Theme.base.header, false, true, false, false)
	end

	self.affiche = self:Add('Panel')
	self.affiche:Dock(FILL)
	self.affiche.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.colorText)
	end
end

vgui.Register('CANDC.Frame', PANEL, "EditablePanel")

local function InterfaceConcess()
	RunConsoleCommand('candcframe')
end 

print('Test de git')

c_and_c:Register(c_and_c.func_config.MainMenu, InterfaceConcess)