" ----------------------------- Add all plugins ------------------------------
source ~/AppData/Local/nvim/plugins.vim

" --------------------------------- Settings --------------------------------- 
source ~/AppData/Local/nvim/general/settings.vim

" ---------------------------------- Themes ----------------------------------
source ~/AppData/Local/nvim/themes/onedark.vim
source ~/AppData/Local/nvim/themes/airline.vim

" -------------------------------- Functions ---------------------------------
for f in split(glob('~/AppData/Local/nvim/functions/*.vim'), '\n')
    exe 'source' f
endfor

" ------------------------ Configuration lua plugins -------------------------
for file in split(glob(stdpath('config') . '/lua/*.lua'), '\n')
    let filename = fnamemodify(file, ':t:r')
    execute "lua require('" . filename . "')"
endfor

" -------------------------- Configuration plugins ---------------------------
for f in split(glob('~/AppData/Local/nvim/plug-config/*.vim'), '\n')
    exe 'source' f
endfor

" --------------------------------- Commands ---------------------------------
source ~/AppData/Local/nvim/commands/command.vim

" -------------------------------- My mapping --------------------------------
source ~/AppData/Local/nvim/keys/mappings.vim

