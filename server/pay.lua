ESX = exports.es_extended:getSharedObject()

-- Funktion zum Abziehen des Geldes
function deductMoneyFromPlayers()
    print(21)
    local players = ESX.GetPlayers()
    for i=1, #players, 1 do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer then
            local currentMoney = xPlayer.getMoney()
            if xPlayer.getAccount('bank').money >= getAmountToDeduct(xPlayer) then
                xPlayer.removeAccountMoney('bank', getAmountToDeduct(xPlayer))
                ServerNotify(players[i], 'Dir wurden ' .. getAmountToDeduct(xPlayer) .. '€ vom Konto abgebucht.', 'info', 5000)
            else
                ServerNotify(players[i], 'Du hast nicht genügend Geld auf dem Konto, um deine Versicherungen zu zahlen. (' .. getAmountToDeduct(xPlayer) .. '€)', 'error', 10000)
            end
        end
    end
    -- Timeout erneut setzen
    ESX.SetTimeout(Config.DeductionInterval, deductMoneyFromPlayers)
end

-- Initialen Timeout setzen
ESX.SetTimeout(Config.DeductionInterval, deductMoneyFromPlayers)

function getAmountToDeduct(xPlayer)
    local amount = 0

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

    if insurances[1] then
        local insurance = insurances[1]
        amount = (insurance.car * Config.Prices.car) + 
                 (insurance.krank * Config.Prices.krank) + 
                 (insurance.haft * Config.Prices.haft) + 
                 (insurance.wohn * Config.Prices.wohn) + 
                 (insurance.beruf * Config.Prices.beruf) + 
                 (insurance.recht * Config.Prices.recht)
    end

    return amount
end
