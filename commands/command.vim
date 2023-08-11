
command Cmd :!start cmd /k cd %:p:h 
command LServerInit :!start cmd /k "cd %:p:h && npm i lite-server --save-dev && npm init && exit"
command LServerStart :!start cmd /k "cd %:p:h && npm start"

command ConfAlacritty :exe 'edit ~\AppData\Roaming\alacritty\alacritty.yml'
command ConfCommands :exe 'edit' stdpath('config').'/commands/command.vim'
command ConfFunctions :exe 'edit' stdpath('config').'/functions/functions.vim'
command ConfInit :exe 'edit' stdpath('config').'/init.vim'
command ConfMapping :exe 'edit' stdpath('config').'/keys/mappings.vim'
command ConfNvim :exe "call OpenCocExplorerWithoutAnimation('" . stdpath('config') . "')"
command ConfPlugins :exe "call OpenCocExplorerWithoutAnimation('" . stdpath('config') .'/plug-config' . "')"
command ConfPluginsAdd :exe 'edit' stdpath('config').'/plugins.vim'
command ConfSettings :exe 'edit' stdpath('config').'/general/settings.vim'

command OpenGithubPlug normal ^"wyi':!start "" https://github.com/<C-r>w<CR>
command! -nargs=* Alacritty exe OpenAlacritty(<f-args>)
