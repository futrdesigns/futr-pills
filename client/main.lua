local harvesting = false
local currentLocation = nil

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = cache.ped
        local pos = GetEntityCoords(ped)

        for _, location in pairs(Config.HarvestLocations) do
            local dist = #(pos - location.coords)

            if dist < 15.0 then
                sleep = 0
                DrawMarker(
                    location.marker.type,
                    location.coords.x, location.coords.y, location.coords.z - 1.0,
                    0.0, 0.0, 0.0, 0, 0, location.heading,
                    location.marker.size.x, location.marker.size.y, location.marker.size.z,
                    location.marker.color[1], location.marker.color[2], location.marker.color[3], location.marker.color[4],
                    false, true, 2, nil, nil, false
                )

                if dist < location.radius and not harvesting then
                    local itemLabel = location.item:gsub("^%l", string.upper):gsub("_", " ")
                    lib.showTextUI('[E] Harvest ' .. itemLabel)
                    
                    if IsControlJustReleased(0, 38) then
                        currentLocation = location
                        startHarvesting(location)
                    end
                elseif dist >= location.radius and not harvesting and currentLocation == location then
                    lib.hideTextUI()
                end
            end
        end
        Wait(sleep)
    end
end)

function startHarvesting(location)
    harvesting = true
    lib.hideTextUI()

    if lib.progressCircle({
        duration = location.duration,
        position = 'bottom',
        label = 'Harvesting ' .. location.item:gsub("_", " ") .. '...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = location.animation,
    }) then
        TriggerServerEvent('pill_system:giveItem', location.item, location.itemAmount)
        lib.notify({
            title = 'Success',
            description = 'You harvested ' .. location.itemAmount .. 'x ' .. location.item:gsub("_", " "),
            type = 'success'
        })
    else
        lib.notify({title = 'Cancelled', type = 'error'})
    end

    harvesting = false
    currentLocation = nil
end

RegisterNetEvent('pill_system:useItem', function(itemName)
    local itemConfig = Config.ItemEffects[itemName]
    if not itemConfig then
        if Config.Debug then
            print('No effect configured for item: ' .. itemName)
        end
        return
    end

    local ped = PlayerPedId()
    local playerId = PlayerId()

    local animation = Config.AnimationTypes[itemConfig.animationType]
    if animation then
        RequestAnimDict(animation.dict)
        local timeout = 100
        while not HasAnimDictLoaded(animation.dict) and timeout > 0 do 
            Wait(10)
            timeout = timeout - 1
        end
        
        if HasAnimDictLoaded(animation.dict) then
            TaskPlayAnim(ped, animation.dict, animation.clip, 3.0, -1, animation.duration, 49, 0, false, false, false)
            Wait(animation.duration)
            ClearPedTasks(ped)
        else
            if Config.Debug then
                print('Failed to load animation dict: ' .. animation.dict)
            end
        end
    end

    local effects = Config.EffectTypes[itemConfig.effectType]
    if effects then
        if effects.timecycle then
            SetTimecycleModifier(effects.timecycle)
        end
        
        if effects.runMultiplier then
            SetRunSprintMultiplierForPlayer(playerId, effects.runMultiplier)
        end
        
        if effects.swimMultiplier then
            SetSwimMultiplierForPlayer(playerId, effects.swimMultiplier)
        end
        
        if effects.staminaRestore then
            RestorePlayerStamina(playerId, effects.staminaRestore)
        end
        
        if effects.healthRestore then
            local currentHealth = GetEntityHealth(ped)
            local maxHealth = GetEntityMaxHealth(ped)
            local newHealth = math.min(currentHealth + effects.healthRestore, maxHealth)
            SetEntityHealth(ped, newHealth)
        end
        
        if effects.armorRestore then
            local currentArmor = GetPedArmour(ped)
            local newArmor = math.min(currentArmor + effects.armorRestore, 100)
            SetPedArmour(ped, newArmor)
        end

        if effects.duration then
            SetTimeout(effects.duration, function()
                ClearTimecycleModifier()
                if effects.runMultiplier then
                    SetRunSprintMultiplierForPlayer(playerId, 1.0)
                end
                if effects.swimMultiplier then
                    SetSwimMultiplierForPlayer(playerId, 1.0)
                end
                
                lib.notify({
                    title = itemConfig.notify.title,
                    description = 'The effects have worn off.',
                    type = 'inform'
                })
            end)
        end
    end

    lib.notify({
        title = itemConfig.notify.title,
        description = itemConfig.notify.description,
        type = itemConfig.notify.type
    })

    if Config.Debug then
        print('Applied effects for item: ' .. itemName)
        print('Effect Type: ' .. itemConfig.effectType)
        print('Animation Type: ' .. itemConfig.animationType)
    end
end)

if Config.Debug then
    RegisterCommand('testitem', function(source, args)
        if args[1] then
            TriggerEvent('pill_system:useItem', args[1])
        else
            print('Usage: /testitem <item_name>')
        end
    end)
end
