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
                insurances = insurances,
                prices = Config.Prices
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