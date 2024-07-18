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

exports('openSelfMenu', function (targetsource)
    openSelfMenu(targetsource)
end)