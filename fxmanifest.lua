fx_version "cerulean"
game "gta5"

author "Dawsmo"
description "Store robbery script"
version "1.0.0"

lua54 "yes"

ui_page 'src/index.html'

shared_scripts { 
    '@ox_lib/init.lua',
    "@es_extended/imports.lua",
}

client_scripts { 
    "shared/config.lua",
    "shared/config_stores.lua",
    "shared/utils.lua",
    "client/custom.lua",
    "client/client.lua",
}

server_scripts { 
    "@oxmysql/lib/MySQL.lua",
    "server/sv_config.lua",
    "shared/config.lua",
    "shared/config_stores.lua",
    "shared/utils.lua",
    "server/server.lua",
}

dependencies { 
    "es_extended",
    "oxmysql",
    "ox_lib",
}

files {
    "locales/*.json",
    "src/index.html",
    "src/styles.css",
    "src/script.js",
    "src/img/*",
}

escrow_ignore {
    "client/custom.lua",
    "shared/config.lua",
    "shared/config_stores.lua",
    "shared/stores_exemple.lua",
    "server/sv_config.lua",
}