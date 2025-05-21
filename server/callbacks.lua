ESX = exports.es_extended:getSharedObject()

lib.callback.register('ks_insurance:getInsurances', function ()
    local xPlayer = ESX.GetPlayerFromId(source)

    ::select::
    local insurances = MySQL.single.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if not insurances then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })

        CreateInsuranceList()
        
        goto select
    end

    return insurances
end)

lib.callback.register('ks_insurance:setInsurances', function (source, type, id)
    local xPlayer = ESX.GetPlayerFromId(source)

    if id ~= 'car' and id ~= 'krank' and id ~= 'haft' and id ~= 'wohn' and id ~= 'beruf' and id ~= 'recht' then
        return false
    end

    if type == 'btn_anmelden' then
        local query = string.format('UPDATE ks_insurance SET `%s` = 1 WHERE identifier = ?', id)
        local affectedRows = MySQL.update.await(query, {
            xPlayer.getIdentifier()
        })

        if affectedRows then return 1 end
    elseif type == 'btn_abmelden' then
        local query = string.format('UPDATE ks_insurance SET `%s` = 0 WHERE identifier = ?', id)
        local affectedRows = MySQL.update.await(query, {
            xPlayer.getIdentifier()
        })

        if affectedRows then return 0 end
    else
        if affectedRows then return nil end
    end
end)

lib.callback.register('ks_insurance:openMenuPlayer', function (source, insurances, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if Config.Vehicles.enabled then
        local response = MySQL.query.await('SELECT `plate`, `insurance` FROM `owned_vehicles` WHERE `owner` = ?', {
            xPlayer.getIdentifier()
        })

        TriggerClientEvent('ks_insurance:openMenuPlayer', target, insurances, response)
    else
        TriggerClientEvent('ks_insurance:openMenuPlayer', target, insurances)
    end

    return xTarget.getName()
end)

lib.callback.register('ks_insurance:getPlayerVehicles', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)

    local response = MySQL.query.await('SELECT `plate`, `insurance` FROM `owned_vehicles` WHERE `owner` = ?', {
        xPlayer.getIdentifier()
    })

    if response then
        for i = 1, #response do
            local row = response[i]
        end
    end

    return response
end)

lib.callback.register('ks_insurance:addVehicleInsurance', function (source, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    local affectedRows = MySQL.update.await('UPDATE owned_vehicles SET insurance = 1 WHERE plate = ?', {
        plate
    })

    if affectedRows then return true else return false end
end)

lib.callback.register('ks_insurance:removeVehicleInsurance', function (source, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    local affectedRows = MySQL.update.await('UPDATE owned_vehicles SET insurance = 0 WHERE plate = ?', {
        plate
    })

    if affectedRows then return true else return false end
end)