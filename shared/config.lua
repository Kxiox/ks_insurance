Config = {}

Config.Locale = 'de'

Config.Color = '#00de09'
Config.Background = 'linear-gradient(180deg, rgba(0,0,0,0.9) 0%, rgba(0,13,1,0.9) 58%, rgba(0,29,1,0.9)100%)'
Config.Target = false -- using ox_target?

Config.DeductionInterval = 60000 * 60 -- every hour server is remove money

Config.Command = 'versicherungen'
Config.CommandHelp = 'Öffnet das Versicherungsmenü'
Config.CommandLib = true -- using ox_lib for command?

Config.MarkerLib = true -- using ox_lib for marker?
Config.Marker = {
    coords = vector3(-318.9953, -609.8325, 32.5582),
    size = { x = 2.0, y = 2.0, z = 1.0 }, -- y the same like x if u use ox_lib
    type = 1,
    color = { r = 0, g = 255, b = 0, a = 200 }
}

Config.Blip = {
    coords = {x = -318.9953, y = -609.8325, z = 32.5582},
    sprite = 487,
    scale = 1.0,
    color = 2,
    text = 'Versicherung'
}

Config.TextUI = {
    text = "[E] - Versicherung",
    icon = 'file-invoice', -- https://fontawesome.com/search?o=r&m=free
    style = {
        borderRadius = 10,
        backgroundColor = '#48BB78',
        color = 'white'
    }
}

Config.MenuLib = true -- using ox_lib for menu? false = esx menu
Config.Menu = {
    title = 'Versicherungen',
    position = 'top-left' -- menu position if Config.MenuLib false
}

Config.Insurances = {
    car = true,
    krank = true,
    haft = true,
    wohn = true,
    beruf = true,
    recht = true
}

Config.Prices = {
    currency = '€',
    car = 1000,
    krank = 1000,
    haft = 1000,
    wohn = 1000,
    beruf = 1000,
    recht = 1000
}

function Notify(text, type, time)
    lib.notify({
        title = 'Versicherung',
        description = text,
        type = type,
        duration = time,
        position = 'top'
    })
end

function ServerNotify(source, text, type, time)
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Versicherung',
        description = text,
        type = type,
        duration = time,
        position = 'top'
    })
end

function HelpNotify() -- help notify if Config.MarkerLib = false
    ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um das Menü zu öffnen.')
end