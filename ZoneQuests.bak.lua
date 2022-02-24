if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["ZoneQuests"] = 9
if AZP.ZoneQuests == nil then AZP.ZoneQuests = {} end
if AZP.ZoneQuests.Events == nil then AZP.ZoneQuests.Events = {} end

if AZPKQFrameLocation == nil then AZPKQFrameLocation = {"CENTER", 0, 0} end

local EventFrame, AZPKQSelfFrame = nil, nil

local QuestZoneSelectionFrame = nil
AZP.ZoneQuests.ZoneFrames = {}
AZP.ZoneQuests.ZoneIcons = {}

function AZP.ZoneQuests:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:SetScript("OnEvent", function(...) AZP.ZoneQuests:OnEvent(...) end)
end

function AZP.ZoneQuests:CreateSelectorFrame()
    QuestZoneSelectionFrame = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate")
    QuestZoneSelectionFrame:SetPoint("CENTER", 0, 0)

    QuestZoneSelectionFrame.BG1 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    QuestZoneSelectionFrame.BG1:SetPoint("LEFT", 2, 0)
    QuestZoneSelectionFrame.BG1:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\QuestBackgroundShadowlandsOribos"))
    QuestZoneSelectionFrame.BG1:SetTexCoord(0.59, 0, 0, 0.75)
    -- QuestZoneSelectionFrame.BG1:SetAlpha(1)

    QuestZoneSelectionFrame.BG2 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    QuestZoneSelectionFrame.BG2:SetPoint("RIGHT", -2, 0)
    QuestZoneSelectionFrame.BG2:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\QuestBackgroundShadowlandsOribos"))
    QuestZoneSelectionFrame.BG2:SetTexCoord(0, 0.59, 0, 0.75)
    -- QuestZoneSelectionFrame.BG2:SetAlpha(1)

    -- QuestZoneSelectionFrame.Background = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    -- QuestZoneSelectionFrame.Background:SetPoint("CENTER", 0, 0)
    -- QuestZoneSelectionFrame.Background:SetTexture(GetFileIDFromPath("Interface\\ENCOUNTERJOURNAL\\UI-EJ-LOREBG-SanctumofDomination"))
    -- QuestZoneSelectionFrame.Background:SetTexCoord(0.03425, 0.72525, 0.0585, 0.60)
    -- QuestZoneSelectionFrame.Background:SetAlpha(0.8)

    -- QuestZoneSelectionFrame.BG1 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    -- QuestZoneSelectionFrame.BG1:SetPoint("TOPLEFT", 0, 0)
    -- QuestZoneSelectionFrame.BG1:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\UI-Quest-TopRight"))
    -- QuestZoneSelectionFrame.BG1:SetTexCoord(1, 0, 0, 1)
    -- QuestZoneSelectionFrame.BG1:SetAlpha(1)

    -- QuestZoneSelectionFrame.BG2 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    -- QuestZoneSelectionFrame.BG2:SetPoint("LEFT", QuestZoneSelectionFrame.BG1, "RIGHT", 0, 0)
    -- QuestZoneSelectionFrame.BG2:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\UI-Quest-TopRight"))
    -- --QuestZoneSelectionFrame.BG2:SetTexCoord(0.03425, 0.72525, 0.0585, 0.60)
    -- QuestZoneSelectionFrame.BG2:SetAlpha(1)

    -- QuestZoneSelectionFrame.BG3 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    -- QuestZoneSelectionFrame.BG3:SetPoint("TOP", QuestZoneSelectionFrame.BG1, "BOTTOM", 0, 0)
    -- QuestZoneSelectionFrame.BG3:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\UI-Quest-BotRight"))
    -- QuestZoneSelectionFrame.BG3:SetTexCoord(1, 0, 0, 1)
    -- QuestZoneSelectionFrame.BG3:SetAlpha(1)

    -- QuestZoneSelectionFrame.BG4 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    -- QuestZoneSelectionFrame.BG4:SetPoint("TOP", QuestZoneSelectionFrame.BG2, "BOTTOM", 0, 0)
    -- QuestZoneSelectionFrame.BG4:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\UI-Quest-BotRight"))
    -- --QuestZoneSelectionFrame.BG4:SetTexCoord(0.03425, 0.72525, 0.0585, 0.60)
    -- QuestZoneSelectionFrame.BG4:SetAlpha(1)

    -- QuestZoneSelectionFrame.BG5 = QuestZoneSelectionFrame:CreateTexture(nil, "ARTWORK")
    -- QuestZoneSelectionFrame.BG5:SetPoint("CENTER", 0, 0)
    -- QuestZoneSelectionFrame.BG5:SetTexture(GetFileIDFromPath("Interface\\QUESTFRAME\\QuestBackgroundShadowlandsOribos"))
    -- --QuestZoneSelectionFrame.BG5:SetTexCoord(0.03425, 0.72525, 0.0585, 0.60)
    -- QuestZoneSelectionFrame.BG5:SetAlpha(1)

    QuestZoneSelectionFrame:SetBackdrop({
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 10,
        insets = {left = 3, right = 3, top = 3, bottom = 3},
    })

    QuestZoneSelectionFrame.Header = QuestZoneSelectionFrame:CreateFontString("AZPRTBossToolsFrame", "ARTWORK", "GameFontNormalHuge")
    QuestZoneSelectionFrame.Header:SetSize(QuestZoneSelectionFrame:GetWidth(), 50)
    QuestZoneSelectionFrame.Header:SetPoint("TOP", 0, -5)
    QuestZoneSelectionFrame.Header:SetText(string.format("|cFF00FFFFAzerPUG's\nKorthia Quests v%s|r", AZP.VersionControl["ZoneQuests"]))

    QuestZoneSelectionFrame.SubHeader = QuestZoneSelectionFrame:CreateFontString("AZPRTBossToolsFrame", "ARTWORK", "GameFontNormalLarge")
    QuestZoneSelectionFrame.SubHeader:SetSize(QuestZoneSelectionFrame:GetWidth(), 50)
    QuestZoneSelectionFrame.SubHeader:SetPoint("TOP", QuestZoneSelectionFrame.Header, "BOTTOM", 0, 20)
    QuestZoneSelectionFrame.SubHeader:SetText("|cFF00FFFFZone Selector Frame|r")

    local BossWidth, BossHeight = 50, 50

    for Zone, Info in pairs(AZP.ZoneQuests.QuestZones) do
        if Info.Active ~= false then
            local curFrame = CreateFrame("FRAME", nil, QuestZoneSelectionFrame)
            curFrame:SetSize(BossWidth, BossHeight)
            curFrame:SetScript("OnMouseDown", function() if AZP.ZoneQuests.ZoneFrames[Zone] ~= nil then QuestZoneSelectionFrame:Hide() AZP.ZoneQuests.ZoneFrames[Zone]:Show() end end)
            curFrame.Button = curFrame:CreateTexture(nil, "ARTWORK")
            curFrame.Button:SetSize(curFrame:GetWidth(), curFrame:GetHeight())
            curFrame.Button:SetPoint("BOTTOM", 0, 0)
            curFrame.Button:SetTexture(Info.FileID)
            curFrame.Label = curFrame:CreateFontString("QuestZoneSelectionFrame", "ARTWORK", "GameFontNormalLarge")
            curFrame.Label:SetSize(curFrame:GetWidth(), curFrame:GetHeight())
            curFrame.Label:SetPoint("TOP", 0, curFrame:GetHeight())
            curFrame.Label:SetText(string.format("|cFF00FFFF%s|r", Info.Name))
            curFrame.Label:SetJustifyH("CENTER")
            curFrame.Label:SetJustifyV("BOTTOM")

            if Info.Active == "Soon" then
                curFrame.Button:SetDesaturated(true)
                curFrame.ComingSoon = curFrame:CreateFontString("QuestZoneSelectionFrame", "ARTWORK", "GameFontNormalLarge")
                curFrame.ComingSoon:SetSize(curFrame:GetWidth(), curFrame:GetHeight())
                curFrame.ComingSoon:SetPoint("CENTER", 0, 0)
                curFrame.ComingSoon:SetText("|cFF00FFFFComing\nSoon!|r")
            end

            curFrame.Index = Info.Index
            AZP.ZoneQuests.ZoneIcons[#AZP.ZoneQuests.ZoneIcons + 1] = curFrame
        end
    end

    --local iconsPerRow = {math.floor(#AZP.ZoneQuests.ZoneIcons / 2), math.ceil(#AZP.ZoneQuests.ZoneIcons / 2)}
    local iconsPerRow = {2, 2}
    local FrameWidth = (iconsPerRow[2] * 100 + 25)
    --if FrameWidth < 280 then FrameWidth = 280 end
    QuestZoneSelectionFrame:SetSize(FrameWidth, FrameWidth - 15)
    -- QuestZoneSelectionFrame.BG1:SetSize(QuestZoneSelectionFrame:GetWidth() / 2, QuestZoneSelectionFrame:GetHeight() / 2)
    -- QuestZoneSelectionFrame.BG2:SetSize(QuestZoneSelectionFrame:GetWidth() / 2, QuestZoneSelectionFrame:GetHeight() / 2)
    -- QuestZoneSelectionFrame.BG3:SetSize(QuestZoneSelectionFrame:GetWidth() / 2, QuestZoneSelectionFrame:GetHeight() / 2)
    -- QuestZoneSelectionFrame.BG4:SetSize(QuestZoneSelectionFrame:GetWidth() / 2, QuestZoneSelectionFrame:GetHeight() / 2)
    QuestZoneSelectionFrame.BG1:SetSize((QuestZoneSelectionFrame:GetWidth() / 2) - 1, QuestZoneSelectionFrame:GetHeight() - 5)
    QuestZoneSelectionFrame.BG2:SetSize((QuestZoneSelectionFrame:GetWidth() / 2) - 1, QuestZoneSelectionFrame:GetHeight() - 5)

    table.sort(AZP.ZoneQuests.ZoneIcons, function(a,b) return a.Index < b.Index end)

    if #AZP.ZoneQuests.ZoneIcons == 0 then return
    elseif #AZP.ZoneQuests.ZoneIcons > 0 then
        for i = 1, #AZP.ZoneQuests.ZoneIcons do
            local BottomOffset = {[1] = 0, [2] = 8, [3] =  9, [4] = 10, [5] = 13,}
            local   LeftOffset = {[1] = 0, [2] = 28, [3] = 22, [4] = 17, [5] = 11,}
            if i == 1 then AZP.ZoneQuests.ZoneIcons[i]:SetPoint("BOTTOM", (-30 * iconsPerRow[1]) + LeftOffset[iconsPerRow[1]], 5)
            elseif i == (iconsPerRow[1] + 1) then AZP.ZoneQuests.ZoneIcons[i]:SetPoint("BOTTOM", (-35 * iconsPerRow[2]) + LeftOffset[iconsPerRow[2]], BottomOffset[iconsPerRow[2]])
            else AZP.ZoneQuests.ZoneIcons[i]:SetPoint("LEFT", AZP.ZoneQuests.ZoneIcons[i-1], "RIGHT", 15, 0) end
        end
    end

    QuestZoneSelectionFrame.closeButton = CreateFrame("Button", nil, QuestZoneSelectionFrame, "UIPanelCloseButton")
    QuestZoneSelectionFrame.closeButton:SetSize(20, 21)
    QuestZoneSelectionFrame.closeButton:SetPoint("TOPRIGHT", QuestZoneSelectionFrame, "TOPRIGHT", 1, 2)
    QuestZoneSelectionFrame.closeButton:SetScript("OnClick", function() QuestZoneSelectionFrame:Hide() end)

    QuestZoneSelectionFrame:Hide()
end

function AZP.ZoneQuests:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.ZoneQuests.Events:VariablesLoaded()
    end
end

function AZP.ZoneQuests.Events:VariablesLoaded()
    if AZPZQTempVar == nil then AZPZQTempVar = false end
    AZP.ZoneQuests:CreateTempRenameFrame()
    C_Timer.NewTimer(5, function() AZP.ZoneQuests:CreateSelectorFrame()  end)
end

function AZP.ZoneQuests:CreateTempRenameFrame()
    if AZPZQTempVar == false then
        local RenamingMessage = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate")
        RenamingMessage:SetSize(400, 125)
        RenamingMessage:SetPoint("CENTER", 0, 250)
        RenamingMessage:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 1, right = 1, top = 1, bottom = 1 },
        })
        RenamingMessage:SetBackdropColor(0.25, 0.25, 0.25, 0.80)

        RenamingMessage.Header = RenamingMessage:CreateFontString("RenamingMessage", "ARTWORK", "GameFontNormalHuge")
        RenamingMessage.Header:SetSize(RenamingMessage:GetWidth() - 10, 50)
        RenamingMessage.Header:SetPoint("TOP", 0, -5)
        RenamingMessage.Header:SetText("|cFF00FFFFAzerPUG's Korthia Quests\nAddOn is being Renamed!|r")

        RenamingMessage.Message = RenamingMessage:CreateFontString("RenamingMessage", "ARTWORK", "GameFontNormal")
        RenamingMessage.Message:SetSize(RenamingMessage:GetWidth() - 10, 140)
        RenamingMessage.Message:SetPoint("TOP", 0, -15)
        RenamingMessage.Message:SetText(
            "Due to the popularity of this AddOn, we are upgrading it!\n" ..
            "Soon this AddOn will be renamed to ZoneQuests!\n" ..
            "Over the next few weeks, we will slowly be adding Zereth Mortis functionality.\n" ..
            "We will of course also make it possible to still check your Korthia things!\n"
        )

        RenamingMessage.CloseButton = CreateFrame("Button", nil, RenamingMessage, "UIPanelCloseButton")
        RenamingMessage.CloseButton:SetSize(25, 25)
        RenamingMessage.CloseButton:SetPoint("TOPRIGHT", RenamingMessage, "TOPRIGHT", 2, 2)
        RenamingMessage.CloseButton:SetScript("OnClick", function() AZPZQTempVar = true RenamingMessage:Hide() end )
    end
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

AZP.SlashCommands["KQ"] = function()
    print("Korthia Quests is being renamed and this slashcommand will soon be obsolete.")
    print("Please start using '/azp zq' instead (Zone Quests).")
    QuestZoneSelectionFrame:Show()
end

AZP.SlashCommands["zq"] = AZP.SlashCommands["ZQ"]
AZP.SlashCommands["zone quests"] = AZP.SlashCommands["ZQ"]
AZP.SlashCommands["Zone Quests"] = AZP.SlashCommands["ZQ"]

AZP.SlashCommands["kq"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["korthia"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["Korthia"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["korthia quests"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["Korthia Quests"] = AZP.SlashCommands["KQ"]