RegisterNetEvent('pill_system:giveItem', function(itemName, amount)
    local src = source
    if exports.ox_inventory:AddItem(src, itemName, amount) then
        if Config.Debug then
            print('Gave ' .. amount .. 'x ' .. itemName .. ' to player ' .. src)
        end
    else
        print('Failed to give item to player ' .. src)
    end
end)

exports('useItem', function(event, item, inventory, slot, data)
    local src = inventory.id
    TriggerClientEvent('pill_system:useItem', src, item.name)
end)
