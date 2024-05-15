
local home = os.getenv('HOME')
local dirName = home .. "/.local/share/101"
local fileName = dirName .. "/names"

local My101 = {}
My101.historyNames = {}


My101.persist = function(names)
  os.execute("truncate -s 0 " .. fileName)
  for k, v in pairs(names) do
    os.execute("echo \"" .. k .. "\" >> " .. fileName)
  end
end


My101.addHistory = function(name)
  if not My101.historyNames[name] then
    My101.historyNames[name] = true
    My101.persist(My101.historyNames)
  end
end


My101.loadHistory = function()
  os.execute("mkdir -p " .. dirName)
  local file = io.open(fileName, "r");
  for line in file:lines() do
     My101.historyNames[line] = true
  end
  file:close()
end


My101.toArray = function()
  local result = {}
  for k, v in pairs(My101.historyNames) do
    table.insert(result, k)
  end
  return result
end


My101.run101 = function(options)
  if (options.args ~= nil) then
    local handle = io.popen(home .. "/sources/private/101s/101 " .. options.args)

    if (handle ~= nil) then
      local result = handle:read("*a")
      handle:close()

      local file = result:gsub("^%s*(.-)%s*$", "%1")

      vim.cmd('e ' .. file)

      My101.addHistory(options.args)
    end

    return
  end
  print("Name parameter is missing")
end


My101.push = function()
  vim.print("Synching repository")
  local handle = io.popen(home .. "/sources/private/101s/101 push")

  if (handle ~= nil) then
    -- for line in handle:lines() do
    --   vim.notify(line)
    -- end
    local result = handle:read("*a")
    -- print(result)
    handle:close()
  end

  vim.notify("Changes pushed")
end


My101.loadHistory()


vim.api.nvim_create_user_command("One", My101.run101, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    return My101.toArray()
  end,
})

vim.api.nvim_create_user_command("OnePush", My101.push, { nargs = 0 })

return My101

