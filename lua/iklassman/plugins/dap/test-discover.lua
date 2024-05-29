
local M = {}

local path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"

function M.path_join(...)
    return table.concat(vim.tbl_flatten({ ... }), path_sep)
end

local function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function M.get_package()
    local x = vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h")
    local pathTable = mysplit(x, "/")

    local cutof = indexOf(pathTable, "kotlin")
    local size1 = 0
    for _ in pairs(pathTable) do
        size1 = size1 + 1
    end
    for i = cutof, 1, -1 do
        table.remove(pathTable, 1)
    end

    return table.concat(pathTable, ".")
end



local function sanitised(test_name)
	local clean_test = test_name:gsub("`", "")
	return clean_test
end

function M.test_class()
	local query = [[
(class_declaration (type_identifier) @cname)
]]
	local parser = vim.treesitter.get_parser(0)
	local root = (parser:parse()[1]):root()

	local closest_name = nil

	local stop_row = vim.api.nvim_win_get_cursor(0)[1]
	local ft = vim.api.nvim_buf_get_option(0, "filetype")
	assert(ft == "kotlin", "dap-go error: can only debug go files, not " .. ft)

	local test_query = vim.treesitter.query.parse(ft, query)
	assert(test_query, "dap-go error: could not parse test query")

	for _, match, _ in test_query:iter_matches(root, 0, 0, stop_row) do
		for id, node in pairs(match) do
			local capture = test_query.captures[id]
			if capture == "cname" then
				closest_name = vim.treesitter.get_node_text(node, 0)
			end
		end
	end
	return closest_name
end

function M.closest_test()
	local tests_query = [[
    (function_declaration
    (modifiers)? @mod
    (simple_identifier) @fname)
]]

	local parser = vim.treesitter.get_parser(0)
	local root = (parser:parse()[1]):root()

	Debug_test_tree = {}
	local test_name = ""

	local stop_row = vim.api.nvim_win_get_cursor(0)[1]
	local ft = vim.api.nvim_buf_get_option(0, "filetype")
	assert(ft == "kotlin", "dap-go error: can only debug go files, not " .. ft)

	local test_query = vim.treesitter.query.parse(ft, tests_query)
	assert(test_query, "dap-go error: could not parse test query")

	for _, match, _ in test_query:iter_matches(root, 0, 0, stop_row) do
		local test_match = {}
		for id, node in pairs(match) do
			local capture = test_query.captures[id]
			if capture == "mod" then
				local name = vim.treesitter.get_node_text(node, 0)
				test_match.modifier = name
			end
			if capture == "fname" then
				test_match.function_name = vim.treesitter.get_node_text(node, 0)
			end
		end
		table.insert(Debug_test_tree, test_match)
		test_name = test_match.function_name
	end
	return sanitised(test_name)
end

return M

