
function RunScript(scriptName="", arguments="")
    exe '!cd'
    exe '!node .\scripts\' ..  a:scriptName .. '.js "' .. a:arguments .. '"'
endfunction
