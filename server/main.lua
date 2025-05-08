if Config.CommandLib then
    print('^4Command registered with ox_lib.^7')
    lib.addCommand(Config.Command, {
        help = Config.CommandHelp,

    }, function (source, args, raw)
        local xPlayer = ESX.GetPlayerFromId(source)

        local insurances = MySQL.query.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
            xPlayer.getIdentifier()
        })

        if json.encode(insurances) == '[]' then
            local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
                xPlayer.getIdentifier()
            })
        end

        local insurances = MySQL.query.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
            xPlayer.getIdentifier()
        })

        TriggerClientEvent('ks_insurance:openSelfMenu', source, insurances)
    end)
else
    print('^4Command registered with native.^7')
    RegisterCommand(Config.Command, function(source, args, raw)
        local xPlayer = ESX.GetPlayerFromId(source)

        local insurances = MySQL.query.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
            xPlayer.getIdentifier()
        })

        if json.encode(insurances) == '[]' then
            local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
                xPlayer.getIdentifier()
            })
        end

        local insurances = MySQL.query.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
            xPlayer.getIdentifier()
        })

        TriggerClientEvent('ks_insurance:openSelfMenu', source, insurances)
    end)
end

function openSelfMenu(targetsource)
    local xPlayer = ESX.GetPlayerFromId(targetsource)

    local insurances = MySQL.query.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    if json.encode(insurances) == '[]' then
        local id = MySQL.insert.await('INSERT INTO `ks_insurance` (identifier, car, krank, haft, wohn, beruf, recht) VALUES (?, 0, 0, 0, 0, 0, 0)', {
            xPlayer.getIdentifier()
        })
    end

    local insurances = MySQL.query.await('SELECT `car`, `krank`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    TriggerClientEvent('ks_insurance:openSelfMenu', targetsource, insurances)
end