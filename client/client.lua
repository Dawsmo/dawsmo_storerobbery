lib.locale()
local currentShopKeeper = nil
local ui = false
local StoreID = 0
local Robbing = false
local zoneRobbing = {}
local markers = {}
local safeObject = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName()  then
        CreateStores()
    end
end)

RegisterNetEvent("dawsmo_storerobbery:ShowUI", function (RobData, Update)
    local transformedData = TransformQuestData(RobData)
    if Update then
        SendNUIMessage({
            showUI = true,
            update = Update,
            quests = transformedData,
        })
        SetNuiFocus(false, false)
    else
        ui = not ui
        if ui then
            SendNUIMessage({
                showUI = true,
                update = Update,
                quests = transformedData,
            })
            SetNuiFocus(false, false)
        end
    end
end)

RegisterNUICallback('close', function(data, cb)
    ui = false
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNetEvent("dawsmo_storerobbery:ClearRobbing", function ()
    ui = false
    currentShopKeeper = nil
    StoreID = 0
    Robbing = false
    SendNUIMessage({
        showUI = false,
        update = false,
        quests = {},
    })
    SetNuiFocus(false, false)
    lib.notify({
        title = locale("End_Robbery_Title"),
        description = locale("End_Robbery_Desc"),
        type = 'inform',
        position = "center-right",
        duration = 5000
    })
    for key, zone in pairs(zoneRobbing) do
        zone:remove()
    end
    markers = {}
    zoneRobbing = {}
    if DoesEntityExist(safeObject) then
        DeleteEntity(safeObject)
    end
end)

function CreateStores()
    for storeId, value in pairs(Config.Stores) do
        local storePoint = lib.points.new({
            coords = value.Coords,
            distance = 16,
            storeId = storeId
        })
    
        function storePoint:onEnter()
            StoreID = self.storeId
            TriggerServerEvent("dawsmo_storerobbery:InitStoresData", self.storeId, "Enter")
            lib.callback.await("dawsmo_storerobbery:SpawnNPC", false, self.storeId)
        end
    
        function storePoint:onExit()
            StoreID = 0
            TriggerServerEvent("dawsmo_storerobbery:InitStoresData", self.storeId, "Leave")
        end
    
        function storePoint:nearby()
            if self.currentDistance < 6 and IsPedArmed(PlayerPedId(), 7) and isNotPolice() then
                Wait(500)
                if IsPlayerFreeAiming(PlayerId()) or GetPlayerTargetEntity(PlayerId()) and HasEntityClearLosToEntityInFront(PlayerPedId(), currentShopKeeper, 19) then
                    if DoesEntityExist(currentShopKeeper) then
                        if CheckCopsOnline() then
                            if Entity(currentShopKeeper).state.robbing == "Clear" then
                                TriggerServerEvent("dawsmo_storerobbery:InitRobbing", self.storeId)
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 30.0, 'burglaralarm', 0.1)
                                exports['ps-dispatch-esx']:StoreRobbery(0)
                            elseif Entity(currentShopKeeper).state.robbing == "Robbed" then
                                local minutesToWait = lib.callback.await("dawsmo_storerobbery:CheckTimer", false, self.storeId)
                                lib.notify({
                                    title = locale("Wait_Title"),
                                    description = (locale("Wait_Desc")):format(minutesToWait),
                                    type = 'inform',
                                    position = "top",
                                    duration = 3000
                                })
                                Wait(2500)
                            end
                        else
                            lib.notify({
                                title = locale("Police_Title"),
                                type = 'inform',
                                position = "top",
                                duration = 3000
                            })
                            Wait(2500)
                        end
                    end
                end
            end
        end
    end
end

