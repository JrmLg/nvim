local renderer = require("neo-tree.ui.renderer")
local mySettings = require("plugins.neotree.neotreeMySettings")

local function printTable(table)
	vim.api.nvim_echo({ { vim.inspect(table) } }, true, {})
end

local function has_value(table, value)
	for idx, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

local function indexOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

local function is_exclude(dirNode)
	return has_value(mySettings.excludeDirsToExpandRecursive, dirNode.name)
end

local function getSiblings(state, node)
	local parent = state.tree:get_node(node:get_parent_id())
	local siblings = parent:get_child_ids()
	return siblings
end

local function setRootAndDefineCwd(state)
	local node = state.tree:get_node()
	local path = node:get_id()

	local commands = require("neo-tree.sources.filesystem.commands")
	commands.set_root(state)

	vim.cmd("cd " .. path)
end

local function getRootPath(state)
	return state.tree.nodes["root_ids"][1]
end

local function getNodeFullPath(state)
	local path = state.tree:get_node().path
	if path == nil then
		return ""
	else
		return path
	end
end

local function getLocalFoldLevel(state, node)
	if node.type == "directory" and not is_exclude(node) then
		if not node:is_expanded() then
			return 0, true
		end
		local children = state.tree:get_nodes(node:get_id())
		local minLevel
		local minLevelCanExp
		local canExpandMore = false

		for _, child in ipairs(children) do
			if child.type == "directory" and not is_exclude(child) then
				canExpandMore = true
				if child:is_expanded() then
					local level, canExp = getLocalFoldLevel(state, child)
					level = level + 1

					if canExp then
						if minLevelCanExp == nil or minLevelCanExp > level then
							minLevelCanExp = level
						end
					else
						if minLevel == nil or minLevel > level then
							minLevel = level
						end
					end
				else
					return 1, canExpandMore
				end
			end
		end
		if minLevelCanExp ~= nil then
			return minLevelCanExp, canExpandMore
		end

		if minLevel == nil then
			return 1, canExpandMore
		else
			return minLevel, canExpandMore
		end
	else
		return 0, false
	end
end

-- Expand a node and load filesystem info if needed.
local function openDir(state, dir_node)
	local fs = require("neo-tree.sources.filesystem")
	if not dir_node:is_expanded() and not is_exclude(dir_node) then
		fs.toggle_directory(state, dir_node, nil, true, false)
	end
end

local function closeDir(state, dir_node)
	local fs = require("neo-tree.sources.filesystem")
	if dir_node:is_expanded() then
		fs.toggle_directory(state, dir_node, nil, true, false)
	end
end

-- Expand a node and all its children, optionally stopping at max_depth.
local function recursiveOpen(state, node, max_depth)
	local max_depth_reached = 1
	local stack = { node }

	while next(stack) ~= nil do
		node = table.remove(stack)
		if node.type == "directory" then
			openDir(state, node)
		end

		local depth = node:get_depth()
		max_depth_reached = math.max(depth, max_depth_reached)

		if not max_depth or depth < max_depth - 1 then
			local children = state.tree:get_nodes(node:get_id())
			for _, v in ipairs(children) do
				table.insert(stack, v)
			end
		end
	end

	return max_depth_reached
end

-- Collapse a node and all its children, optionally stopping at max_depth.
local function recursiveClose(state, node, max_depth)
	local max_depth_reached = 1
	local stack = { node }
	while next(stack) ~= nil do
		node = table.remove(stack)
		if node.type == "directory" then
			closeDir(state, node)
		end

		local depth = node:get_depth()
		max_depth_reached = math.max(depth, max_depth_reached)

		if not max_depth or depth < max_depth - 1 then
			local children = state.tree:get_nodes(node:get_id())
			for _, v in ipairs(children) do
				table.insert(stack, v)
			end
		end
	end

	return max_depth_reached
end

--- Open the fold under the cursor, recursing if count is given.
local function neotree_zo(state, open_all)
	local node = state.tree:get_node()
	recursiveOpen(state, node, node:get_depth() + vim.v.count1)
	renderer.redraw(state)
end

