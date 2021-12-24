if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["KorthiaQuests"] = 8
if AZP.KorthiaQuests == nil then AZP.KorthiaQuests = {} end
if AZP.KorthiaQuests.Events == nil then AZP.KorthiaQuests.Events = {} end

if AZPKQFrameLocation == nil then AZPKQFrameLocation = {"CENTER", 0, 0} end

local EventFrame, AZPKQSelfFrame = nil, nil

local TomTomLoaded = false

local messageShow = false

function AZP.KorthiaQuests:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("QUEST_FINISHED")
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:SetScript("OnEvent", function(...) AZP.KorthiaQuests:OnEvent(...) end)

    if messageShow == false then
        local RenamingMessage = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate")
        RenamingMessage:SetSize(200, 200)
        RenamingMessage:SetPoint("CENTER", 0, 200)
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
        RenamingMessage.Header:SetText("|cFF00FF00AzerPUG's Korthia Quests\nAddOn is being Renamed!|r")

        RenamingMessage.Message = RenamingMessage:CreateFontString("RenamingMessage", "ARTWORK", "GameFontNormal")
        RenamingMessage.Message:SetSize(RenamingMessage:GetWidth() - 10, 140)
        RenamingMessage.Message:SetPoint("TOP", 0, -55)
        RenamingMessage.Message:SetText(
            "Due to the popularity of this AddOn, we are upgrading it!\n" ..
            "Soon this AddOn will be renamed to ZoneQuests!\n" ..
            "Over the next few weeks, we will slowly be adding Zereth Mortis functionality.\n" ..
            "We will of course also make it possible to still check your Korthia things!\n"
        )

        RenamingMessage.CloseButton = CreateFrame("Button", nil, RenamingMessage, "UIPanelCloseButton")
        RenamingMessage.CloseButton:SetSize(25, 25)
        RenamingMessage.CloseButton:SetPoint("TOPRIGHT", RenamingMessage, "TOPRIGHT", 2, 2)
        RenamingMessage.CloseButton:SetScript("OnClick", function() messageShow = true RenamingMessage:Hide() end )
    end
end

function AZP.KorthiaQuests:CreateUserFrame()
    AZPKQSelfFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    AZPKQSelfFrame:SetPoint("CENTER", 0, 250)
    AZPKQSelfFrame:SetSize(375, 385)
    AZPKQSelfFrame:EnableMouse(true)
    AZPKQSelfFrame:SetMovable(true)
    AZPKQSelfFrame:RegisterForDrag("LeftButton")
    AZPKQSelfFrame:SetScript("OnDragStart", AZPKQSelfFrame.StartMoving)
    AZPKQSelfFrame:SetScript("OnDragStop", function() AZPKQSelfFrame:StopMovingOrSizing() AZP.KorthiaQuests:SaveLocation() end)
    AZPKQSelfFrame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    AZPKQSelfFrame:SetBackdropColor(0.25, 0.25, 0.25, 0.80)
    AZPKQSelfFrame.Header = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormalHuge")
    AZPKQSelfFrame.Header:SetPoint("TOP", 0, -10)
    AZPKQSelfFrame.Header:SetText("|cFF00FFFFAzerPUG's Korthia Quests|r")

    AZPKQSelfFrame.CloseButton = CreateFrame("Button", nil, AZPKQSelfFrame, "UIPanelCloseButton")
    AZPKQSelfFrame.CloseButton:SetSize(25, 25)
    AZPKQSelfFrame.CloseButton:SetPoint("TOPRIGHT", AZPKQSelfFrame, "TOPRIGHT", 2, 2)
    AZPKQSelfFrame.CloseButton:SetScript("OnClick", function() AZP.KorthiaQuests:ShowHideFrame() end )

    if AZPKQSelfFrame.QuestIDLabels == nil then AZPKQSelfFrame.QuestIDLabels = {} end
    if AZPKQSelfFrame.QuestNameLabels == nil then AZPKQSelfFrame.QuestNameLabels = {} end
    if AZPKQSelfFrame.QuestLocationLabels == nil then AZPKQSelfFrame.QuestLocationLabels = {} end

    local Quests = AZP.KorthiaQuests.Quests
    for i = 1, #Quests.IDs do
        AZPKQSelfFrame.QuestIDLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestIDLabels[i]:SetPoint("TOPLEFT", 10, -20 * i -20)

        AZPKQSelfFrame.QuestNameLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestNameLabels[i]:SetPoint("TOP", 0, -20 * i -20)

        AZPKQSelfFrame.QuestLocationLabels[i] = CreateFrame("Frame", nil, AZPKQSelfFrame)
        AZPKQSelfFrame.QuestLocationLabels[i]:SetSize(60, 16)
        AZPKQSelfFrame.QuestLocationLabels[i]:SetPoint("TOPRIGHT", -10, -20 * i -20)
        AZPKQSelfFrame.QuestLocationLabels[i]:SetScript("OnMouseDown",
            function()
                if i ~= 2 then
                    if TomTomLoaded == true then
                        local curID = Quests.IDs[i]
                        local curX = Quests[curID].Location.xVal
                        local curY = Quests[curID].Location.yVal
                        local curName = Quests[curID].Name
                        TomTom:AddWaypoint(1961, curX/100, curY/100, {title = curName, persistent = false, source = "Added by AzerPUG's Korthia Quests."})
                    end
                end
            end)

        AZPKQSelfFrame.QuestLocationLabels[i].text = AZPKQSelfFrame.QuestLocationLabels[i]:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestLocationLabels[i].text:SetPoint("CENTER", 0, 0)
    end
    AZP.KorthiaQuests.Events:QuestFinished()
