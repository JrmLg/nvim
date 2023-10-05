function! SaveLastReg()
    if v:event['regname']==""
        if v:event['operator']=='y'
            for i in range(8,1,-1)
                exe "let @".string(i+1)." = @". string(i) 
            endfor
            if exists("g:last_yank")
                let @1=g:last_yank
            endif
            let g:last_yank=@"
        endif 
    endif
endfunction 

function IncrementRegisters()
    for i in range(8,0,-1)
        exe "let @".string(i+1)." = @". string(i) 
    endfor
endfunction

function ClearRegisters(regs='-*+/=1234567890abcdefghijklmnopqrstuvwx')
    let regs = split(a:regs, '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfunction

function AppendRegister(value, withClipboard=1)
    call IncrementRegisters()
    call setreg('"', a:value)
    if a:withClipboard 
        call setreg('*', a:value)
    endif
    let g:last_yank = a:value
endfunction

:autocmd TextYankPost * call SaveLastReg()

command ClearRegistersAlpha :call ClearRegisters('abcdefghijklmnopqrstuvwxz')
command ClearRegistersNum :call ClearRegisters('1234567890')
