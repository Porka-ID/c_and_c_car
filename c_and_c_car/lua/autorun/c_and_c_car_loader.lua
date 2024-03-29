c_and_c = c_and_c or {}

c_and_c.func_config = c_and_c.func_config or {}
c_and_c.PANEL = c_and_c.PANEL or {}
c_and_c.func_config.price_insurance = 2000

--[[ ID FUNCTION NET ]]
c_and_c.func_config.MainMenu           = 1 
c_and_c.func_config.buyVehicle         = 2 
c_and_c.func_config.Insurance          = 3
c_and_c.func_config.InsuranceVehicle   = 4 
c_and_c.func_config.ConfigurationMenu  = 5
c_and_c.func_config.SaveVehiculesGroup = 6
c_and_c.func_config.RemoveVehicle      = 7 

print("FICHIER C_AND_C_LOADER.LUA")

local function loadFolder( path )

    local files, folders = file.Find( path .. "*", "LUA" )

    for k, v in pairs( files ) do
        if string.find( v, "networking" ) then continue end
        if SERVER then
            if string.find( v, "cl_") or string.find(v, "sh_" ) then
                AddCSLuaFile( path .. v )
                print( "[SERVER] Enregistrement de : " .. path .. v)
            end

            if string.find( v, "sv_" ) or string.find( v, "sh_" ) then
                include( path .. v )
                print( " [SERVER - CLIENT] Enregistrement de : " .. path .. v)
            end
        else
            include( path .. v )
            print( "[CLIENT] Enregistrement de : " .. path .. v )
        end
    end

end

local function loadNetworking()
    AddCSLuaFile( "c_and_c/shared/sh_sendnetworking.lua" )
    include( "c_and_c/shared/sh_sendnetworking.lua" )

    if SERVER then
        AddCSLuaFile( "c_and_c/client/cl_networking_candc.lua" )
        include( "c_and_c/server/sv_netregister_candc.lua" )
    else
        include( "c_and_c/client/cl_networking_candc.lua" )
    end
end

loadNetworking()

loadFolder("c_and_c/config/")
loadFolder("c_and_c/misc/")
loadFolder("c_and_c/vgui/")
loadFolder("c_and_c/client/")
loadFolder("c_and_c/server/")
loadFolder("c_and_c/shared/")
loadFolder("c_and_c/tests/")
