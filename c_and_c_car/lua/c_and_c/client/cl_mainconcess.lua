local x, y = ScrW(), ScrH()

c_and_c:CreateFont('Title', ScreenScale(8))
c_and_c:CreateFont('left-right', ScreenScale(25))

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
	self.affiche = self:Add('DPanel')
	self.affiche:Dock(FILL)
	self.affiche.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.colorPrimary)
		surface.SetDrawColor(c_and_c.Theme.base.header)
		surface.DrawRect(0, 0, x * 0.005, h)
	end

	self.affiche.btn_left = self.affiche:Add('DButton')
	self.affiche.btn_left:SetSize(x * .07, y * .12)
	self.affiche.btn_left:SetPos(x *.005, y * .23)
	self.affiche.btn_left:SetText('<')
	self.affiche.btn_left:SetTextColor(c_and_c.Theme.base.colorText)
	self.affiche.btn_left:SetFont("left-right")
	self.affiche.btn_left.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.colorPrimary)
	end

	self.affiche.btn_right = self.affiche:Add('DButton')
	self.affiche.btn_right:SetSize(x * .07, y * .12)
	self.affiche.btn_right:SetPos(x *.48, y * .23)
	self.affiche.btn_right:SetText('>')
	self.affiche.btn_right:SetTextColor(c_and_c.Theme.base.colorText)
	self.affiche.btn_right:SetFont("left-right")
	self.affiche.btn_right.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.colorPrimary)
	end

	self.header.title = self.header:Add('DLabel')
	self.header.title:SetText(c_and_c.Theme.base.titleHeader)
	self.header.title:SetFont('CandC.Title')
	self.header.title:Dock(TOP)
	self.header.title:DockMargin(15, 0, 0, 0)

	self.custom = self:Add('DPanel')
	self.custom:Dock(RIGHT)
	self.custom:SetWide(x * .25)
	self.custom.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.header)
		surface.SetDrawColor(c_and_c.Theme.base.colorPrimary)
		surface.DrawRect(0, 0, w, h * 0.002)
	end

	self.buy = self:Add('DPanel')
	self.buy:Dock(BOTTOM)
	self.buy:SetTall(y * .15)
	self.buy.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c_and_c.Theme.base.header)
		surface.SetDrawColor(c_and_c.Theme.base.colorPrimary)
		surface.DrawRect(w - x * 0.001 , 0, x * 0.002, h)
		surface.SetDrawColor(c_and_c.Theme.base.colorPrimary)
		surface.DrawRect(x * 0.005 , 0, x * 0.002, h)
	end

	PrintTable(c_and_c.func_config)

end

vgui.Register('CANDC.Frame', PANEL, "EditablePanel")

local function InterfaceConcess()
	RunConsoleCommand('candcframe')
end 

print('Test de git')

c_and_c:Register(c_and_c.func_config.MainMenu, InterfaceConcess)