function CreateMission()
    if StoreID == 0 then
        lib.print.error("CreateMission: Store ID = 0")
        return
    end

    if Config.Stores[StoreID].needPropSafe then
        local model = 1089807209 -- Model can be either a string or a hash -1189.8787, -770.6376, 17.3261, 218.3645
        local coords = Config.Stores[StoreID].PropCoord.Coords-- Coords Can either be vector or a table (such as {x = 0, y = 0, z = 0})
        local Heading = Config.Stores[StoreID].PropCoord.Head + 180 -- Sets the Rotation/Heading the ped spawns at, can be any number
        safeObject = CreateObject(model, coords, false, false, false, false, false)
        Wait(500)
        SetEntityRotation(safeObject, 0, 0, Heading)
    end

    for NameLoots, ValueLoots in pairs(Config.Stores[StoreID].Loots) do
        markers[NameLoots] = markers[NameLoots] or {}
        for key, value in pairs(ValueLoots) do

            function onEnter(self)
                lib.showTextUI(Config.RobData[self.type].Message, {position = "top-center",})
            end
             
            function onExit(self)
                lib.hideTextUI()
            end

            function inside(self)
                if IsControlJustReleased(0, 38) then
                    local Robbed = lib.callback.await("dawsmo_storerobbery:CheckRobLoot", false, StoreID, self.type, self.lootId, "Check")
                    if Robbed then
                        self:remove()
                        lib.hideTextUI()
                        table.remove(markers[self.type], self.lootId)
                        lib.notify({
                            title = locale("Already_Robbed_Title"),
                            type = 'inform',
                            position = "top",
                            duration = 3500
                        })
                    else
                        if self.type == "CashRegister" then
                            if IsPedArmed(PlayerPedId(), 7) then
                                RobRegister(self.lootId, self)
                            else
                                lib.notify({
                                    title = locale("Need_Weapon_Title"),
                                    type = 'warning',
                                    position = "top-right",
                                    duration = 5000
                                })
                            end
                        elseif self.type == "StoreShelves" then
                            RobShelves(self.lootId, self)
                        elseif self.type == "Safe" then
                            RobSafe(self.lootId, self)
                        end
                    end
                end
            end

            local sphere = lib.zones.sphere({
                coords = value.Coords,
                radius = 0.5,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit,
                type = NameLoots,
                lootId = key
            })
            table.insert(zoneRobbing, sphere)
            markers[NameLoots][key] = value.Coords
        end
    end
end



RegisterNetEvent("dawsmo_storerobbery:SpawnNPC", function (entity)
    currentShopKeeper = NetworkGetEntityFromNetworkId(entity)
    if DoesEntityExist(currentShopKeeper) then
        SetEntityAsMissionEntity(currentShopKeeper, true, true)
        SetPedHearingRange(currentShopKeeper, 0.0)
        SetPedSeeingRange(currentShopKeeper, 0.0)
        SetPedAlertness(currentShopKeeper, 0.0)
        SetPedFleeAttributes(currentShopKeeper, 0, 0)
        SetBlockingOfNonTemporaryEvents(currentShopKeeper, true)
        SetPedCombatAttributes(currentShopKeeper, 46, true)
        SetPedFleeAttributes(currentShopKeeper, 0, 0)
    else
        lib.print.error("SpawnNPC: Entity doesn't exist")
    end
end)

