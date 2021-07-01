if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["KorthiaQuests"] = 1
if AZP.KorthiaQuests == nil then AZP.KorthiaQuests = {} end
if AZP.KorthiaQuests.Events == nil then AZP.KorthiaQuests.Events = {} end

local EventFrame, AZPKQSelfFrame = nil, nil

function AZP.KorthiaQuests:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:SetScript("OnEvent", function(...) AZP.KorthiaQuests:OnEvent(...) end)
end

function AZP.KorthiaQuests:CreateUserFrame()
    AZPKQSelfFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    AZPKQSelfFrame:SetPoint("CENTER", 0, 250)
    AZPKQSelfFrame:SetSize(275, 380)
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

    local Quests = AZP.KorthiaQuests.Quests
    if AZPKQSelfFrame.QuestLabels == nil then AZPKQSelfFrame.QuestLabels = {} end
    for i = 1, #Quests.IDs do
        AZPKQSelfFrame.QuestLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        AZPKQSelfFrame.QuestLabels[i]:SetPoint("TOPLEFT", 10, -20 * i -20)
        local curID = Quests.IDs[i]
        local QColor = ""
        if C_QuestLog.IsQuestFlaggedCompleted(curID) == true then
            QColor = "|cFF00FF00"
        elseif C_QuestLog.IsOnQuest(curID) == true then
            QColor = "|cFFFFFF00"
        elseif C_QuestLog.IsQuestFlaggedCompleted(curID) == false then
            QColor = "|cFFFF0000"
        end
        AZPKQSelfFrame.QuestLabels[i]:SetText(QColor .. curID .. " - " .. Quests[curID].Name .. "|r")
    end
end

function AZP.KorthiaQuests:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.KorthiaQuests.Events:VariablesLoaded()
    end
end

function AZP.KorthiaQuests.Events:VariablesLoaded()
    C_Timer.NewTimer(5, function() AZP.KorthiaQuests:CreateUserFrame() end)
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