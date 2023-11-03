local function loadFonts()
    surface.CreateFont("VEHMAKER:Title", {
        font = "Montserrat Medium",
        size = ScreenScale(12),
        weight = ScreenScale(1),
        antialias = true,
    })
    
    surface.CreateFont("VEHMAKER:Text", {
        font = "Montserrat Medium",
        size = ScreenScale(10),
        weight = ScreenScale(1),
        antialias = true,
    })
    
    surface.CreateFont("VEHMAKER:Code", {
        font = "Montserrat Medium",
        size = ScreenScale(6.5),
        weight = ScreenScale(1),
        antialias = true,
    })
end

loadFonts()

hook.Add("OnScreenSizeChanged", "VEHMAKER:ReloadFonts", loadFonts)