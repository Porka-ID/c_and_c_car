
local function InterfaceConcess()
	c_and_c:SendNet(c_and_c.func_config.buyVehicle) -- envoie d'un net côté sv ( tu peux le retirer c'était simplement pour faire un exemple) la var est dans le loader
end 

print('Test de git')

c_and_c:Register(c_and_c.func_config.MainMenu, InterfaceConcess)