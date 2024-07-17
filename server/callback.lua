ESX = exports.es_extended:getSharedObject()

lib.callback.register('ks_insurance:getInsurances', function ()
    local xPlayer = ESX.GetPlayerFromId(source)

    local insurances = MySQL.rawExecute.await('SELECT `kfz`, `health`, `haft`, `wohn`, `beruf`, `recht` FROM `ks_insurance` WHERE `identifier` = ?', {
        xPlayer.getIdentifier()
    })

    return insurances
end)