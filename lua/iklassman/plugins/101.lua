
local home = os.getenv('HOME')
local dirName = home .. "/.local/share/101"
local fileName = dirName .. "/names"

os.execute("mkdir -p " .. dirName)

local My101 = {}
My101.historyNames = {}

local historyFile = io.open(fileName, "a+");
for name in historyFile:lines() do
  table.insert (My101.historyNames, name);
end

My101.persist = function(names)
  io.open(fileName, "w"):close()
  local historyNames = io.open(fileName, "w");
  for name in My101.historyNames do
    historyNames:write(name .. "\n")
  end
end

My101.addHistory = function(name)
  table.insert(My101.historyNames, name)
  My101.persist(My101.historyNames)
end

My101.run101 = function(options)
  if (options.args ~= nil) then
    local handle = io.popen(home .. "/sources/private/101s/101 " .. options.args)

    if (handle ~= nil) then
      local result = handle:read("*a")
      handle:close()

      local file = result:gsub("^%s*(.-)%s*$", "%1")

      vim.cmd('e ' .. file)

      table.insert(My101.historyNames, options.args)
    end

    return
  end
  print("Name parameter is missing")
end

vim.api.nvim_create_user_command("One", My101.run101, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    return My101.historyNames
  end,
})

return My101
