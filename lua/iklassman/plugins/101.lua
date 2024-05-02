
local My101 = {}

My101.complete = {}

My101.run101 = function(options)
  if (options.args ~= nil) then
    local home = os.getenv('HOME')
    local handle = io.popen(home .. "/sources/private/101s/101 " .. options.args)

    if (handle ~= nil) then
      local result = handle:read("*a")
      handle:close()

      local file = result:gsub("^%s*(.-)%s*$", "%1")

      vim.cmd('e ' .. file)

      table.insert(My101.complete, options.args)
    end

    return
  end
  print("Name parameter is missing")
end

vim.api.nvim_create_user_command("One", My101.run101, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    return My101.complete
  end,
})

return My101
