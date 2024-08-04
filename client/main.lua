ESX = exports.es_extended:getSharedObject()

if Config.MarkerLib then
    local point = lib.points.new({
        coords = Config.Marker.coords,
        distance = 50,
    })
       
    local marker = lib.marker.new({
        coords = Config.Marker.coords,
        type = Config.Marker.type,
        color = Config.Marker.color,
        width = Config.Marker.size.x,
        height = Config.Marker.size.z
    })
    
    function point:nearby()
        marker:draw()
       
        if self.currentDistance < 1.5 then
            if not lib.isTextUIOpen() then
                lib.showTextUI(Config.TextUI.text, {
                    icon = Config.TextUI.icon,
                    style = Config.TextUI.style
                })
            end
        
            if IsControlJustPressed(0, 51) then
                local insurances = lib.callback.await('ks_insurance:getInsurances', false)
    
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
        else
            lib.hideTextUI()
        end
    end
else
    print('^4Marker using without ox_lib')
    Citizen.CreateThread(function ()
        while true do
            local distance = GetDistanceBetweenCoords(Config.Marker.coords.x, Config.Marker.coords.y, Config.Marker.coords.z, GetEntityCoords(PlayerPedId()), false)
            local sleep = 1000

            if distance <= 20 then
                sleep = 0

                DrawMarker(Config.Marker.type, Config.Marker.coords.x, Config.Marker.coords.y, Config.Marker.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.size.x, Config.Marker.size.y, Config.Marker.size.z, Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, Config.Marker.color.a, false, true, 2, nil, nil, false)

                if distance <= 1.5 then
                    HelpNotify()

                    if IsControlJustPressed(0, 51) then
                        local insurances = lib.callback.await('ks_insurance:getInsurances', false)
    
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
                end
            end

            Wait(sleep)
        end
    end)
end


RegisterNUICallback('close', function(data, cb)
    SendNUIMessage({
        type = 'close'
    })

    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('setInsurance', function(data, cb)
    local set = lib.callback.await('ks_insurance:setInsurances', false, data.type, data.id)

    cb(set)
end)

function createBlip()
    -- Erstelle den Blip
    local blip = AddBlipForCoord(Config.Blip.coords.x, Config.Blip.coords.y, Config.Blip.coords.z)

    -- Setze die Blip-Eigenschaften
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 6)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipAsShortRange(blip, true)

    -- Setze den Blip-Text
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Blip.text)
    EndTextCommandSetBlipName(blip)
end

createBlip()

if not Config.CommandLib then
    TriggerEvent('chat:addSuggestion', '/' .. Config.Command, Config.CommandHelp)
end