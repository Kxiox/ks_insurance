ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('ks_insurance:openSelfMenu')
AddEventHandler('ks_insurance:openSelfMenu', function (insurances)
    lib.registerContext({
        id = 'insurance_selfmenu',
        title = Config.Menu.title,
        options = {
          {
            title = 'Versicherungen ansehen',
            description = 'Sehe dir deine Versicherungen an.',
            icon = 'eye',
            onSelect = function ()
                lib.showContext('sub_insurance_selfmenu')
            end
          },
          {
            title = 'Versicherungen zeigen',
            description = 'Zeige dem nächsten Spieler deine Versicherungen.',
            icon = 'hand',
            onSelect = function ()
                local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

                if closestPlayer == -1 or closestPlayerDistance > 3.0 then
                    Notify('Kein Spieler in der Nähe.', 'error', 5000)
                else
                    lib.callback('ks_insurance:openMenuPlayer', false, function (targetname)
                        Notify('Du zeigst ' .. targetname .. ' deine Versicherungen.', 'success', 5000)
                    end, insurances, GetPlayerServerId(closestPlayer))    
                end

            end
          }
        }
    })

    lib.registerContext({
        id = 'sub_insurance_selfmenu',
        title = Config.Menu.title,
        menu = 'insurance_selfmenu',
        options = {
          {
            title = 'Fahrzeugversicherung',
            icon = getIcon(insurances[1].car),
            disabled = getDisabled(insurances[1].car)
          },
          {
            title = 'Krankenversicherung',
            icon = getIcon(insurances[1].krank),
            disabled = getDisabled(insurances[1].krank)
          },
          {
            title = 'Haftpflichtversicherung',
            icon = getIcon(insurances[1].haft),
            disabled = getDisabled(insurances[1].haft)
          },
          {
            title = 'Wohngebäudeversicherung',
            icon = getIcon(insurances[1].wohn),
            disabled = getDisabled(insurances[1].wohn)
          },
          {
            title = 'Berufsunfähigkeitsversicherung',
            icon = getIcon(insurances[1].beruf),
            disabled = getDisabled(insurances[1].beruf)
          },
          {
            title = 'Rechtsschutzversicherung',
            icon = getIcon(insurances[1].recht),
            disabled = getDisabled(insurances[1].recht)
          }
        }
    })

    lib.showContext('insurance_selfmenu')
end)

RegisterNetEvent('ks_insurance:openMenuPlayer')
AddEventHandler('ks_insurance:openMenuPlayer', function (insurances)
    lib.registerContext({
        id = 'insurance_menuplayer',
        title = Config.Menu.title,
        options = {
          {
            title = 'Fahrzeugversicherung',
            icon = getIcon(insurances[1].car),
            disabled = getDisabled(insurances[1].car)
          },
          {
            title = 'Krankenversicherung',
            icon = getIcon(insurances[1].krank),
            disabled = getDisabled(insurances[1].krank)
          },
          {
            title = 'Haftpflichtversicherung',
            icon = getIcon(insurances[1].haft),
            disabled = getDisabled(insurances[1].haft)
          },
          {
            title = 'Wohngebäudeversicherung',
            icon = getIcon(insurances[1].wohn),
            disabled = getDisabled(insurances[1].wohn)
          },
          {
            title = 'Berufsunfähigkeitsversicherung',
            icon = getIcon(insurances[1].beruf),
            disabled = getDisabled(insurances[1].beruf)
          },
          {
            title = 'Rechtsschutzversicherung',
            icon = getIcon(insurances[1].recht),
            disabled = getDisabled(insurances[1].recht)
          }
        }
    })

    lib.showContext('insurance_menuplayer')
end)

function getDisabled(nr)
    if nr == 0 then return true else return false end
end

function getIcon(nr)
    if nr == 0 then return 'xmark' else return 'check' end
end