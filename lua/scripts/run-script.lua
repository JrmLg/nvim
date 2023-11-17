return function(scriptName, arguments)
	vim.cmd("!cd")
	vim.cmd("!node " .. vim.fn.stdpath("config") .. "/lua/scripts/" .. scriptName .. '.js "' .. arguments .. '"')
end