RegisterNetEvent("dawsmo_storerobbery:InitRobbing", function (RobData, Reaction)
    Citizen.CreateThread(function ()
        CreateMission()
        TriggerEvent("dawsmo_storerobbery:ShowUI", RobData, false)
        lib.requestAnimDict('missheist_agency2ahands_up')
        TaskPlayAnim(currentShopKeeper, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)
        Wait(1500)
        if Reaction == "Surrender" then
            TaskGoStraightToCoord(currentShopKeeper, Config.Stores[StoreID].PositionNPC.Coords, 2.0, -1, Config.Stores[StoreID].PositionNPC.Heading, 0.0)
            Wait(5000)
            lib.requestAnimDict('missheist_agency2ahands_up')
            TaskPlayAnim(currentShopKeeper, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)
            if #RobData["Safe"] > 0 then
                CreateForcePinZone()
            end
        elseif Reaction == "Fight" then
            ClearPedTasksImmediately(currentShopKeeper)
            GiveWeaponToPed(currentShopKeeper, GetHashKey("WEAPON_PISTOL"), 255, false, true)
            TaskCombatPed(currentShopKeeper ,PlayerPedId(), 0, 16)
            SetPedCombatAttributes(currentShopKeeper, false)
            SetPedFleeAttributes(currentShopKeeper, 0, false)
            SetPedCombatAttributes(currentShopKeeper, 16, true)
            SetPedCombatAttributes(currentShopKeeper, 46, true)
            SetPedCombatAttributes(currentShopKeeper, 26, true)
            SetPedSeeingRange(currentShopKeeper, 75.0)
            SetPedHearingRange(currentShopKeeper, 50.0)
            SetPedEnableWeaponBlocking(currentShopKeeper, true)
        else
            TaskSmartFleePed(currentShopKeeper, PlayerPedId(), 100.0, -1, false, false)
        end
        Robbing = true
        ShowMarkers()
    end)
end)

function RobRegister(id, zone)
    lib.hideTextUI()
    lib.callback.await("dawsmo_storerobbery:CheckRobLoot", false, StoreID, "CashRegister", id, "Set")
    if lib.progressBar({
        duration = 3500,
        label = Config.RobData["CashRegister"].BreakRegister.Message,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            sprint = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = "melee@large_wpn@streamed_core",
            clip = "ground_attack_on_spot",
        },
    }) then 
        local cashRegister = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey('prop_till_01'))
        if DoesEntityExist(cashRegister) then
            CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
        end
        if lib.progressBar({
            duration = 11500,
            label = Config.RobData["CashRegister"].RobRegister.Message,
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true,
                sprint = true,
                combat = true,
                mouse = false
            },
            anim = {
                dict = "oddjobs@shop_robbery@rob_till",
                clip = "loop"
            },
        }) 
        then 
            Wait(250)
            zone:remove()
            Wait(250)
            table.remove(markers["CashRegister"], id)
            PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
            TriggerServerEvent("dawsmo_storerobbery:Rewards", StoreID, "CashRegister", id)
        else 
            lib.print.warn('When trying to earn the money')
        end
    else 
        lib.print.warn('When trying to break the register')
    end
end

function RobShelves(id, zone)
    lib.hideTextUI()
    lib.callback.await("dawsmo_storerobbery:CheckRobLoot", false, StoreID, "StoreShelves", id, "Set")

    if lib.progressBar({
        duration = Config.RobData["StoreShelves"].TimeForRob,
        label = Config.RobData["StoreShelves"].Description,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            sprint = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = "anim@scripted@heist@ig1_table_grab@gold@male@",
            clip = "grab"
        },
    }) 
    then
        Wait(250)
        zone:remove()
        Wait(250)
        table.remove(markers["StoreShelves"], id)
        TriggerServerEvent("dawsmo_storerobbery:Rewards", StoreID, "StoreShelves", id)
    else
        lib.print.warn('When trying to earn the money')
    end
end

