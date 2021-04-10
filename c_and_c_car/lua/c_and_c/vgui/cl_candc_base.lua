local x, y = ScrW(), ScrH()

c_and_c:CreateFont('Title', ScreenScale(8))

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
	self.header.closeBtn:SetFont('Title')
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
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.colorPrimary)
	end

	self.header.title = self.header:Add('DLabel')
	self.header.title:SetText(c_and_c.Theme.base.titleHeader)
	self.header.title:SetFont('Title')
	self.header.title:Dock(TOP)
	self.header.title:DockMargin(15, 0, 0, 0)
end

vgui.Register('CANDC.Base', PANEL, "EditablePanel")