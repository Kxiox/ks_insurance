ESX = exports.es_extended:getSharedObject()

local lang = Config.Locale

-- Funktion zum Abziehen des Geldes
function deductMoneyFromPlayers()
    local players = ESX.GetPlayers()
    for i=1, #players, 1 do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer then
            local currentMoney = xPlayer.getMoney()
            if getAmountToDeduct(xPlayer) > 0 then
                if xPlayer.getAccount('bank').money >= getAmountToDeduct(xPlayer) then
                    xPlayer.removeAccountMoney('bank', getAmountToDeduct(xPlayer))
                    ServerNotify(players[i], string.format(Locales[lang]['removed_money'], getAmountToDeduct(xPlayer)), 'info', 5000)
                else
                    ServerNotify(players[i], string.format(Locales[lang]['cant_remove_money'], getAmountToDeduct(xPlayer)), 'error', 10000)
                end
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

    local vehicles = MySQL.query.await('SELECT * FROM `owned_vehicles` WHERE `owner` = ?', {
        xPlayer.getIdentifier()
    })

    local amountveh = 0

    for k, v in pairs(vehicles) do
        if v.insurance == 1 then amountveh = amountveh + Config.Vehicles.price end
    end

    if insurances[1] then
        local insurance = insurances[1]
        amount = (insurance.car * Config.Prices.car) + 
                 (insurance.krank * Config.Prices.krank) + 
                 (insurance.haft * Config.Prices.haft) + 
                 (insurance.wohn * Config.Prices.wohn) + 
                 (insurance.beruf * Config.Prices.beruf) + 
                 (insurance.recht * Config.Prices.recht) +
                 amountveh
    end

    return amount
end