end

function AZP.KorthiaQuests:SaveLocation()
    local temp = {}
    temp[1], temp[2], temp[3], temp[4], temp[5] = AZPKQSelfFrame:GetPoint()
    AZPKQFrameLocation = temp
end

function AZP.KorthiaQuests:LoadLocation()
    AZPKQSelfFrame:SetPoint(AZPKQFrameLocation[1], AZPKQFrameLocation[4], AZPKQFrameLocation[5])
end

function AZP.KorthiaQuests.Events:QuestFinished()
    local Quests = AZP.KorthiaQuests.Quests
    local ColorEnd = "|r"
    for i = 1, #Quests.IDs do
        local curID = Quests.IDs[i]
        local QColor = ""
        if C_QuestLog.IsQuestFlaggedCompleted(curID) == true then
            QColor = "|cFF00FF00"
        elseif C_QuestLog.IsOnQuest(curID) == true then
            QColor = "|cFFFFFF00"
        elseif C_QuestLog.IsQuestFlaggedCompleted(curID) == false then
            QColor = "|cFFFF0000"
        end

        AZPKQSelfFrame.QuestIDLabels[i]:SetText(string.format("%s%d%s", QColor, curID, ColorEnd))
        AZPKQSelfFrame.QuestNameLabels[i]:SetText(string.format("%s%s%s", QColor, Quests[curID].Name, ColorEnd))
        if Quests[curID].Location.xVal == nil or Quests[curID].Location.yVal == nil then
            AZPKQSelfFrame.QuestLocationLabels[i].text:SetText(string.format("%s%s%s", QColor, "Treassures", ColorEnd))
        else
            AZPKQSelfFrame.QuestLocationLabels[i].text:SetText(string.format("%s%.1f - %.1f%s", QColor, Quests[curID].Location.xVal, Quests[curID].Location.yVal, ColorEnd))
        end
    end
end

function AZP.KorthiaQuests:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.KorthiaQuests.Events:VariablesLoaded()
    elseif event == "QUEST_FINISHED" then
        C_Timer.NewTimer(5, function() AZP.KorthiaQuests.Events:QuestFinished() end)
    elseif event == "ADDON_LOADED" then
        local AddOnName = ...
        if AddOnName == "TomTom" then TomTomLoaded = true end
    end
end

function AZP.KorthiaQuests.Events:VariablesLoaded()
    C_Timer.NewTimer(5, function() AZP.KorthiaQuests:CreateUserFrame() AZP.KorthiaQuests:LoadLocation() end)
end

function AZP.KorthiaQuests:ShowHideFrame()
    if AZPKQSelfFrame:IsShown() then
        AZPKQSelfFrame:Hide()
        --AZPCoreShown = false
    elseif not AZPKQSelfFrame:IsShown() then
        AZPKQSelfFrame:Show()
        --AZPCoreShown = true
    end
end

AZP.KorthiaQuests:OnLoadSelf()

AZP.SlashCommands["KQ"] = function()
    AZP.KorthiaQuests:ShowHideFrame()
end

AZP.SlashCommands["kq"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["korthia"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["korthia quests"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["Korthia Quests"] = AZP.SlashCommands["KQ"]