local function chatConfig()
    for i = 1, NUM_CHAT_WINDOWS do
        if (i ~= 2) then
            local f = _G["ChatFrame" .. i]
            local am = f.AddMessage
            f.AddMessage = function(frame, text, ...)
                return am(frame, text:gsub("|h%[(%d+)%. 大脚世界频道%]|h", "|h%[%1%. 世%]|h"), ...)
            end
        end
    end
end

local function arenaConfig()
    local U = UnitIsUnit
    hooksecurefunc(
        "CompactUnitFrame_UpdateName",
        function(F)
            if IsActiveBattlefieldArena() and F.unit:find("nameplate") then
                for i = 1, 5 do
                    if U(F.unit, "arena" .. i) then
                        F.name:SetText(i)
                        F.name:SetTextColor(1, 1, 0)
                        break
                    end
                end
            end
        end
    )
end

local frame = CreateFrame("FRAME", "defaultcvar")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
local function eventHandler(self, event, ...)
    chatConfig()
    arenaConfig()
end
frame:SetScript("OnEvent", eventHandler)
