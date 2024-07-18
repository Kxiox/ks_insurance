Config = {}

Config.Color = '#00de09' -- hexcode
Config.Background = 'linear-gradient(180deg, rgba(0,0,0,0.9) 0%, rgba(0,13,1,0.9) 58%, rgba(0,29,1,0.9)100%)' -- https://cssgradient.io/
Config.Target = false -- using ox_target?

Config.Marker = {
    coords = vector3(-318.9953, -609.8325, 32.5582),
    type = 1,
    color = { r = 0, g = 255, b = 0, a = 200 }
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

Config.Prices = {
    currency = '€',
    car = 1000,
    krank = 1000,
    haft = 1000,
    wohn = 1000,
    beruf = 1000,
    recht = 1000
}
