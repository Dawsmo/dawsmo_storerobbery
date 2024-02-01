lib.locale()
local StoresData = {}

RegisterNetEvent('esx:playerDropped', function(playerId, reason)
    for Store, xxx in pairs(StoresData) do
        if StoresData[Store] then
            for key, player in pairs(StoresData[Store].Players) do
                if playerId == player then
                    if StoresData[Store].Players[key] then
                        table.remove(StoresData[Store].Players, key)
                    end
                    if #StoresData[Store].Players <= 0 then
                        TriggerEvent("dawsmo_storerobbery:InitStoresData", Store, "Leave")
                    end
                    break
                end
            end
        end
    end
end)


local function CheckTimer(id)
    local timeDifference = os.difftime(os.time(), StoresData[id].Timer)
    local minutesPassed = math.floor(timeDifference / 60)
    local minutesToWait = Config.General.TimeBeforeReset - minutesPassed

    if minutesToWait <= 0 then
        return true, minutesToWait
    else
        return false, minutesToWait
    end
end

lib.callback.register("dawsmo_storerobbery:CheckTimer", function (source, id)
    local canRob, minutesToWait =  CheckTimer(id)
    if canRob then
        local ped = NetworkGetEntityFromNetworkId(StoresData[id].Ped)
        if DoesEntityExist(ped) then
            Entity(ped).state.robbing = "Clear"
            StoresData[id].Status = "Clear"
        end
    else
        return minutesToWait
    end
end)

