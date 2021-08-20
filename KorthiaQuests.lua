if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["KorthiaQuests"] = 7
if AZP.KorthiaQuests == nil then AZP.KorthiaQuests = {} end
if AZP.KorthiaQuests.Events == nil then AZP.KorthiaQuests.Events = {} end

if AZPKQFrameLocation == nil then AZPKQFrameLocation = {"CENTER", 0, 0} end

local EventFrame, AZPKQSelfFrame = nil, nil

function AZP.KorthiaQuests:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("QUEST_FINISHED")
    EventFrame:SetScript("OnEvent", function(...) AZP.KorthiaQuests:OnEvent(...) end)
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
    AZPKQSelfFrame.header = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormalHuge")
    AZPKQSelfFrame.header:SetPoint("TOP", 0, -10)
    AZPKQSelfFrame.header:SetText("|cFF00FFFFAzerPUG's Korthia Quests|r")

    AZPKQSelfFrame.closeButton = CreateFrame("Button", nil, AZPKQSelfFrame, "UIPanelCloseButton")
    AZPKQSelfFrame.closeButton:SetSize(25, 25)
    AZPKQSelfFrame.closeButton:SetPoint("TOPRIGHT", AZPKQSelfFrame, "TOPRIGHT", 2, 2)
    AZPKQSelfFrame.closeButton:SetScript("OnClick", function() AZP.KorthiaQuests:ShowHideFrame() end )

    if AZPKQSelfFrame.QuestIDLabels == nil then AZPKQSelfFrame.QuestIDLabels = {} end
    if AZPKQSelfFrame.QuestNameLabels == nil then AZPKQSelfFrame.QuestNameLabels = {} end
    if AZPKQSelfFrame.QuestLocationLabels == nil then AZPKQSelfFrame.QuestLocationLabels = {} end

    local Quests = AZP.KorthiaQuests.Quests
    for i = 1, #Quests.IDs do
        AZPKQSelfFrame.QuestIDLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestIDLabels[i]:SetPoint("TOPLEFT", 10, -20 * i -20)

        AZPKQSelfFrame.QuestNameLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestNameLabels[i]:SetPoint("TOP", 0, -20 * i -20)

        AZPKQSelfFrame.QuestLocationLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestLocationLabels[i]:SetPoint("TOPRIGHT", -10, -20 * i -20)
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
            AZPKQSelfFrame.QuestLocationLabels[i]:SetText(string.format("%s%s%s", QColor, "Treassures", ColorEnd))
        else
            AZPKQSelfFrame.QuestLocationLabels[i]:SetText(string.format("%s%.1f - %.1f%s", QColor, Quests[curID].Location.xVal, Quests[curID].Location.yVal, ColorEnd))
        end
    end
end

function AZP.KorthiaQuests:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.KorthiaQuests.Events:VariablesLoaded()
    elseif event == "QUEST_FINISHED" then
        C_Timer.NewTimer(5, function() AZP.KorthiaQuests.Events:QuestFinished() end)
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