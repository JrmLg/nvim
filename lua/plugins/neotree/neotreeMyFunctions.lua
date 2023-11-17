local M = {}

M.ToggleNeotree = function()
	local normalizePath = require("myFunctions").normalizePath

	local filePath = normalizePath(vim.fn.expand("%:p"))
	local parentDir = normalizePath(vim.fn.expand("%:p:h"))
	local cwd = normalizePath(vim.fn.getcwd())

	if string.find(filePath, cwd) then
		vim.cmd("Neotree toggle reveal_force_cwd dir=" .. cwd .. " " .. filePath)
	else
		vim.cmd("Neotree toggle reveal_force_cwd dir=" .. parentDir .. " " .. filePath)
	end
end

return M
