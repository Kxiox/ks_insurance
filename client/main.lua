ESX = exports.es_extended:getSharedObject()

local point = lib.points.new({
    coords = Config.Marker.coords,
    distance = 50,
})
   
local marker = lib.marker.new({
    coords = Config.Marker.coords,
    type = Config.Marker.type,
    color = Config.Marker.color
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
                insurances = insurances
            })

            SetNuiFocus(true, true)
        end
    else
        lib.hideTextUI()
    end
end

RegisterNUICallback('close', function(data, cb)
    SendNUIMessage({
        type = 'close'
    })

    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('getButtons', function(data, cb)
    

    cb('ok')
end)

Citizen.CreateThread(function ()
    while not ESX.IsPlayerLoaded() do
        Wait(100)
    end

    print('Test')
    SendNuiMessage({
        type = 'color',
        color = Config.Color
    })
end)