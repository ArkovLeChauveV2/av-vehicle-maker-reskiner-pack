// don't search docs i didn't do them yet (i will not do them later)
    
if !AVVehMaker then return MsgC(Color(255, 0, 0), "[AV Veh Maker] You installed the developer pack but not the base addon, please install the base addon:\nhttps://github.com/ArkovLeChauveV2/av-vehicle-maker\n") end

if SERVER then
    AddCSLuaFile("av-vehicle-maker-dev-pack/cl_fonts.lua")
    AddCSLuaFile("av-vehicle-maker-dev-pack/cl_interface.lua")
    AddCSLuaFile("av-vehicle-maker-dev-pack/cl_command.lua")

    include("av-vehicle-maker-dev-pack/sv_resources.lua")
else
    include("av-vehicle-maker-dev-pack/cl_fonts.lua")
    include("av-vehicle-maker-dev-pack/cl_interface.lua")
    include("av-vehicle-maker-dev-pack/cl_command.lua")
end