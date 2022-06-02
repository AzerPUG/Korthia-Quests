if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["ZoneQuests"] = 12
if AZP.ZoneQuests == nil then AZP.ZoneQuests = {} end
if AZP.ZoneQuests.Events == nil then AZP.ZoneQuests.Events = {} end

if AZPKQFrameLocation == nil then AZPKQFrameLocation = {"CENTER", 0, 0} end

local EventFrame, AZPKQSelfFrame = nil, nil

local TomTomLoaded = false

function AZP.ZoneQuests:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("QUEST_FINISHED")
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:SetScript("OnEvent", function(...) AZP.ZoneQuests:OnEvent(...) end)
end

function AZP.ZoneQuests:CreateUserFrame()
    AZPKQSelfFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    AZPKQSelfFrame:SetPoint("CENTER", 0, 250)
    AZPKQSelfFrame:SetSize(265, 500)
    AZPKQSelfFrame:EnableMouse(true)
    AZPKQSelfFrame:SetMovable(true)
    AZPKQSelfFrame:RegisterForDrag("LeftButton")
    AZPKQSelfFrame:SetScript("OnDragStart", AZPKQSelfFrame.StartMoving)
    AZPKQSelfFrame:SetScript("OnDragStop", function() AZPKQSelfFrame:StopMovingOrSizing() AZP.ZoneQuests:SaveLocation() end)
    AZPKQSelfFrame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    AZPKQSelfFrame:SetBackdropColor(0.25, 0.25, 0.25, 0.80)
    AZPKQSelfFrame.Header = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormalHuge")
    AZPKQSelfFrame.Header:SetPoint("TOP", 0, -10)
    AZPKQSelfFrame.Header:SetText("|cFF00FFFFAzerPUG's\nZerethMortis Quests|r")

    AZPKQSelfFrame.closeButton = CreateFrame("Button", nil, AZPKQSelfFrame, "UIPanelCloseButton")
    AZPKQSelfFrame.closeButton:SetSize(25, 25)
    AZPKQSelfFrame.closeButton:SetPoint("TOPRIGHT", AZPKQSelfFrame, "TOPRIGHT", 2, 2)
    AZPKQSelfFrame.closeButton:SetScript("OnClick", function() AZP.ZoneQuests:ShowHideFrame() end )

    --if AZPKQSelfFrame.QuestIDLabels == nil then AZPKQSelfFrame.QuestIDLabels = {} end
    if AZPKQSelfFrame.QuestNameLabels == nil then AZPKQSelfFrame.QuestNameLabels = {} end
    --if AZPKQSelfFrame.QuestLocationLabels == nil then AZPKQSelfFrame.QuestLocationLabels = {} end

    local ScrollFrame = CreateFrame("ScrollFrame", nil, AZPKQSelfFrame, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetSize(AZPKQSelfFrame:GetWidth() - 25, AZPKQSelfFrame:GetHeight() - 60)
    ScrollFrame:SetPoint("TOPLEFT", 0, -55)
    local ScrollPanel = CreateFrame("Frame", nil)
    ScrollPanel:SetSize(ScrollFrame:GetWidth(), 100)
    ScrollPanel:SetPoint("TOP", 0, 0)
    ScrollFrame:SetScrollChild(ScrollPanel)

    local Quests = AZP.ZoneQuests.Quests.ZerethMortis
    local QuestLineFrames = {}
    for i = 1, #Quests.QLNames do
        local QuestLineName = Quests.QLNames[i]
        local QuestIDs = Quests.IDs[QuestLineName]
        local curQLFrame = CreateFrame("FRAME", nil, ScrollPanel)
        curQLFrame:SetWidth(ScrollPanel:GetWidth())
        QuestLineFrames[#QuestLineFrames + 1] = curQLFrame
        curQLFrame.QuestFrames = {}

        -- curQLFrame.Name = curQLFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
        -- curQLFrame.Name:SetSize(curQLFrame:GetWidth(), 16)
        -- curQLFrame.Name:SetPoint("TOP", 0, 0)
        -- curQLFrame.Name:SetText(QuestLineName)
        -- curQLFrame.Name:SetJustifyH("LEFT")

        curQLFrame.Name = CreateFrame("BUTTON", nil, curQLFrame)
        curQLFrame.Name:SetSize(curQLFrame:GetWidth(), 20)
        curQLFrame.Name:SetPoint("TOP", 0, 0)
        curQLFrame.Name.Button = curQLFrame.Name:CreateTexture(nil, "ARTWORK")
        curQLFrame.Name.Button:SetSize(20, 20)
        curQLFrame.Name.Button:SetPoint("LEFT", 0, 0)
        curQLFrame.Name.Button:SetTexture(AZP.ZoneQuests.Textures.PlusButton)
        curQLFrame.Name.Text = curQLFrame.Name:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormalLarge")
        curQLFrame.Name.Text:SetSize(curQLFrame.Name:GetWidth() - 25, curQLFrame.Name:GetHeight())
        curQLFrame.Name.Text:SetPoint("LEFT", curQLFrame.Name.Button, "RIGHT", 5, 0)
        curQLFrame.Name.Text:SetText(QuestLineName)
        curQLFrame.Name.Text:SetJustifyH("LEFT")

        for j = 1, #QuestIDs do
            local curQFrame = CreateFrame("FRAME", nil, curQLFrame)
            curQFrame:SetSize(curQLFrame:GetWidth() - 15, 16)
            if #curQLFrame.QuestFrames == 0 then curQFrame:SetPoint("TOP", curQLFrame.Name, "BOTTOM", 25, -1)
            else curQFrame:SetPoint("TOP", curQLFrame.QuestFrames[#curQLFrame.QuestFrames], "BOTTOM", 0, -1) end

            -- AZPKQSelfFrame.QuestIDLabels[i] = AZPKQSelfFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormal")
            -- AZPKQSelfFrame.QuestIDLabels[i]:SetPoint("TOPLEFT", 10, -20 * i -20)

            curQFrame.ID = QuestIDs[j]

            local curID = 64944

            curQFrame.NameLabel = curQFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormalLarge")
            curQFrame.NameLabel:SetSize(curQFrame:GetWidth(), curQFrame:GetHeight())
            curQFrame.NameLabel:SetPoint("CENTER", 0, 0)
            curQFrame.NameLabel:SetText(Quests[QuestIDs[j]].Name)
            --DevTools_Dump(Quests)
            --curQFrame.NameLabel:SetText(Quests[curID].Name)
            curQFrame.NameLabel:SetJustifyH("LEFT")

            curQLFrame.QuestFrames[#curQLFrame.QuestFrames + 1] = curQFrame
            AZPKQSelfFrame.QuestNameLabels[#AZPKQSelfFrame.QuestNameLabels + 1] = curQFrame

        end

        curQLFrame.Name:SetScript("OnClick",
        function()
            for j, curFrame in pairs(curQLFrame.QuestFrames) do
                    if curFrame:IsShown() == true then curFrame:Hide() curFrame:SetHeight(0) curQLFrame.Name.Button:SetTexture(AZP.ZoneQuests.Textures.PlusButton) curQLFrame:SetHeight(16)
                elseif curFrame:IsShown() == false then curFrame:Show() curFrame:SetHeight(16) curQLFrame.Name.Button:SetTexture(AZP.ZoneQuests.Textures.MinusButton) curQLFrame:SetHeight(#curQLFrame.QuestFrames * 18 + 16) end
            end
        end)

        curQLFrame:SetHeight(#curQLFrame.QuestFrames * 18 + 16)
        if #QuestLineFrames == 1 then curQLFrame:SetPoint("TOP", 5, 0)
        else curQLFrame:SetPoint("TOP", QuestLineFrames[#QuestLineFrames - 1], "BOTTOM", 0, -5) end

        for j, curFrame in pairs(curQLFrame.QuestFrames) do
            curFrame:Hide() curFrame:SetHeight(0) curQLFrame:SetHeight(16)
        end
    end
    AZP.ZoneQuests.Events:QuestFinished()
end

function AZP.ZoneQuests:SaveLocation()
    local temp = {}
    temp[1], temp[2], temp[3], temp[4], temp[5] = AZPKQSelfFrame:GetPoint()
    AZPKQFrameLocation = temp
end

function AZP.ZoneQuests:LoadLocation()
    AZPKQSelfFrame:SetPoint(AZPKQFrameLocation[1], AZPKQFrameLocation[4], AZPKQFrameLocation[5])
end

function AZP.ZoneQuests.Events:QuestFinished()
    --local Quests = AZP.ZoneQuests.Quests.ZerethMortis
    local ColorEnd = "\124r"

    for i = 1, #AZPKQSelfFrame.QuestNameLabels do
        local curID = AZPKQSelfFrame.QuestNameLabels[i].ID
        local QColor = ""

            if C_QuestLog.IsOnQuest(curID) == true then QColor = "FFFFFF00"
        elseif C_QuestLog.IsQuestFlaggedCompleted(curID) == true then QColor = "FF00FF00"
        elseif C_QuestLog.IsQuestFlaggedCompleted(curID) == false then QColor = "FFFF0000" end


        --AZPKQSelfFrame.QuestIDLabels[i]:SetText(string.format("%s%d%s", QColor, curID, ColorEnd))
        local curName = AZPKQSelfFrame.QuestNameLabels[i].NameLabel:GetText()
        AZPKQSelfFrame.QuestNameLabels[i].NameLabel:SetText(string.format("|c%s%s%s", QColor, curName, ColorEnd))
        -- if Quests[curID].Location.xVal == nil or Quests[curID].Location.yVal == nil then
        --     AZPKQSelfFrame.QuestLocationLabels[i].text:SetText(string.format("%s%s%s", QColor, "Treassures", ColorEnd))
        -- else
        --     AZPKQSelfFrame.QuestLocationLabels[i].text:SetText(string.format("%s%.1f - %.1f%s", QColor, Quests[curID].Location.xVal, Quests[curID].Location.yVal, ColorEnd))
        -- end
    end
end

function AZP.ZoneQuests:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.ZoneQuests.Events:VariablesLoaded()
    elseif event == "QUEST_FINISHED" then
        C_Timer.NewTimer(5, function() AZP.ZoneQuests.Events:QuestFinished() end)
    elseif event == "ADDON_LOADED" then
        local AddOnName = ...
        if AddOnName == "TomTom" then TomTomLoaded = true end
    end
end

function AZP.ZoneQuests.Events:VariablesLoaded()
    C_Timer.NewTimer(5, function() AZP.ZoneQuests:CreateUserFrame() AZP.ZoneQuests:LoadLocation() end)
end

function AZP.ZoneQuests:ShowHideFrame()
    if AZPKQSelfFrame:IsShown() then
        AZPKQSelfFrame:Hide()
        --AZPCoreShown = false
    elseif not AZPKQSelfFrame:IsShown() then
        AZPKQSelfFrame:Show()
        --AZPCoreShown = true
    end
end

AZP.ZoneQuests:OnLoadSelf()

AZP.SlashCommands["ZQ"] = function()
    AZP.ZoneQuests:ShowHideFrame()
end

AZP.SlashCommands["KQ"] = function()
    print("Korthia Quests has been renamed to ZoneQuests!")
    print("The AddOn was popular enough to adjust it for Zereth Mortis.")
    print("Please start using the new command: '/azp zq' to open the new window!")
    print("Korthia data is temporarily unavailable, fix coming soon. Sorry!")
end

AZP.SlashCommands["kq"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["korthia quests"] = AZP.SlashCommands["KQ"]
AZP.SlashCommands["Korthia Quests"] = AZP.SlashCommands["KQ"]

AZP.SlashCommands["zq"] = AZP.SlashCommands["ZQ"]
AZP.SlashCommands["zone quests"] = AZP.SlashCommands["ZQ"]
AZP.SlashCommands["Zone Quests"] = AZP.SlashCommands["ZQ"]