ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Concessionnaire"
ENT.Author = "Nox"
ENT.Category = "C and C"
ENT.Contact = "N/A"
ENT.Purpose = "N/A"
ENT.Instructions = "Appuyez sur E (touche utilisez)"
ENT.Spawnable = true 
ENT.AdminSpawnable = true 
ENT.AutomaticFrameAdvance = true 

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim
end 
