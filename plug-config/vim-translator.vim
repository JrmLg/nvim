let g:translator_my_lang = "fr"
let g:translator_other_lang = "en"
let g:translator_target_lang = g:translator_other_lang


" let g:translator_default_engines = ['google']

vnoremap <silent> <C-T> <c-c>:let translator_target_lang = translator_my_lang<CR>gv:'<,'>TranslateR<CR>
vnoremap <silent> T <C-C>:let translator_target_lang = translator_other_lang<CR>gv:'<,'>TranslateR<CR> 
vnoremap <silent> <M-t> <c-c>:let translator_target_lang = translator_my_lang<CR>gv:'<,'>TranslateW<CR>
 