--- Recursively open the current folder and all folders it contains.
local function neotree_zO(state)
	local node = state.tree:get_node()
	recursiveOpen(state, node)
	renderer.redraw(state)
end

-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2

--- Close the node and its parents, optionally stopping at max_depth.
local function close_recursive(state, node, max_depth)
	if max_depth == nil or max_depth <= MIN_DEPTH then
		max_depth = MIN_DEPTH
	end

	local last = node
	while node and node:get_depth() >= max_depth do
		if node:has_children() and node:is_expanded() then
			node:collapse()
		end
		last = node
		node = state.tree:get_node(node:get_parent_id())
	end

	return last
end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local function set_depthlevel(state, depthlevel)
	if depthlevel < MIN_DEPTH then
		depthlevel = MIN_DEPTH
	end

	local stack = state.tree:get_nodes()
	while next(stack) ~= nil do
		local node = table.remove(stack)

		if node.type == "directory" then
			local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
			if should_be_open and not node:is_expanded() then
				openDir(state, node)
			elseif not should_be_open and node:is_expanded() then
				node:collapse()
			end
		end

		local children = state.tree:get_nodes(node:get_id())
		for _, v in ipairs(children) do
			table.insert(stack, v)
		end
	end

	vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local function redraw_after_depthlevel_change(state, stay)
	local node = state.tree:get_node()

	if stay then
		require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
	else
		-- Find the closest parent that is still visible.
		local parent = state.tree:get_node(node:get_parent_id())
		while not parent:is_expanded() and parent:get_depth() > 1 do
			node = parent
			parent = state.tree:get_node(node:get_parent_id())
		end
	end

	renderer.redraw(state)
	renderer.focus_node(state, node:get_id())
end

-- Collapse more folders: decrease depthlevel by 1 or count.
local function neotree_zm(state)
	local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
	set_depthlevel(state, depthlevel - vim.v.count1)
	redraw_after_depthlevel_change(state, false)
end

-- Collapse all folders. Set depthlevel to MIN_DEPTH.
local function neotree_zM(state)
	set_depthlevel(state, MIN_DEPTH)
	redraw_after_depthlevel_change(state, false)
end

-- Expand more folders: increase depthlevel by 1 or count.
local function neotree_zr(state)
	local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
	set_depthlevel(state, depthlevel + vim.v.count1)
	redraw_after_depthlevel_change(state, false)
end

-- Expand all folders. Set depthlevel to the deepest node level.
local function neotree_zR(state)
	local top_level_nodes = state.tree:get_nodes()

	local max_depth = 1
	for _, node in ipairs(top_level_nodes) do
		max_depth = math.max(max_depth, recursiveOpen(state, node))
	end

	vim.b.neotree_depthlevel = max_depth
	redraw_after_depthlevel_change(state, false)
end

local function reduceLocalFoldLevel(state)
	local tree = state.tree
	local node = tree:get_node()

	if node.type ~= "directory" then
		node = tree:get_node(node:get_parent_id())
	end

	local level = getLocalFoldLevel(state, node)
	local depth = node:get_depth() + level - 1
	recursiveClose(state, node)
	if level > 1 then
		recursiveOpen(state, node, depth)
	end
	renderer.redraw(state)
end

local function increaseLocalFoldLevel(state, node)
	local tree = state.tree
	node = node or tree:get_node()

	if node.type ~= "directory" then
		node = tree:get_node(node:get_parent_id())
	end

	local level = getLocalFoldLevel(state, node)
	local depth = node:get_depth() + level + 1
	recursiveClose(state, node)
	recursiveOpen(state, node, depth)
end

