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

:autocmd TextYankPost * call SaveLastReg()

function ClearRegisters(regs='-*+/=1234567890abcdefghijklmnopqrstuvwx')
    let regs = split(a:regs, '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfunction

command ClearRegistersAlpha :call ClearRegisters('abcdefghijklmnopqrstuvwxz')
command ClearRegistersNum :call ClearRegisters('1234567890')
