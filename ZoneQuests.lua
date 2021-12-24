if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["ZoneQuests"] = 8
if AZP.ZoneQuests == nil then AZP.ZoneQuests = {} end
if AZP.ZoneQuests.Events == nil then AZP.ZoneQuests.Events = {} end

if AZPKQFrameLocation == nil then AZPKQFrameLocation = {"CENTER", 0, 0} end

local EventFrame, AZPKQSelfFrame = nil, nil

local QuestZoneSelectionFrame = nil
AZP.ZoneQuests.ZoneFrames = {}
AZP.ZoneQuests.ZoneIcons = {}

local QuestZones =
{
    ZerethMortis =
    {
        Name = "ZerethMortis",
        Index = 1,
        Active = "Soon",
        FileID = GetFileIDFromPath("Interface\\ENCOUNTERJOURNAL\\UI-EJ-BOSS-Tarragrue.blp"),
    },
    Korthia =
    {
        Name = "Korthia",
        Index = 2,
        Active = true,
        FileID = GetFileIDFromPath("Interface\\ENCOUNTERJOURNAL\\UI-EJ-BOSS- Eye of the Jailer.blp"),
    },
}

function AZP.ZoneQuests:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:SetScript("OnEvent", function(...) AZP.ZoneQuests:OnEvent(...) end)


    -- local testframe = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    -- testframe:SetSize(250, 250)
    -- testframe:SetPoint("CENTER", 0, 0)
    -- testframe:SetBackdrop({
    --     bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    --     edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    --     edgeSize = 12,
    --     insets = { left = 1, right = 1, top = 1, bottom = 1 },
    -- })
    -- testframe:SetBackdropColor(0.5, 0.5, 0.5, 1)

    -- testframe.BG1 = testframe:CreateTexture(nil, "ARTWORK")
    -- testframe.BG1:SetSize(50, 50)
    -- testframe.BG1:SetPoint("LEFT", 0, 0)
    -- testframe.BG1:SetColorTexture(1, 1, 1)
    -- testframe.BG1:SetGradient("HORIZONTAL", 1, 0, 0, 1, 1, 0)

    -- testframe.BG2 = testframe:CreateTexture(nil, "ARTWORK")
    -- testframe.BG2:SetSize(50, 50)
    -- testframe.BG2:SetPoint("LEFT", testframe.BG1, "RIGHT", 0, 0)
    -- testframe.BG2:SetColorTexture(1, 1, 1)
    -- testframe.BG2:SetGradient("HORIZONTAL", 1, 1, 0, 0, 1, 0)

    -- testframe.BG3 = testframe:CreateTexture(nil, "ARTWORK")
    -- testframe.BG3:SetSize(50, 50)
    -- testframe.BG3:SetPoint("LEFT", testframe.BG2, "RIGHT", 0, 0)
    -- testframe.BG3:SetColorTexture(1, 1, 1)
    -- testframe.BG3:SetGradient("HORIZONTAL", 0, 1, 0, 0, 1, 1)

    -- testframe.BG4 = testframe:CreateTexture(nil, "ARTWORK")
    -- testframe.BG4:SetSize(50, 50)
    -- testframe.BG4:SetPoint("LEFT", testframe.BG3, "RIGHT", 0, 0)
    -- testframe.BG4:SetColorTexture(1, 1, 1)
    -- testframe.BG4:SetGradient("HORIZONTAL", 0, 1, 1, 0, 0, 1)

    -- testframe.BG5 = testframe:CreateTexture(nil, "ARTWORK")
    -- testframe.BG5:SetSize(50, 50)
    -- testframe.BG5:SetPoint("LEFT", testframe.BG4, "RIGHT", 0, 0)
    -- testframe.BG5:SetColorTexture(1, 1, 1)
    -- testframe.BG5:SetGradient("HORIZONTAL", 0, 0, 1, 1, 0, 1)
end