function RobSafe(id, zone)
    local ItemForceSafe = false
    local ItemForcePin = false
    if exports.ox_inventory:Search("count", Config.RobData["Safe"].ForceSafe.Item) >= 1 then
        ItemForceSafe = true
    end
    if exports.ox_inventory:Search("count", Config.RobData["Safe"].ForcePin.Item) >= 1 then
        ItemForcePin = true
    end

    lib.registerContext({
        id = 'dawsmo_storerobbery:Safe',
        title = locale("Menu_Safe_Title"),
        options = {
          {
            title = locale("Menu_Safe_Option_Force_Title"),
            description = locale("Menu_Safe_Option_Force_Desc"),
            icon = 'explosion',
            disabled = not ItemForceSafe,
            onSelect = function()
                lib.hideTextUI()
                lib.callback.await("dawsmo_storerobbery:CheckRobLoot", false, StoreID, "Safe", id, "Set")
                if lib.progressBar({
                    duration = Config.RobData["Safe"].ForceSafe.TimeForForce,
                    label = Config.RobData["Safe"].ForceSafe.Message,
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        car = true,
                        move = true,
                        sprint = true,
                        combat = true,
                        mouse = false
                    },
                    anim = {
                        scenario = "WORLD_HUMAN_WELDING",
                    },
                    prop = {
                        model = "prop_weld_torch",
                        pos = vec3(0.04, -0.06, 0.08),
                        rot = vec3(0.0, 270.0, -1.5)
                    },
                }) 
                then
                    GrabMoneySafe(id, zone)
                else
                    lib.print.warn('When trying to earn the money')
                end
            end,
          },
          {
            title = locale("Menu_Safe_Option_ForcePin_Title"),
            description = locale("Menu_Safe_Option_ForcePin_Desc"),
            icon = 'vault',
            disabled = not ItemForcePin,
            onSelect = function()
                OpenSafePin(true, id, zone)
            end,
          },
          {
            title = locale("Menu_Safe_Option_EnterPin_Title"),
            description = locale("Menu_Safe_Option_EnterPin_Desc"),
            icon = 'key',
            onSelect = function()
                OpenSafePin(false, id, zone)
            end,
          },
        }
    })
    lib.showContext('dawsmo_storerobbery:Safe')
end

function OpenSafePin(Forcing, Id, Zone)
    local Open = false
    local code = lib.callback.await("dawsmo_storerobbery:GetSafeCode", false, StoreID)
    if Forcing then
        lib.showTextUI('**[Q]** pour pivoter à gauche  \n**[D]** pour pivoter à droite  \n**[F]** Pour valider  \n**[X]** Pour arrêter le crochetage', Config.RobData["Safe"].SafeTextUI)
        Open = exports["pd-safe"]:createSafe(code)
    else
        local input = lib.inputDialog('Code du coffre', {
            {type = 'number', label = 'Code #1', icon = 'hashtag', required = true},
            {type = 'number', label = 'Code #2', icon = 'hashtag', required = true},
            {type = 'number', label = 'Code #3', icon = 'hashtag', required = true},
          })
        if input[1] == code[1] and input[2] == code[2] and input[3] == code[3] then
            Open = true
        end
    end
    if Open then
        lib.callback.await("dawsmo_storerobbery:CheckRobLoot", false, StoreID, "Safe", Id, "Set")
        GrabMoneySafe(id, Zone)
    end
end

function GrabMoneySafe(id, zone)
    lib.hideTextUI()
    if lib.progressBar({
        duration = Config.RobData["Safe"].TimeForGrabMoney,
        label = Config.RobData["Safe"].Description,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            sprint = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = "anim@scripted@heist@ig1_table_grab@gold@male@",
            clip = "grab"
        },
    }) 
    then
        Wait(250)
        zone:remove()
        Wait(250)
        table.remove(markers["Safe"], id)
        TriggerServerEvent("dawsmo_storerobbery:Rewards", StoreID, "Safe", id)
    else
        lib.print.warn('When trying to earn the money')
    end
end

