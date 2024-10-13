config.load_autoconfig()
c.messages.timeout = 5000

config.source('gruvbox.py')
config.bind('<Ctrl+T>', 'spawn --userscript translate.sh en')
config.bind('<Ctrl+Shift+T>', 'spawn --userscript translate.sh hin')
config.bind('<Ctrl+M>', 'spawn mpv {url}')

config.bind('<Ctrl+Shift+Up>', 'zoom-in')
config.bind('<Ctrl+Shift+Down>', 'zoom-out')
config.bind('<Ctrl+Shift+Space>', 'zoom')
