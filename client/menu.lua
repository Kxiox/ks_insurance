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
      local options2 = {}

      local function VehicleMenu()
        local vehicles = lib.callback.await('ks_insurance:getPlayerVehicles')

        for k, v in pairs(vehicles) do
            table.insert(options2, {
                title = v.plate,
                icon = v.insurance == 1 and 'check' or 'x',
                iconColor = v.insurance == 1 and 'green' or 'red',
            })
        end

        lib.registerContext({
            id = 'ks_insurance_vehicle_menu2',
            title = Locales[lang]['vehicle_menu_title'],
            options = options2
        })

        lib.showContext('ks_insurance_vehicle_menu2')
      end

      if Config.Vehicles.enabled then
        table.insert(options, {title = Locales[lang]['insurance_cars'], icon = 'bars', onSelect = function ()
          VehicleMenu()
        end})
      end

      for k, v in pairs(Config.Insurances) do
        if v then

          if k == 'car' and not Config.Vehicles.enabled then
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
  AddEventHandler('ks_insurance:openMenuPlayer', function (insurances, vehicles)
    local options = {}
    local options2 = {}

    local function VehicleMenu()

      for k, v in pairs(vehicles) do
          table.insert(options2, {
              title = v.plate,
              icon = v.insurance == 1 and 'check' or 'x',
              iconColor = v.insurance == 1 and 'green' or 'red',
          })
      end

      lib.registerContext({
          id = 'ks_insurance_vehicle_menu2',
          title = Locales[lang]['vehicle_menu_title'],
          options = options2
      })

      lib.showContext('ks_insurance_vehicle_menu2')
    end

    if Config.Vehicles.enabled then
      table.insert(options, {title = Locales[lang]['insurance_cars'], icon = 'bars', onSelect = function ()
        VehicleMenu()
      end})
    end

    for k, v in pairs(Config.Insurances) do
      if v then

        if k == 'car' and not Config.Vehicles.enabled then
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

  RegisterNetEvent('ks_insurance:openMainMenu')
  AddEventHandler('ks_insurance:openMainMenu', function (insurances)
    lib.registerContext({
      id = 'ks_insurances_main_menu',
      title = Locales[lang]['main_menu_title'],
      options = {
          {
              title = Locales[lang]['main_menu_manage_title'],
              icon = 'bars-progress',
              onSelect = function ()
                  SendNUIMessage({
                      type = 'open',
                      color = Config.Color,
                      background = Config.Background,
                      insurances = insurances,
                      prices = Config.Prices,
                      enabled_insurances = Config.Insurances
                  })
  
                  SetNuiFocus(true, true)
              end
          },
          {
              title = Locales[lang]['main_menu_vehicles_title'],
              icon = 'car',
              onSelect = function ()
                  local function reloadVehicleMenu()
                      local vehicles = lib.callback.await('ks_insurance:getPlayerVehicles')
                      local options = {{title = string.format(Locales[lang]['price_per_vehicle'], Config.Vehicles.price)}}
  
                      for k, v in pairs(vehicles) do
                          table.insert(options, {
                              title = v.plate,
                              description = Locales[lang]['vehicle_menu_description'],
                              icon = v.insurance == 1 and 'check' or 'x',
                              iconColor = v.insurance == 1 and 'green' or 'red',
                              onSelect = function ()
                                  if v.insurance == 0 then
                                      local success = lib.callback.await('ks_insurance:addVehicleInsurance', false, v.plate)
  
                                      if success then
                                          Notify(string.format(Locales[lang]['vehicle_added'], v.plate), 'success', 5000)
                                      else
                                          Notify(Locales[lang]['vehicle_error'], 'error', 5000)
                                      end
  
                                      reloadVehicleMenu()
                                  elseif v.insurance == 1 then
                                      local success = lib.callback.await('ks_insurance:removeVehicleInsurance', false, v.plate)
  
                                      if success then
                                          Notify(string.format(Locales[lang]['vehicle_removed'], v.plate), 'success', 5000)
                                      else
                                          Notify(Locales[lang]['vehicle_error'], 'error', 5000)
                                      end
  
                                      reloadVehicleMenu()
                                  end
                              end
                          })
                      end
  
                      lib.registerContext({
                          id = 'ks_insurance_vehicle_menu',
                          title = Locales[lang]['vehicle_menu_title'],
                          options = options
                      })
  
                      lib.showContext('ks_insurance_vehicle_menu')
                  end
  
                  reloadVehicleMenu()
              end
          }
      }
    })  

    lib.showContext('ks_insurances_main_menu')
  end)
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
      AddEventHandler('ks_insurance:openMenuPlayer', function (insurances, vehicles)
          local elements = {}
          local vehicleElements = {}
      
          -- Funktion zum Öffnen des Fahrzeugversicherungsmenüs
          local function VehicleMenu()
              for k, v in pairs(vehicles) do
                  table.insert(vehicleElements, {
                      label = (v.insurance == 1 and '✅' or '❌') .. ' ' .. v.plate, -- Emoji für Versicherungsstatus
                      value = v.plate
                  })
              end
      
              -- Öffne das Fahrzeugversicherungsmenü mit ESX-Menü
              ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ks_insurance_vehicle_menu2', {
                  title = Locales[lang]['vehicle_menu_title'],
                  align = 'top-left',
                  elements = vehicleElements
              }, function(data, menu)
              end, function(data, menu)
                  menu.close()
              end)
          end
      
          -- Hauptmenüoptionen für Versicherungen
          if Config.Vehicles.enabled then
              table.insert(elements, {
                  label = Locales[lang]['insurance_cars'],
                  value = 'vehicle_insurances'
              })
          end
      
          -- Füge die verschiedenen Versicherungen basierend auf der Konfiguration hinzu
          for k, v in pairs(Config.Insurances) do
              if v then
                  if k == 'car' and not Config.Vehicles.enabled then
                      table.insert(elements, {
                          label = getIcon(insurances[1].car) .. ' ' .. Locales[lang]['insurance_' .. k],
                          value = k,
                      })
                  elseif k == 'krank' then
                      table.insert(elements, {
                          label = getIcon(insurances[1].krank) .. ' ' .. Locales[lang]['insurance_' .. k],
                          value = k,
                      })
                  elseif k == 'haft' then
                      table.insert(elements, {
                          label = getIcon(insurances[1].haft) .. ' ' .. Locales[lang]['insurance_' .. k],
                          value = k,
                      })
                  elseif k == 'wohn' then
                      table.insert(elements, {
                          label = getIcon(insurances[1].wohn) .. ' ' .. Locales[lang]['insurance_' .. k],
                          value = k,
                      })
                  elseif k == 'beruf' then
                      table.insert(elements, {
                          label = getIcon(insurances[1].beruf) .. ' ' .. Locales[lang]['insurance_' .. k],
                          value = k,
                      })
                  elseif k == 'recht' then
                      table.insert(elements, {
                          label = getIcon(insurances[1].recht) .. ' ' .. Locales[lang]['insurance_' .. k],
                          value = k,
                      })
                  end
              end
          end
      
          -- Öffne das Hauptmenü mit ESX-Menü
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'insurance_menuplayer', {
              title = Config.Menu.title,
              align = 'top-left',
              elements = elements
          }, function(data, menu)
              if data.current.value == 'vehicle_insurances' then
                  menu.close()
                  VehicleMenu() -- Öffne das Fahrzeugmenü, wenn diese Option gewählt wird
              end
          end, function(data, menu)
              menu.close()
          end)
      end)
  
    function getIcon(nr)
        return nr == 0 and '❌' or '✅'
    end  

    RegisterNetEvent('ks_insurance:openMainMenu')
    AddEventHandler('ks_insurance:openMainMenu', function (insurances)
    
        local elements = {
            { label = Locales[lang]['main_menu_manage_title'], value = 'manage_insurances' }
        }
    
        table.insert(elements, { label = Locales[lang]['main_menu_vehicles_title'], value = 'vehicle_insurances' })
    
        -- ESX Menu für das Hauptmenü
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ks_insurances_main_menu', {
            title = Locales[lang]['main_menu_title'],
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'manage_insurances' then
                -- Hier wird die Versicherungsverwaltung geöffnet
                SendNUIMessage({
                    type = 'open',
                    color = Config.Color,
                    background = Config.Background,
                    insurances = insurances,
                    prices = Config.Prices,
                    enabled_insurances = Config.Insurances
                })
    
                SetNuiFocus(true, true)
                menu.close()
    
            elseif data.current.value == 'vehicle_insurances' then
                -- Fahrzeugversicherungsmenü öffnen
                menu.close()
                openVehicleInsuranceMenu()
            end
        end, function(data, menu)
            menu.close()
        end)
    end)
    
    -- Funktion zum Öffnen des Fahrzeugversicherungsmenüs
    function openVehicleInsuranceMenu()
        -- Hier verwenden wir 'ox_lib'-Callback, um die Fahrzeugdaten vom Server zu holen
        local vehicles = lib.callback.await('ks_insurance:getPlayerVehicles')
    
        local elements = {
            { label = string.format(Locales[lang]['price_per_vehicle'], Config.Vehicles.price), value = nil }
        }
    
        for k, v in pairs(vehicles) do
            -- Emoji je nach Versicherungsstatus hinzufügen
            local emoji = v.insurance == 1 and "✅" or "❌"
            table.insert(elements, {
                label = emoji .. " " .. v.plate, -- Emoji vor dem Kennzeichen
                description = Locales[lang]['vehicle_menu_description'],
                insurance = v.insurance,
                value = v.plate
            })
        end
    
        -- ESX Menu für die Fahrzeugversicherung
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ks_insurance_vehicle_menu', {
            title = Locales[lang]['vehicle_menu_title'],
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            local plate = data.current.value
            local insuranceStatus = data.current.insurance
    
            if insuranceStatus == 0 then
                -- Versicherung hinzufügen (ox_lib Callback)
                local success = lib.callback.await('ks_insurance:addVehicleInsurance', false, plate)
    
                if success then
                    Notify(string.format(Locales[lang]['vehicle_added'], plate), 'success', 5000)
                else
                    Notify(Locales[lang]['vehicle_error'], 'error', 5000)
                end
    
                -- Menü neu laden
                menu.close()
                openVehicleInsuranceMenu()
    
            elseif insuranceStatus == 1 then
                -- Versicherung entfernen (ox_lib Callback)
                local success = lib.callback.await('ks_insurance:removeVehicleInsurance', false, plate)
    
                if success then
                    Notify(string.format(Locales[lang]['vehicle_removed'], plate), 'success', 5000)
                else
                    Notify(Locales[lang]['vehicle_error'], 'error', 5000)
                end
    
                -- Menü neu laden
                menu.close()
                openVehicleInsuranceMenu()
            end
        end, function(data, menu)
            menu.close()
        end)
    end    
end