function CreateForcePinZone()
    exports.ox_target:removeGlobalPed("dawsmo_forcepin")
    exports.ox_target:addGlobalPed({
        {
            label = locale("NPC_ForcePin_Title"),
            name = "dawsmo_forcepin",
            icon = "fa-solid fa-comment",
            iconColor = "#d90000",
            distance = 1.5,
            canInteract = function (entity, distance, coords, name, bone)
                if Entity(entity).state.canBeForcedPin == true and not IsPedDeadOrDying(entity) then
                    return true
                end
            end,
            onSelect = function (data)
                lib.notify({
                    title = locale("NPC_ForcePin_Inform"),
                    type = 'inform',
                    position = "top",
                    duration = 5000
                })

                local forceNPC = lib.points.new({
                    coords = GetEntityCoords(currentShopKeeper),
                    distance = 8,
                })

                function forceNPC:nearby()
                    if self.currentDistance < 3.0 and IsPedArmed(PlayerPedId(), 7) and Entity(data.entity).state.canBeForcedPin then
                        Wait(150)
                        if GetPlayerTargetEntity(PlayerId()) or IsPlayerFreeAiming(PlayerId()) then
                            if HasEntityClearLosToEntityInFront(PlayerPedId(), currentShopKeeper, 19) then
                                local scared = 0
                                while scared < 100 and not IsPedDeadOrDying(currentShopKeeper) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(currentShopKeeper), true) <= 3.0 do
                                    local sleep = 1000
                                    local bool, ammoAmount = GetAmmoInClip(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()))
                                    SetEntityAnimSpeed(currentShopKeeper, "missheist_agency2ahands_up", "handsup_anxious", 1.0)
                                    if IsPlayerFreeAiming(PlayerId()) then
                                        sleep = 300
                                        SetEntityAnimSpeed(currentShopKeeper, "missheist_agency2ahands_up", "handsup_anxious", 1.6)
                                    end                                    
                                    if IsPedArmed(PlayerPedId(), 1) and IsControlPressed(0, 25) then
                                        sleep = 500
                                        SetEntityAnimSpeed(currentShopKeeper, "missheist_agency2ahands_up", "handsup_anxious", 1.3)
                                    end
                                    if IsPedArmed(PlayerPedId(), 4) and ammoAmount > 0 and IsControlPressed(0, 24) then
                                        sleep = 50
                                        SetEntityAnimSpeed(currentShopKeeper, "missheist_agency2ahands_up", "handsup_anxious", 1.8)
                                    end
                                    
                                    sleep = GetGameTimer() + sleep
                                    while sleep >= GetGameTimer() and not IsPedDeadOrDying(currentShopKeeper) do
                                        Wait(0)
                                        DrawRect(0.5, 0.5, 0.2, 0.03, 75, 75, 75, 200)
                                        local draw = scared/500
                                        DrawRect(0.5, 0.5, draw, 0.03, 0, 221, 255, 200)
                                        if scared <= 35 then
                                            DrawText3D(GetOffsetFromEntityInWorldCoords(currentShopKeeper, 0.0, 0.0, 1.0), locale("NPC_ForcePin_Text01"))
                                        elseif scared <= 60 then
                                            DrawText3D(GetOffsetFromEntityInWorldCoords(currentShopKeeper, 0.0, 0.0, 1.0), locale("NPC_ForcePin_Text02"))
                                        elseif scared <= 75 then
                                            DrawText3D(GetOffsetFromEntityInWorldCoords(currentShopKeeper, 0.0, 0.0, 1.0), locale("NPC_ForcePin_Text03"))
                                        elseif scared <= 90 then
                                            DrawText3D(GetOffsetFromEntityInWorldCoords(currentShopKeeper, 0.0, 0.0, 1.0), locale("NPC_ForcePin_Text04"))
                                        elseif scared <= 100 then
                                            DrawText3D(GetOffsetFromEntityInWorldCoords(currentShopKeeper, 0.0, 0.0, 1.0), locale("NPC_ForcePin_Text05"))
                                        end
                                    end
                                    scared = scared + 1
                                end
                                Wait(500)
                                if not IsPedDeadOrDying(currentShopKeeper) and scared >= 100 then
                                    lib.callback.await("dawsmo_storerobbery:ForceSafeCode", false, StoreID)
                                end
                                Wait(500)
                            end
                        end
                    end
                end
            end
        },
    })
end

function isNotPolice()
    local isAutorised = true
    for key, value in pairs(Config.General.PoliceJobsName) do
        if ESX.PlayerData.job.name == value then
            isAutorised = false
            break
        end
    end
    return isAutorised
end

function ShowMarkers()
    while Robbing do
        Wait(0)
        for NameLoots, Value in pairs(markers) do
            for key, value in pairs(Value) do
                DrawMarker(1, value.x, value.y, value.z - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.25, 255, 255, 255, 100, false, true, 2, false, false, false, false)
            end
        end
    end
end