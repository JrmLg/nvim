local M = {}

M.isModuleAvailable = function(name)
	if package.loaded[name] then
		return true
	else
		for _, searcher in ipairs(package.loaders) do
			local loader = searcher(name)
			if type(loader) == "function" then
				package.preload[name] = loader
				return true
			end
		end
		return false
	end
end

M.beforeStartifySave = function()
	vim.cmd('execute "wa!"')
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		local isLoaded = vim.api.nvim_buf_is_loaded(b)

		if isLoaded then
			local filetype = vim.fn.getbufvar(b, "&filetype")
			local buftype = vim.fn.getbufvar(b, "&buftype")
			local filename = vim.fn.fnamemodify(vim.fn.bufname(b), ":t")

			if
				vim.fn.index(vim.g.filtetype_to_close, filetype) ~= -1
				or vim.fn.index(vim.g.filtename_to_close, filename) ~= -1
				or vim.fn.index(vim.g.buftype_to_close, buftype) ~= -1
			then
				vim.cmd('execute "bd! ' .. b .. '"')
			end
		end
	end
end

M.normalizePath = function(path)
	return vim.fn.substitute(path, "\\", "/", "g")
end

M.firstPathContainsSecond = function(first, second)
	local firstLenght = vim.fn.strlen(first)
	if firstLenght > vim.fn.strlen(second) then
		return false
	end
	for i = 1, firstLenght, 1 do
		if first:sub(i, i) ~= second:sub(i, i) then
			return false
		end
	end
	return true
end

M.mergePaths = function(paths, newPath)
	newPath = M.normalizePath(newPath)
	local mergedPaths = {}
	local mustBeMerged = true
	if #paths == 0 then
		return { newPath }
	end
	for _, path in ipairs(paths) do
		local newPathContainPath = M.firstPathContainsSecond(newPath, path)
		local pathContainNewPath = M.firstPathContainsSecond(path, newPath)
		if path == newPath or pathContainNewPath then
			return paths
		end
		if not newPathContainPath then
			table.insert(mergedPaths, path)
		end
		if pathContainNewPath then
			mustBeMerged = false
		end
	end
	if mustBeMerged then
		table.insert(mergedPaths, newPath)
	end
	return mergedPaths
end

M.getDynamicPath = function(withConfigPath)
	local search_dirs = {}
	local workingDir = vim.fn.getcwd()
	local currentFilePath = vim.fn.expand("%:p:h")
	local configPath = vim.fn.stdpath("config")
	if vim.fn.stridx(workingDir, currentFilePath) == -1 then
		currentFilePath = vim.fn.expand("%:p:h:h")
	end
	if withConfigPath then
		search_dirs = M.mergePaths(search_dirs, configPath)
	end
	if not withConfigPath or vim.fn.stridx(workingDir, configPath) == -1 then
		search_dirs = M.mergePaths(search_dirs, workingDir)
	end
	if vim.fn.stridx(currentFilePath, workingDir) == -1 then
		if not withConfigPath or vim.fn.stridx(currentFilePath, configPath) == -1 then
			search_dirs = M.mergePaths(search_dirs, currentFilePath)
		end
	end
	search_dirs = M.mergePaths(search_dirs, currentFilePath)
	for k, path in ipairs(search_dirs) do
		search_dirs[k] = "'" .. path .. "'"
	end
	return search_dirs
end

M.telescopeFindFilesDynamicPath = function(withConfigPath)
	local searchDirs = M.getDynamicPath(withConfigPath)
	vim.cmd(
		"execute \"lua require('telescope.builtin').find_files({search_dirs = {"
			.. table.concat(searchDirs, ",")
			.. '}})"'
	)
end

M.telescopeLiveGrepConfigPath = function()
	local configPath = "'" .. M.normalizePath(vim.fn.stdpath("config")) .. "'"
	vim.cmd("execute \"lua require('telescope.builtin').live_grep({search_dirs = {" .. configPath .. '}})"')
end

M.openCmdLine = function(path)
	path = path or ""
	if path == "" then
		if vim.bo.filetype == "coc-explorer" or vim.bo.filetype == "NvimTree" then
			vim.cmd("normal! yp")
			vim.cmd("sleep 30m")
			path = vim.fn.getreg('"')
		else
			path = vim.fn.getcwd()
		end
	end
	path = vim.fn.fnamemodify(path, ":p:h")
	path = M.normalizePath(path)
	if vim.fn.has("win32") == 1 then
		vim.cmd('silent! exe  "!start alacritty --working-directory ' .. path .. '"')
	else
		vim.cmd('silent! exe "!exo-open --launch TerminalEmulator --working-directory ' .. path .. '"')
	end
end

M.selectMathExpression = function()
	local startLine = vim.fn.line(".")
	vim.fn.cursor({ startLine, 1 })
	-- vim.cmd('call cursor(' .. startLine .. ', 1)')
	local re = [[\v(([-\+](\s*\()*|[-\+\(])\s*)?([0-9\.]+\s*)(\s*[-\+\/*]\s*((\(\s*)*[0-9\.]+|[0-9\.]*)(\s*\))*)+]]
	local match, t = vim.fn.searchpos(re, "ne", startLine)
	local endMatch = match[2]

	if endMatch then
		vim.fn.search(re, "c", startLine)
		vim.cmd("normal! v")
		if vim.o.selection == "inclusive" then
			endMatch = endMatch - 1
		end
		vim.fn.cursor({ startLine, endMatch })
		vim.cmd("normal! l")
	end
end

M.saveLastReg = function()
	if vim.v.event.regname == "" then
		if vim.v.event.operator == "y" then
			for i = 8, 1, -1 do
				vim.cmd("let @" .. i + 1 .. " = @" .. i)
			end
			if vim.fn.exists("g:last_yank") then
				vim.fn.setreg("1", vim.g.last_yank)
				-- vim.cmd('let @1 = g:last_yank')
			end
			vim.g.last_yank = vim.fn.getreg('"')
			-- vim.cmd('let g:last_yank=@"')
		end
	end
end

M.incrementRegisters = function()
	for i = 8, 1, -1 do
		vim.fn.setreg(tostring(i + 1), vim.fn.getreg(tostring(i)))
	end
end

M.clearRegisters = function(regs)
	regs = regs or "-*+/=1234567890abcdefghijklmnopqrstuvwx"
	regs = vim.fn.split(regs, "\\zs")
	for _, r in ipairs(regs) do
		vim.fn.setreg(r, {})
	end
end

M.appendRegister = function(value, withClipboard)
	M.incrementRegisters()
	vim.fn.setreg('"', value)
	if withClipboard then
		vim.fn.setreg("*", value)
	end
	vim.g.last_yank = value
end

M.sendVimKey = function(str)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", false)
end

return M
