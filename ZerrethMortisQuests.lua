if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

if AZP.ZoneQuests.ZerrethMortis == nil then AZP.ZoneQuests.ZerrethMortis = {} end
if AZP.ZoneQuests.ZerrethMortis.Events == nil then AZP.ZoneQuests.ZerrethMortis.Events = {} end

if AZPKQFrameLocation == nil then AZPKQFrameLocation = {"CENTER", 0, 0} end

local EventFrame, AZPKQSelfFrame = nil, nil

local TomTomLoaded = false


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

function AZP.ZoneQuests.ZerrethMortis:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("QUEST_FINISHED")
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:SetScript("OnEvent", function(...) AZP.ZoneQuests.ZerrethMortis:OnEvent(...) end)


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

function AZP.ZoneQuests.ZerrethMortis:CreateUserFrame()
    AZPKQSelfFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    AZPKQSelfFrame:SetPoint("CENTER", 0, 250)
    AZPKQSelfFrame:SetSize(265, 500)
    AZPKQSelfFrame:EnableMouse(true)
    AZPKQSelfFrame:SetMovable(true)
    AZPKQSelfFrame:RegisterForDrag("LeftButton")
    AZPKQSelfFrame:SetScript("OnDragStart", AZPKQSelfFrame.StartMoving)
    AZPKQSelfFrame:SetScript("OnDragStop", function() AZPKQSelfFrame:StopMovingOrSizing() AZP.ZoneQuests.ZerrethMortis.ZerrethMortis:SaveLocation() end)
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
    AZPKQSelfFrame.closeButton:SetScript("OnClick", function() AZPKQSelfFrame:Hide() end )

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

            curQFrame.NameLabel = curQFrame:CreateFontString("AZPKQSelfFrame", "ARTWORK", "GameFontNormalLarge")
            curQFrame.NameLabel:SetSize(curQFrame:GetWidth(), curQFrame:GetHeight())
            curQFrame.NameLabel:SetPoint("CENTER", 0, 0)
            curQFrame.NameLabel:SetText(Quests[QuestIDs[j]].Name)
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
    AZP.ZoneQuests.ZerrethMortis.Events:QuestFinished()
    AZP.ZoneQuests.ZoneFrames.ZerethMortis = AZPKQSelfFrame
    AZPKQSelfFrame:Hide()
end

function AZP.ZoneQuests.ZerrethMortis:SaveLocation()
    local temp = {}
    temp[1], temp[2], temp[3], temp[4], temp[5] = AZPKQSelfFrame:GetPoint()
    AZPKQFrameLocation = temp
end

function AZP.ZoneQuests.ZerrethMortis:LoadLocation()
    AZPKQSelfFrame:SetPoint(AZPKQFrameLocation[1], AZPKQFrameLocation[4], AZPKQFrameLocation[5])
end

function AZP.ZoneQuests.ZerrethMortis.Events:QuestFinished()
    print("AZP.ZoneQuests.ZerrethMortis.Events:QuestFinished() Called!")
    --local Quests = AZP.ZoneQuests.ZerrethMortis.Quests.ZerethMortis
    local ColorEnd = "\124r"
    local Quests = AZP.ZoneQuests.Quests.ZerethMortis
    for i = 1, #AZPKQSelfFrame.QuestNameLabels do
        local curID = AZPKQSelfFrame.QuestNameLabels[i].ID
        local QColor = ""

            if C_QuestLog.IsOnQuest(curID) == true then QColor = "FFFFFF00" if curID == 64820 then print("Derp1") end
        elseif C_QuestLog.IsQuestFlaggedCompleted(curID) == true then QColor = "FF00FF00" if curID == 64820 then print("Derp2") end
        elseif C_QuestLog.IsQuestFlaggedCompleted(curID) == false then QColor = "FFFF0000" if curID == 64820 then print("Derp3") end end

        if curID == 64820 then print("Yes that one!! i = ", i, " and color = ", QColor) end

        --AZPKQSelfFrame.QuestIDLabels[i]:SetText(string.format("%s%d%s", QColor, curID, ColorEnd))
        local curName = Quests[curID].Name
        AZPKQSelfFrame.QuestNameLabels[i].NameLabel:SetText(string.format("|c%s%s%s", QColor, curName, ColorEnd))
        print(">" .. AZPKQSelfFrame.QuestNameLabels[i].NameLabel:GetText())

        -- if Quests[curID].Location.xVal == nil or Quests[curID].Location.yVal == nil then
        --     AZPKQSelfFrame.QuestLocationLabels[i].text:SetText(string.format("%s%s%s", QColor, "Treassures", ColorEnd))
        -- else
        --     AZPKQSelfFrame.QuestLocationLabels[i].text:SetText(string.format("%s%.1f - %.1f%s", QColor, Quests[curID].Location.xVal, Quests[curID].Location.yVal, ColorEnd))
        -- end
    end
end

function AZP.ZoneQuests.ZerrethMortis:OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        AZP.ZoneQuests.ZerrethMortis.Events:VariablesLoaded()
    elseif event == "QUEST_FINISHED" then
        C_Timer.NewTimer(5, function() print("QUEST_FINISHED Called!") AZP.ZoneQuests.ZerrethMortis.Events:QuestFinished() end)
    elseif event == "ADDON_LOADED" then
        local AddOnName = ...
        if AddOnName == "TomTom" then TomTomLoaded = true end
    end
end

function AZP.ZoneQuests.ZerrethMortis.Events:VariablesLoaded()
    C_Timer.NewTimer(5, function() AZP.ZoneQuests.ZerrethMortis:CreateUserFrame() AZP.ZoneQuests.ZerrethMortis:LoadLocation() end)
end

AZP.ZoneQuests.ZerrethMortis:OnLoadSelf()
