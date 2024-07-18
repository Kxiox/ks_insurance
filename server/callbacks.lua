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