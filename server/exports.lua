exports('addInsurance', function (targetsource, insurance)
    local xPlayer = ESX.GetPlayerFromId(targetsource)

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if json.encode(insurances) == '[]' then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })
    end

    local affectedRows = MySQL.update.await('UPDATE ks_insurance SET ' .. insurance .. ' = 1 WHERE identifier = ?', {
        xPlayer.getIdentifier()
    })
end)

exports('removeInsurance', function (targetsource, insurance)
    local xPlayer = ESX.GetPlayerFromId(targetsource)

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if json.encode(insurances) == '[]' then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })
    end

    local affectedRows = MySQL.update.await('UPDATE ks_insurance SET ' .. insurance .. ' = 0 WHERE identifier = ?', {
        xPlayer.getIdentifier()
    })
end)

exports('getAllInsurance', function (targetsource)
    local xPlayer = ESX.GetPlayerFromId(targetsource)

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if json.encode(insurances) == '[]' then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })
    end

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    return insurances[1]
end)

exports('getInsuranceType', function (targetsource, type)
    local xPlayer = ESX.GetPlayerFromId(targetsource)

    local insurances = MySQL.rawExecute.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if json.encode(insurances) == '[]' then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })
    end

    local insurances = MySQL.rawExecute.await('SELECT `' .. type .. '` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    return insurances[1]
end)

exports('openSelfMenu', function (targetsource)
    openSelfMenu(targetsource)
end)

exports('addVehicle', function (plate)
    local affectedRows = MySQL.update.await('UPDATE owned_vehicles SET insurance = 1 WHERE plate = ?', {
        plate
    })
end)

exports('removeVehicle', function (plate)
    local affectedRows = MySQL.update.await('UPDATE owned_vehicles SET insurance = 0 WHERE plate = ?', {
        plate
    })
end)
