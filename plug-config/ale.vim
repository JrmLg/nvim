let g:ale_fixers = {
    \ '*' : ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['prettier', 'eslint'],
    \ 'javascriptreact': ['prettier', 'eslint'],
    \ 'typescriptreact': ['prettier', 'eslint']
    \}
let g:ale_fix_on_save = 1
