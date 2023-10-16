" ----------------------------- Add all plugins ------------------------------
exe 'source' .. stdpath('config') .. '/plugins.vim'

" --------------------------------- Settings ---------------------------------
exe 'source' .. stdpath('config') .. '/general/settings.vim'

" -------------------------------- Functions ---------------------------------
for f in split(glob(stdpath('config') .. '/functions/*.vim'), '\n')
    exe 'source' f
endfor

" ------------------------ Configuration lua plugins -------------------------
for file in split(glob(stdpath('config') .. '/lua/*'), '\n')
    let filename = fnamemodify(file, ':t:r')
    execute "lua require('" . filename . "')"
endfor

" -------------------------- Configuration plugins ---------------------------
for f in split(glob(stdpath('config') .. '/plug-config/*.vim'), '\n')
    exe 'source' f
endfor

" --------------------------------- Commands ---------------------------------
exe 'source' .. stdpath('config') .. '/commands/command.vim'

" -------------------------------- My mapping --------------------------------
exe 'source' .. stdpath('config') .. '/keys/mappings.vim'

" --------------------------------- Scripts ----------------------------------
exe 'source' .. stdpath('config') .. '/scripts/run-script.vim'
