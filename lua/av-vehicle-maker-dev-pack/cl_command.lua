hook.Add("OnPlayerChat", "AVVEHMAKERDEV:OpenPnl", function(ply, text)
    if ply != LocalPlayer() then return end
    if text != "!addvehicle" then return end

    AVVehMaker:OpenConfig()
    
    return true
end )