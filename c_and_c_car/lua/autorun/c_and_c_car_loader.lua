c_and_c = c_and_c or {}

c_and_c.func_config = c_and_c.func_config or {}

c_and_c.func_config.MainMenu = 1 
c_and_c.func_config.buyVehicle = 2 

print("FICHIER C_AND_C_LOADER.LUA")

local function loadFolder( path )

    local files, folders = file.Find( path .. "*", "LUA" )

    for k, v in pairs( files ) do
        if string.find( v, "networking" ) then continue end
        if SERVER then
            if string.find( v, "cl_") or string.find(v, "sh_" ) then
                AddCSLuaFile( path .. v )
            end

            if string.find( v, "sv_" ) or string.find( v, "sh_" ) then
                include( path .. v )
            end
        else
            include( path .. v )
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

loadFolder("c_and_c/client/")
loadFolder("c_and_c/server/")
loadFolder("c_and_c/shared/")