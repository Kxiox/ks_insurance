fx_version 'cerulean'
game 'gta5'

author 'Kxiox'
description 'Insurance script - Kxiox Scripts'
version '1.3.2'

lua54 'yes'

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'shared/locales.lua',
    'shared/config.lua'
}

dependencies {
    'es_extended',
    'oxmysql',
    'ox_lib'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/styles.css',
    'html/scripts.js',
    'html/assets/*.png'
}

escrow_ignore {
    'shared/config.lua'
}