function ColorGradient(perc, ...)
    if perc >= 1 then
        local r, g, b = select(select('#', ...) - 2, ...)
        return r, g, b
    elseif perc <= 0 then
        local r, g, b = ...
        return r, g, b
    end

    local num = select('#', ...) / 3

    local segment, relperc = math.modf(perc*(num-1))
    local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

function AZP.ZoneQuests:CreateSelectorFrame()
    QuestZoneSelectionFrame = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate")
    QuestZoneSelectionFrame:SetPoint("CENTER", 0, 0)
    QuestZoneSelectionFrame.Background = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    QuestZoneSelectionFrame.Background:SetPoint("CENTER", 0, 0)
    QuestZoneSelectionFrame.Background:SetTexture(GetFileIDFromPath("Interface\\ENCOUNTERJOURNAL\\UI-EJ-LOREBG-SanctumofDomination"))
    QuestZoneSelectionFrame.Background:SetTexCoord(0.03425, 0.72525, 0.0585, 0.60)
    QuestZoneSelectionFrame.Background:SetAlpha(0.8)
    QuestZoneSelectionFrame:SetBackdrop({
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 10,
        insets = {left = 3, right = 3, top = 3, bottom = 3},
    })

    QuestZoneSelectionFrame.Header = QuestZoneSelectionFrame:CreateFontString("AZPRTBossToolsFrame", "ARTWORK", "GameFontNormalHuge")
    QuestZoneSelectionFrame.Header:SetSize(QuestZoneSelectionFrame:GetWidth(), 25)
    QuestZoneSelectionFrame.Header:SetPoint("TOP", 0, -15)
    QuestZoneSelectionFrame.Header:SetText(string.format("AzerPUG's BossTools v%s", AZP.VersionControl["ZoneQuests"]))

    QuestZoneSelectionFrame.SubHeader = QuestZoneSelectionFrame:CreateFontString("AZPRTBossToolsFrame", "ARTWORK", "GameFontNormalLarge")
    QuestZoneSelectionFrame.SubHeader:SetSize(QuestZoneSelectionFrame:GetWidth(), 50)
    QuestZoneSelectionFrame.SubHeader:SetPoint("TOP", QuestZoneSelectionFrame.Header, "BOTTOM", 0, 5)
    QuestZoneSelectionFrame.SubHeader:SetText("Sanctum of Domination\nBoss Selector Frame")

    local BossWidth, BossHeight = 100, 75

    for Zone, Info in pairs(QuestZones) do
        if Info.Active ~= false then
            local curFrame = CreateFrame("FRAME", nil, QuestZoneSelectionFrame)
            curFrame:SetSize(BossWidth, BossHeight)
            curFrame:SetScript("OnMouseDown", function() if AZP.ZoneQuests.ZoneFrames[Zone] ~= nil then QuestZoneSelectionFrame:Hide() AZP.ZoneQuests.ZoneFrames[Zone]:Show() end end)
            curFrame.Button = curFrame:CreateTexture(nil, "ARTWORK")
            curFrame.Button:SetSize(curFrame:GetWidth(), 55)
            curFrame.Button:SetPoint("BOTTOM", 0, 0)
            curFrame.Button:SetTexture(Info.FileID)
            curFrame.Label = curFrame:CreateFontString("QuestZoneSelectionFrame", "ARTWORK", "GameFontNormalLarge")
            curFrame.Label:SetSize(curFrame:GetWidth() -20, 25)
            curFrame.Label:SetPoint("TOP", -10, -5)
            curFrame.Label:SetText(Info.Name)

            if Info.Active == "Soon" then
                curFrame.Button:SetDesaturated(true)
                curFrame.ComingSoon = curFrame:CreateFontString("QuestZoneSelectionFrame", "ARTWORK", "GameFontNormalLarge")
                curFrame.ComingSoon:SetSize(curFrame:GetWidth() -20, 50)
                curFrame.ComingSoon:SetPoint("TOP", -10, -25)
                curFrame.ComingSoon:SetText("Coming\nSoon!")
            end

            curFrame.Index = Info.Index
            AZP.ZoneQuests.ZoneIcons[#AZP.ZoneQuests.ZoneIcons + 1] = curFrame
        end
    end

    --local iconsPerRow = {math.floor(#AZP.ZoneQuests.ZoneIcons / 2), math.ceil(#AZP.ZoneQuests.ZoneIcons / 2)}
    local iconsPerRow = {2, 2}
    local FrameWidth = (iconsPerRow[2] * 85 + 25)
    if FrameWidth < 280 then FrameWidth = 280 end
    QuestZoneSelectionFrame:SetSize(FrameWidth, FrameWidth - 15)
    QuestZoneSelectionFrame.Background:SetSize(QuestZoneSelectionFrame:GetWidth() - 5, QuestZoneSelectionFrame:GetHeight() - 5)

    table.sort(AZP.ZoneQuests.ZoneIcons, function(a,b) return a.Index < b.Index end)

    if #AZP.ZoneQuests.ZoneIcons == 0 then return
    elseif #AZP.ZoneQuests.ZoneIcons > 0 then
        for i = 1, #AZP.ZoneQuests.ZoneIcons do
            local BottomOffset = {[1] = 0, [2] = 8, [3] =  9, [4] = 10, [5] = 13,}
            local   LeftOffset = {[1] = 0, [2] = 35, [3] = 22, [4] = 17, [5] = 11,}
            if i == 1 then AZP.ZoneQuests.ZoneIcons[i]:SetPoint("BOTTOM", (-35 * iconsPerRow[1]) + LeftOffset[iconsPerRow[1]], 100)
            elseif i == (iconsPerRow[1] + 1) then AZP.ZoneQuests.ZoneIcons[i]:SetPoint("BOTTOM", (-35 * iconsPerRow[2]) + LeftOffset[iconsPerRow[2]], BottomOffset[iconsPerRow[2]])
            else AZP.ZoneQuests.ZoneIcons[i]:SetPoint("LEFT", AZP.ZoneQuests.ZoneIcons[i-1], "RIGHT", -10, 0) end
        end
    end

    QuestZoneSelectionFrame.closeButton = CreateFrame("Button", nil, QuestZoneSelectionFrame, "UIPanelCloseButton")
    QuestZoneSelectionFrame.closeButton:SetSize(20, 21)
    QuestZoneSelectionFrame.closeButton:SetPoint("TOPRIGHT", QuestZoneSelectionFrame, "TOPRIGHT", 1, 2)
    QuestZoneSelectionFrame.closeButton:SetScript("OnClick", function() QuestZoneSelectionFrame:Hide() end)

    --QuestZoneSelectionFrame:Hide()
end

function AZP.ZoneQuests:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.ZoneQuests.Events:VariablesLoaded()
    end
end

function AZP.ZoneQuests.Events:VariablesLoaded()
    C_Timer.NewTimer(5, function() AZP.ZoneQuests:CreateSelectorFrame()  end)
end

function AZP.ZoneQuests:ShowHideFrame()
    -- if QuestZoneSelectionFrame:IsShown() then
    --     QuestZoneSelectionFrame:Hide()
    --     --AZPCoreShown = false
    -- elseif not QuestZoneSelectionFrame:IsShown() then
    --     QuestZoneSelectionFrame:Show()
    --     --AZPCoreShown = true
    -- end
end

AZP.ZoneQuests:OnLoadSelf()

AZP.SlashCommands["ZQ"] = function()
    QuestZoneSelectionFrame:Show()
end

AZP.SlashCommands["zq"] = AZP.SlashCommands["ZQ"]
AZP.SlashCommands["zone quests"] = AZP.SlashCommands["ZQ"]
AZP.SlashCommands["Zone Quests"] = AZP.SlashCommands["ZQ"]