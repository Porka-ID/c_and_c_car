if CLIENT then return end 
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self:SetModel( "models/props_borealis/bluebarrel001.mdl" )
	self:SetSolid( SOLID_BBOX )
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetMaxYawSpeed( 90 )

end 

function ENT:OnTakeDamage()
	return false
end 

function ENT:Use(ply)
	if not IsValid(ply) then return end 

	if ply:IsPlayer() and self:GetPos():DistToSqr(ply:GetPos()) < 12000 then 
		c_and_c:SendNet(c_and_c.func_config.MainMenu, _, ply)
	end 
end 