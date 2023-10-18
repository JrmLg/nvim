
function RunScript(scriptName="", arguments="")
    exe '!cd'
    exe '!node ' .. stdpath('config') .. '/scripts/' ..  a:scriptName .. '.js "' .. a:arguments .. '"'
endfunction
