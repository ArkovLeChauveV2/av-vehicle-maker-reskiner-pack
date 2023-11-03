local color_main = Color(35, 25, 130)
local color_area = Color(60, 50, 160)
local color_button = Color(65, 0, 255)
local color_hover = Color(91, 38, 250)
local color_sectext = Color(177, 177, 177)
local color_text = color_white


local function figmaToResp(x, y) // if you use that function on your addon, change 1920 and 1080 to your screen resolution
    return ScrW() / (1920 / x), ScrH() / (1080 / y)
end

local function figmaToRespY(y) // if you use that function on your addon, change 1080 to your screen resolution's height
    return ScrH() / (1080 / y)
end

local function makeMain(title, w, h)
    local main = vgui.Create("DFrame")
    main:SetSize(w, h)
    main:Center()
    main:SetTitle("")
    main:ShowCloseButton(false)
    main:SetDraggable(false)
    main:MakePopup()

    function main:Paint(w, h)
        draw.RoundedBox(27, 0, 0, w, h, color_main)
        draw.SimpleText(title, "VEHMAKER:Title", w / 2, 1, color_text, 1)
    end

    local closeX, closeY = figmaToResp(40, 35)

    local close = vgui.Create("DButton", main)
    close:SetSize(closeX, closeY)
    close:SetPos(w - closeX, 0)
    close:SetText("")
    
    function close:DoClick()
        main:Close()
    end

    function close:Paint(w, h)
        draw.SimpleText("x", "VEHMAKER:Title", w / 2, h / 2, color_text, 1, 1)
    end

    return main
end

local function drawError(error, w, h)
    local main = makeMain("Error", w, h)
    main.oldPaint = main.Paint

    surface.SetFont("VEHMAKER:Text")
    local separatedLines = string.Split(error, "\n")
    local _, lineTall = surface.GetTextSize(separatedLines[1])

    function main:Paint(w, h)
        self:oldPaint(w, h)
        draw.DrawText(error, "VEHMAKER:Text", w / 2, h / 2 - (#separatedLines * lineTall) / 2, color_sectext, 1, 0)
    end
end

local function drawField(pnl, desc, y)
    local base = vgui.Create("DTextEntry", pnl)
    base:SetSize(figmaToResp(280, 45))
    base:SetPos(pnl:GetWide() / 2 - base:GetWide() / 2, y)

    function base:Paint(w, h)
        draw.RoundedBox(27, 0, 0, w, h, color_area)
    end

    local text = vgui.Create("DTextEntry", base)
    text:SetFont("VEHMAKER:Text")
    text:SetTextColor(color_text)
    text:SetDrawLanguageID(false)
    text:SetSize(base:GetWide() - 10, base:GetTall() - 10)
    text:Center()

    function text:Paint(w, h)
        self:DrawTextEntryText(color_text, color_text, color_text)

        if self:HasFocus() || self:GetValue() != "" then return end
        draw.SimpleText(desc, "VEHMAKER:Text", w / 2, h / 2, color_sectext, 1, 1)
    end

    return text
end

local function codeoutput(author, vehName, category, class, vehskin, model, vehbaseclass, script, bodygroups)
    local main = makeMain("Configuration - code output", figmaToResp(520, 580))
    
    local base = vgui.Create("DPanel", main)
    base:SetSize(figmaToResp(450, 450))
    base:SetPos(main:GetWide() / 2 - base:GetWide() / 2, figmaToRespY(60))

    function base:Paint(w, h)
        draw.RoundedBox(27, 0, 0, w, h, color_area)
    end

    local bgs = ""
    
    for k, v in pairs(bodygroups) do
        bgs = bgs .. [[
        []] .. k .. [[] = ]] .. v .. [[,
        ]]
    end

    local code = vgui.Create("DTextEntry", base)
    code:SetSize(base:GetWide() - 10, base:GetTall() - 10)
    code:Center()
    code:SetMultiline(true)
    code:SetDrawLanguageID(false)
    code:SetFont("VEHMAKER:Code")
    code:SetTextColor(color_text)
    code:SetEditable(false)
    code:SetValue([[
// Add that in a shared file (explanations on the github)
// https://github.com/ArkovLeChauveV2/av-vehicle-maker

AVVehMaker:AddVehicle({
    class = "]] .. class .. [[",
    name = "]] .. vehName .. [[",
    model = "]] .. model .. [[",
    baseClass = "]] .. vehbaseclass .. [[",
    category = "]] .. category .. [[",
    author = "]] .. author .. [[",
    texture = "]] .. vehskin .. [[",
    keyvalues = {
            vehiclescript = "]] .. script .. [[",
    },
    bodygroups = {
        ]] .. bgs .. [[
}
})]])

    function code:Paint()
        self:DrawTextEntryText(color_text, color_text, color_text)
    end

    local button = vgui.Create("DButton", main)
    button:SetSize(figmaToResp(200, 35))
    button:SetPos(main:GetWide() / 2 - button:GetWide() / 2, main:GetTall() - button:GetTall() - figmaToRespY(15))
    button:SetText("")
    
    function button:Paint(w, h)
        draw.RoundedBox(27, 0, 0, w, h, self:IsHovered() && color_hover || color_button)
        draw.SimpleText("Copier", "VEHMAKER:Text", w / 2, h / 2 - 2, color_text, 1, 1)
    end

    function button:DoClick()
        SetClipboardText(code:GetValue())
        main:Remove()
    end
end

function AVVehMaker:OpenConfig()
    if !LocalPlayer():InVehicle() then return drawError("Enter in the vehicle\nyou wan't to reskin", figmaToResp(350, 175)) end
    local veh = LocalPlayer():GetVehicle()
    local model = veh:GetModel()
    local class = veh:GetClass()
    local texture = veh:GetMaterial()
    local bodygroups = {}

    for _, v in pairs(veh:GetBodyGroups()) do
        local bg = veh:GetBodygroup(v.id)
        if bg == 0 then continue end
        bodygroups[v.id] = bg
    end

    local script = "scripts/vehicles/jeep_test.txt"

    do
        local vehs = list.Get("Vehicles")
        local vehData = vehs[class]

        if vehData then
            script = vehData.KeyValues.vehiclescript
        end
    end

    local main = makeMain("Configuration - New vehicle", figmaToResp(520, 510))
    local authName = drawField(main, "Author's name", figmaToRespY(75))
    local vehName = drawField(main, "Vehicle's name", figmaToRespY(75) * 2)
    local vehCat = drawField(main, "Vehicle's category", figmaToRespY(75) * 3)
    local vehClass = drawField(main, "Vehicle's class", figmaToRespY(75) * 4)
    local vehSkin = drawField(main, "Vehicle's skin", figmaToRespY(75) * 5)

    local button = vgui.Create("DButton", main)
    button:SetSize(figmaToResp(200, 35))
    button:SetPos(main:GetWide() / 2 - button:GetWide() / 2, figmaToRespY(75) * 6)
    button:SetText("")
    
    function button:Paint(w, h)
        draw.RoundedBox(27, 0, 0, w, h, self:IsHovered() && color_hover || color_button)
        draw.SimpleText("Confirmer", "VEHMAKER:Text", w / 2, h / 2 - 2, color_text, 1, 1)
    end

    function button:DoClick()
        codeoutput(authName:GetValue(), vehName:GetValue(), vehCat:GetValue(), vehClass:GetValue(), vehSkin:GetValue(), model, class, script, bodygroups)
        main:Remove()
    end
end