local m = {
	next_sibling = function(state)
		local node = state.tree:get_node()
		local siblings = getSiblings(state, node)
		if not node.is_last_child then
			local currentIndex = indexOf(siblings, node.id)
			local nextIndex = siblings[currentIndex + 1]
			renderer.focus_node(state, nextIndex)
		end
	end,

	prev_sibling = function(state)
		local node = state.tree:get_node()
		local siblings = getSiblings(state, node)
		local currentIndex = indexOf(siblings, node.id)
		if currentIndex > 1 then
			local nextIndex = siblings[currentIndex - 1]
			renderer.focus_node(state, nextIndex)
		end
	end,

	first_sibling = function(state)
		local node = state.tree:get_node()
		local siblings = getSiblings(state, node)
		renderer.focus_node(state, siblings[1])
	end,

	last_sibling = function(state)
		local node = state.tree:get_node()
		local siblings = getSiblings(state, node)
		renderer.focus_node(state, siblings[#siblings])
	end,

	parent_dir = function(state)
		local tree = state.tree
		local node = state.tree:get_node()
		local parent = tree:get_node(node:get_parent_id())

		renderer.focus_node(state, parent.id)
	end,

	open_cmd_line = function(state)
		local tree = state.tree
		local node = state.tree:get_node()

		local path = getNodeFullPath(state)
		path, _ = path:gsub("\\", "\\\\")
		require("myFunctions").openCmdLine(path)
	end,

	system_execute = function(state)
		local path = getNodeFullPath(state)
		if path ~= "" then
			path, _ = path:gsub("\\", "\\\\")
			require("scripts.run-script")("system-execute", path)
		end
	end,

	copy_file_name = function(state)
		local filename = state.tree:get_node().name
		print("Filename copied : " .. filename)
		require("myFunctions").appendRegister(filename, true)
	end,

	copy_absolute_path = function(state)
		local absolutePath = getNodeFullPath(state)
		print("Absolute path copied : " .. absolutePath)
		require("myFunctions").appendRegister(absolutePath, true)
	end,

	copy_relative_path = function(state)
		local rootPath = getRootPath(state)
		local absolutePath = getNodeFullPath(state)
		local relativePath = absolutePath:gsub(rootPath, "")
		print(vim.inspect({
			rootPath = rootPath,
			absolutePath = absolutePath,
			relativePath = relativePath,
		}))
		-- print("Relative path copied : " .. relativePath)
		require("myFunctions").appendRegister(relativePath, true)
	end,

	set_root_and_define_cwd = function(state)
		setRootAndDefineCwd(state)
	end,

	open_with_window_picker_if_possible = function(state)
		local commands = require("neo-tree.sources.filesystem.commands")
		if vim.fn.winnr() ~= 1 then
			commands.open_with_window_picker(state)
		else
			commands.open(state)
		end
	end,

	increase_local_fold_level = function(state)
		local node = state.tree:get_node()
		if node.type == "directory" then
			increaseLocalFoldLevel(state, node)
			renderer.redraw(state)
		else
			local commands = require("neo-tree.sources.filesystem.commands")
			if #vim.api.nvim_list_wins() > 3 then
				commands.open_with_window_picker(state)
			else
				commands.open(state)
			end
		end
	end,

	increase_local_fold_level_visual = function(state, selected_nodes)
		local commands = require("neo-tree.sources.filesystem.commands")
		local needRedraw = false
		for _, node in pairs(selected_nodes) do
			if node.type == "directory" then
				increaseLocalFoldLevel(state, node)
				needRedraw = true
			else
				renderer.focus_node(state, node:get_id())
				commands.open(state)
			end
		end
		if needRedraw then
			renderer.redraw(state)
		end
	end,

	reduce_local_fold_level = function(state)
		local node = state.tree:get_node()

		if node.type ~= "directory" then
			node = state.tree:get_node(node:get_parent_id())
		end

		if node.type == "directory" and node:is_expanded() then
			reduceLocalFoldLevel(state)
			renderer.redraw(state)
			renderer.focus_node(state, node:get_id())
		end
	end,

	open_all_subnodes = function(state)
		neotree_zO(state)
	end,

	neotree_zm = function(state)
		neotree_zm(state)
	end,

	neotree_zr = function(state)
		neotree_zr(state)
	end,

	neotree_zM = function(state)
		neotree_zM(state)
	end,

	neotree_zR = function(state)
		neotree_zR(state)
	end,

	print_node = function(state)
		local node = state.tree:get_node()
		node.localFoldLevel = getLocalFoldLevel(state, node)
		printTable(node)
	end,
}

return m
