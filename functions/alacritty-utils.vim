function AlacrittySettingPath()
    return expand($HOME) . "/AppData/Roaming/alacritty/alacritty.yml"
endfunction

function AlacrittySetOpacityValue(opacityValue = 0.96)
    let settingPath = AlacrittySettingPath()
    let lines = readfile(settingPath)
    let opacityValue = string(a:opacityValue)
    let i = 0

    for line in lines
        if line =~ 'opacity:'
            let [opacity, value] = split(line, ': ')
            let lines[i] = opacity . ": "  . opacityValue
            echo "opacity: " . opacityValue
        endif
        let i += 1
    endfor

    call writefile(lines, settingPath)
endfunction

function AlacrittyGetOpacityValue()
    let lines = readfile(AlacrittySettingPath())
    for line in lines
        if line =~ 'opacity:'
            let [opacity, value] = split(line, ': ')
            return str2float(value)
        endif
    endfor
endfunction

function AlacrittyChangeOpacity()
    let opacityValue = AlacrittyGetOpacityValue()
    if  opacityValue == 0.96
        call AlacrittySetOpacityValue(0.60)
    elseif opacityValue == 0.6
        call AlacrittySetOpacityValue(0.30)
    else
        call AlacrittySetOpacityValue(0.96)
    endif
endfunction

function AlacrittyIncreaseOpacity(step=0.05)
    let opacityValue = AlacrittyGetOpacityValue()
    let step = a:step
    let newValue = opacityValue + step
    if newValue <= 1
        call AlacrittySetOpacityValue(newValue)
    endif
endfunction

function AlacrittyDecreaseOpacity(step=0.05)
    let opacityValue = AlacrittyGetOpacityValue()
    let step = a:step
    let newValue = opacityValue - step
    if newValue > 0
        call AlacrittySetOpacityValue(newValue)
    endif
endfunction

function OpenCmdLine(path="")
    let path = a:path

    if path == ""
        if &filetype == "coc-explorer" || &filetype == "NvimTree"
            normal yp
            sleep 30m
            let path = getreg('"')
        else
            let path = getcwd()
        endif
    endif

    let path = fnamemodify(path, ':p:h')
    if has("win32")
        silent exe  "!start alacritty --working-directory " . path
    else
        silent exe "!exo-open --launch TerminalEmulator --working-directory " . path
    endif

endfunction

nnoremap <silent> <BS>a :call OpenCmdLine()<CR><ESC>