RegisterNetEvent("dawsmo_storerobbery:InitStoresData", function (id, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if type == "Enter" then
        if StoresData[id] == nil then
            StoresData[id] = {Ped = 0, Players = {}, Missions = {}, Status = "Clear", Timer = 0}
            table.insert(StoresData[id].Players, source)
        elseif StoresData[id].Status == "Clear" then
            table.insert(StoresData[id].Players, source)
        elseif StoresData[id].Status == "Robbing" then
            TriggerClientEvent('ox_lib:notify', xPlayer.source, {
                title = locale("Server_Robbery_Title"),
                type = 'warning',
                position = "top",
                duration = 5000
            })
        else
            table.insert(StoresData[id].Players, source)
        end
    else
        for i, playerID in ipairs(StoresData[id].Players) do
            if playerID == source then
                if StoresData[id].Status == "Robbing" then
                    TriggerClientEvent("dawsmo_storerobbery:ClearRobbing", xPlayer.source)
                    table.remove(StoresData[id].Players, i)
                    break
                else
                    table.remove(StoresData[id].Players, i)
                    break
                end
            end
        end
        if #StoresData[id].Players <= 0 then
            local Ped = NetworkGetEntityFromNetworkId(StoresData[id].Ped)
            if DoesEntityExist(Ped) then
                DeleteEntity(Ped)
                StoresData[id].Ped = 0
            end
            if StoresData[id].Status == "Robbing" then
                StoresData[id].Missions = {}
                StoresData[id].Status = "Robbed"
                StoresData[id].Timer = os.time()
            end
        end
    end
end)

lib.callback.register("dawsmo_storerobbery:SpawnNPC", function (source, id)
    local canRob, timer = CheckTimer(id)
    if StoresData[id].Ped == 0 then
        local model = Config.Shopkeepers[Config.Stores[id].Type]
        local coords = vector3(Config.Stores[id].Coords) 
        local Heading = Config.Stores[id].Heading
        ESX.OneSync.SpawnPed(model,coords, Heading, function(NetId)
            Wait(250)
            local Ped = NetworkGetEntityFromNetworkId(NetId)
            if DoesEntityExist(Ped) then
                StoresData[id].Ped = NetId
                if canRob then
                    StoresData[id].Status = "Clear"
                    Entity(Ped).state.robbing = "Clear"
                else
                    Entity(Ped).state.robbing = "Robbed"
                end
                TriggerClientEvent("dawsmo_storerobbery:SpawnNPC", source, StoresData[id].Ped)
            else
                lib.print.error("Failed to spawn NPC for the store: " .. id)
            end
        end)
    else
        TriggerClientEvent("dawsmo_storerobbery:SpawnNPC", source, StoresData[id].Ped)
    end
end)

RegisterNetEvent("dawsmo_storerobbery:InitRobbing", function (id)
    local ReactionNpc = ""
    local Ped = NetworkGetEntityFromNetworkId(StoresData[id].Ped)
    local StoreState = StoresData[id].Status
    local canRob = false
    if StoreState == "Clear" then
        canRob = true
    end
    if canRob then
        if DoesEntityExist(Ped) then
            StoresData[id].Status = "Robbing"
            Entity(Ped).state.robbing = "Robbing"
            Entity(Ped).state.canBeForcedPin = true
            local DataMissions = {}
    
            for NameLoot, ValueLoots in pairs(Config.Stores[id].Loots) do
                local lootData = {}
                for _, lootInfo in ipairs(ValueLoots) do
                    local lootEntry = {robbed = false}
                    if NameLoot == "Safe" then
                        lootEntry.robbed = false
                        lootEntry.code = {math.random(0, 99), math.random(0, 99), math.random(0, 99)}
                        lootEntry.forced = false
                    end
                    table.insert(lootData, lootEntry)
                end
                DataMissions[NameLoot] = lootData
            end
    
            StoresData[id].Missions = DataMissions

            math.randomseed(os.time())

            local ChanceNpcSurrender = Config.General.ChanceNpc.Surrender
            
            local ChanceGlobal = math.random(0, 100)
            if ChanceGlobal <= ChanceNpcSurrender then
                ReactionNpc = "Surrender"
            else
                local ChanceNpcFight = Config.General.ChanceNpc.Fight
                local Chance = math.random(0, 100)
                if Chance <= ChanceNpcFight then
                    ReactionNpc = "Fight"
                else
                    ReactionNpc = "Run"
                end
            end
            
            for key, playerID in pairs(StoresData[id].Players) do
                local player = ESX.GetPlayerFromId(playerID)
                TriggerClientEvent("dawsmo_storerobbery:InitRobbing", player.source, DataMissions, ReactionNpc)
            end
        end
    end
end)

lib.callback.register("dawsmo_storerobbery:CheckRobLoot", function (source, storeID, type, id, typeCheck)
    if StoresData[storeID].Missions ~= nil then
        if typeCheck == "Check" then
            return StoresData[storeID].Missions[type][id].robbed
        else
            StoresData[storeID].Missions[type][id].robbed = true
            Wait(250)
            for key, playerID in pairs(StoresData[storeID].Players) do
                local player = ESX.GetPlayerFromId(playerID)
                if player then
                    TriggerClientEvent("dawsmo_storerobbery:ShowUI", player.source, StoresData[storeID].Missions, true)
                end
            end
        end
    end
end)

lib.callback.register("dawsmo_storerobbery:GetSafeCode", function (source, id)
    if StoresData[id].Missions then
        return StoresData[id].Missions.Safe[1].code
    end
end)

lib.callback.register("dawsmo_storerobbery:ForceSafeCode", function (source, id)
    if StoresData[id] ~= nil then
        local Ped = NetworkGetEntityFromNetworkId(StoresData[id].Ped)
        Entity(Ped).state.canBeForcedPin = false
        StoresData[id].Missions.Safe[1].forced = true
        for key, playerID in pairs(StoresData[id].Players) do
            local player = ESX.GetPlayerFromId(playerID)
            TriggerClientEvent("dawsmo_storerobbery:ShowUI", player.source, StoresData[id].Missions, true)
        end
        return true
    end
end)

RegisterNetEvent("dawsmo_storerobbery:Rewards", function (StoreID, type, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if StoresData[StoreID].Missions ~= nil then
        if type == "StoreShelves" then
            local storeType = Config.Stores[StoreID].Type
            for item, value in pairs(Config.RobData[type].Rewards[storeType]) do
                local randomAmount = math.random(value.min, value.max)
                if exports.ox_inventory:CanCarryItem(xPlayer.source, item, randomAmount) then
                    exports.ox_inventory:AddItem(xPlayer.source, item, randomAmount)
                    TriggerClientEvent('ox_lib:notify', xPlayer.source, {
                        title = (locale("Server_Reward_Title")):format(randomAmount, value.label),
                        type = 'success',
                        position = "top-right",
                        duration = 3500
                    })
                end
            end
        else
            for item, value in pairs(Config.RobData[type].Rewards) do
                local randomAmount = math.random(value.min, value.max)
                if exports.ox_inventory:CanCarryItem(xPlayer.source, item, randomAmount) then
                    exports.ox_inventory:AddItem(xPlayer.source, item, randomAmount)
                    TriggerClientEvent('ox_lib:notify', xPlayer.source, {
                        title = (locale("Server_Reward_Title")):format(randomAmount, value.label),
                        type = 'success',
                        position = "top-right",
                        duration = 3500
                    })
                end
            end
        end
    end
end)
