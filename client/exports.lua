ESX = exports['es_extended']:getSharedObject()

local lang = Config.Locale

exports('showClosestPlayer', function ()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestPlayerDistance > 3.0 then
        Notify(Locales[lang]['no_player'], 'error', 5000)
    else
        lib.callback('ks_insurance:openMenuPlayer', false, function (targetname)
            Notify(string.format(Locales[lang]['show_player'], targetname), 'success', 5000)
        end, insurances, GetPlayerServerId(closestPlayer))    
    end
end)