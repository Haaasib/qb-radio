fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'jomidar-radio'
version      '1.0.1'
description  'np v4 radio'
author       'Hasib'

shared_script {
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
  'locales/*.lua',
  'config.lua'
}

client_scripts {
  'client.lua',
}

server_script 'server.lua'

ui_page('html/ui.html')

files {
  'html/ui.html',
  'html/js/script.js',
  'html/css/style.css',
  'html/img/background.png'
}

dependency 'pma-voice'

lua54 'yes'
