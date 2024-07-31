ESX = exports.es_extended:getSharedObject()

local lang = Config.Locale

if Config.MenuLib then
  print('^4Menu using with ox_lib')
  RegisterNetEvent('ks_insurance:openSelfMenu')
  AddEventHandler('ks_insurance:openSelfMenu', function (insurances)
      lib.registerContext({
          id = 'insurance_selfmenu',
          title = Config.Menu.title,
          options = {
            {
              title = Locales[lang]['menu_showself_title'],
              description = Locales[lang]['menu_showself_desc'],
              icon = 'eye',
              onSelect = function ()
                  lib.showContext('sub_insurance_selfmenu')
              end
            },
            {
              title = Locales[lang]['menu_show_title'],
              description = Locales[lang]['menu_show_desc'],
              icon = 'hand',
              onSelect = function ()
                  local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

                  if closestPlayer == -1 or closestPlayerDistance > 3.0 then
                      Notify(Locales[lang]['no_player'], 'error', 5000)
                  else
                      lib.callback('ks_insurance:openMenuPlayer', false, function (targetname)
                          Notify(string.format(Locales[lang]['show_player'], targetname), 'success', 5000)
                      end, insurances, GetPlayerServerId(closestPlayer))    
                  end

              end
            }
          }
      })

      local options = {}

      for k, v in pairs(Config.Insurances) do
        if v then
          if k == 'car' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].car), disabled = getDisabled(insurances[1].car)})
          end

          if k == 'krank' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].krank), disabled = getDisabled(insurances[1].krank)})
          end


          if k == 'haft' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].haft), disabled = getDisabled(insurances[1].haft)})
          end


          if k == 'wohn' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].wohn), disabled = getDisabled(insurances[1].wohn)})
          end


          if k == 'beruf' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].beruf), disabled = getDisabled(insurances[1].beruf)})
          end


          if k == 'recht' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].recht), disabled = getDisabled(insurances[1].recht)})
          end
        end
      end

      lib.registerContext({
          id = 'sub_insurance_selfmenu',
          title = Config.Menu.title,
          menu = 'insurance_selfmenu',
          options = options
      })

      lib.showContext('insurance_selfmenu')
  end)

  RegisterNetEvent('ks_insurance:openMenuPlayer')
  AddEventHandler('ks_insurance:openMenuPlayer', function (insurances)
      local options = {}

      for k, v in pairs(Config.Insurances) do
        if v then
          if k == 'car' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].car), disabled = getDisabled(insurances[1].car)})
          end

          if k == 'krank' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].krank), disabled = getDisabled(insurances[1].krank)})
          end


          if k == 'haft' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].haft), disabled = getDisabled(insurances[1].haft)})
          end


          if k == 'wohn' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].wohn), disabled = getDisabled(insurances[1].wohn)})
          end


          if k == 'beruf' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].beruf), disabled = getDisabled(insurances[1].beruf)})
          end


          if k == 'recht' then
            table.insert(options, {title = Locales[lang]['insurance_' .. k], icon = getIcon(insurances[1].recht), disabled = getDisabled(insurances[1].recht)})
          end
        end
      end
    
      lib.registerContext({
          id = 'insurance_menuplayer',
          title = Config.Menu.title,
          options = options
      })

      lib.showContext('insurance_menuplayer')
  end)

  function getDisabled(nr)
      if nr == 0 then return true else return false end
  end

  function getIcon(nr)
      if nr == 0 then return 'xmark' else return 'check' end
  end
else
  print('^4Menu using without ox_lib')
  RegisterNetEvent('ks_insurance:openSelfMenu')
  AddEventHandler('ks_insurance:openSelfMenu', function (insurances)
    local elements = {
        {label = Locales[lang]['menu_showself_title'], value = 'show_self'},
        {label = Locales[lang]['menu_show_title'], value = 'show'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'insurance_selfmenu', {
        title = Config.Menu.title,
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'show_self' then
            OpenSubMenu(insurances)
        elseif data.current.value == 'show' then
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

            if closestPlayer == -1 or closestPlayerDistance > 3.0 then
                Notify(Locales[lang]['no_player'], 'error', 5000)
            else
              lib.callback('ks_insurance:openMenuPlayer', false, function (targetname)
                Notify(string.format(Locales[lang]['show_player'], targetname), 'success', 5000)
            end, insurances, GetPlayerServerId(closestPlayer))    
          end
        end
    end, function(data, menu)
        menu.close()
    end)
    end)

    function OpenSubMenu(insurances)
      local elements = {}
  
      for k, v in pairs(Config.Insurances) do
          if v then
              if k == 'car' then
                  table.insert(elements, {label = getIcon(insurances[1].car) .. Locales[lang]['insurance_' .. k], value = 'car'})
              end
  
              if k == 'krank' then
                  table.insert(elements, {label = getIcon(insurances[1].krank) .. Locales[lang]['insurance_' .. k], value = 'krank'})
              end
  
              if k == 'haft' then
                  table.insert(elements, {label = getIcon(insurances[1].haft) .. Locales[lang]['insurance_' .. k], value = 'haft'})
              end
  
              if k == 'wohn' then
                  table.insert(elements, {label = getIcon(insurances[1].wohn) .. Locales[lang]['insurance_' .. k], value = 'wohn'})
              end
  
              if k == 'beruf' then
                  table.insert(elements, {label = getIcon(insurances[1].beruf) .. Locales[lang]['insurance_' .. k], value = 'beruf'})
              end
  
              if k == 'recht' then
                  table.insert(elements, {label = getIcon(insurances[1].recht) .. Locales[lang]['insurance_' .. k], value = 'recht'})
              end
          end
      end
  
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sub_insurance_selfmenu', {
          title = Config.Menu.title,
          align = Config.Menu.position,
          elements = elements
      }, function(data, menu)
          -- You can add additional logic here for submenu actions if needed
      end, function(data, menu)
          menu.close()
      end)
    end
    
    RegisterNetEvent('ks_insurance:openMenuPlayer')
    AddEventHandler('ks_insurance:openMenuPlayer', function (insurances)
    local elements = {}

    for k, v in pairs(Config.Insurances) do
        if v then
          if k == 'car' then
            table.insert(elements, {label = getIcon(insurances[1].car) .. Locales[lang]['insurance_' .. k], value = 'car'})
        end

        if k == 'krank' then
            table.insert(elements, {label = getIcon(insurances[1].krank) .. Locales[lang]['insurance_' .. k], value = 'krank'})
        end

        if k == 'haft' then
            table.insert(elements, {label = getIcon(insurances[1].haft) .. Locales[lang]['insurance_' .. k], value = 'haft'})
        end

        if k == 'wohn' then
            table.insert(elements, {label = getIcon(insurances[1].wohn) .. Locales[lang]['insurance_' .. k], value = 'wohn'})
        end

        if k == 'beruf' then
            table.insert(elements, {label = getIcon(insurances[1].beruf) .. Locales[lang]['insurance_' .. k], value = 'beruf'})
        end

        if k == 'recht' then
            table.insert(elements, {label = getIcon(insurances[1].recht) .. Locales[lang]['insurance_' .. k], value = 'recht'})
        end
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'insurance_menuplayer', {
        title = Config.Menu.title,
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        -- You can add additional logic here for player menu actions if needed
    end, function(data, menu)
        menu.close()
    end)
    end)
  
    function getIcon(nr)
        return nr == 0 and '❌' or '✅'
    end  
end