ESX = exports.es_extended:getSharedObject()

lib.callback.register('ks_insurance:getInsurances', function ()
    local xPlayer = ESX.GetPlayerFromId(source)

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if json.encode(insurances) == '[]' then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })

        CreateInsuranceList()
    end

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    return insurances
end)

lib.callback.register('ks_insurance:setInsurances', function (source, type, id)
    local xPlayer = ESX.GetPlayerFromId(source)

    if type == 'btn_anmelden' then
        local affectedRows = MySQL.update.await('UPDATE ks_insurance SET ' .. id .. ' = 1 WHERE identifier = ?', {
            xPlayer.getIdentifier()
        })

        if affectedRows then return 1 end
    elseif type == 'btn_abmelden' then
        local affectedRows = MySQL.update.await('UPDATE ks_insurance SET ' .. id .. ' = 0 WHERE identifier = ?', {
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
        local response = MySQL.query.await('SELECT * FROM `owned_vehicles` WHERE `owner` = ?', {
            xPlayer.getIdentifier()
        })

        TriggerClientEvent('ks_insurance:openMenuPlayer', target, insurances, response)
        return xTarget.getName()
    else
        TriggerClientEvent('ks_insurance:openMenuPlayer', target, insurances)
        return xTarget.getName()
    end
end)

lib.callback.register('ks_insurance:getPlayerVehicles', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)

    local response = MySQL.query.await('SELECT * FROM `owned_vehicles` WHERE `owner` = ?', {
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