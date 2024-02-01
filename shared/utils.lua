function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, true, true)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end

function TransformQuestData(data)
    local transformedData = {}

    for questName, questDetails in pairs(data) do
        local maxToRob = 0
        local currentRobbed = 0

        for _, quest in pairs(questDetails) do
            maxToRob = maxToRob + 1
            if quest.robbed then
                currentRobbed = currentRobbed + 1
            end
        end

        if questName == "Safe" then
            local safeData = {
                maxToRob = maxToRob,
                currentRobbed = currentRobbed,
            }

            if #questDetails > 0 then
                local firstQuest = questDetails[1]
                safeData.forced = firstQuest.forced
                safeData.code = firstQuest.code
            end

            transformedData[questName] = safeData
        else
            transformedData[questName] = {
                maxToRob = maxToRob,
                currentRobbed = currentRobbed,
            }
        end
    end
    return transformedData
end


function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function CheckCopsOnline()
    local copsOnline = 0
    for key, value in pairs(Config.General.PoliceJobsName) do
        if GlobalState[value] then
            copsOnline += GlobalState[value]
        end
    end
    if copsOnline > 0 then
        return true
    else
        return false
    end
end