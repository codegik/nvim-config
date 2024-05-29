local discover = require("iklassman.plugins.dap.test-discover")

-- local dap_status, dap = pcall(require, "dap-kotlin")
-- if not dap_status then
--   print("Error loading nvim-dap-kotlin")
--   return
-- end

local dapui_status, dapui = pcall(require, "dapui")
if not dapui_status then
  print("Error loading dapui")
  return
end

-- dap.setup({
--   dap_command = "kotlin-debug-adapter",
--   project_root = "${workspaceFolder}",
-- })

local dap_status, dap = pcall(require, "dap")
if not dap_status then
  print("Error loading dap")
  return
end


local projectRoot = "${workspaceFolder}"
local jsonLogFile = ""
local enableJsonLogging = false

dap.adapters.kotlin = {
  type = "executable",
  command = "kotlin-debug-adapter",
  options = {
    initialize_timeout_sec = 15,
    disconnect_timeout_sec = 15,
    auto_continue_if_many_stopped = true,
  },
}
dap.configurations.kotlin = {
  {
    type = "kotlin",
    request = "launch",
    name = "This file",
    mainClass = function()
      local mainclass = discover.get_package() .. "." .. discover.test_class()
      -- cache.cache_add(mainclass)
      return mainclass
    end,
    projectRoot = projectRoot,
    jsonLogFile = jsonLogFile,
    enableJsonLogging = enableJsonLogging,
  },
  {
    type = "kotlin",
    request = "launch",
    name = "All tests",
    mainClass = "org.junit.platform.console.ConsoleLauncher --scan-class-path",
    projectRoot = projectRoot,
    jsonLogFile = jsonLogFile,
    enableJsonLogging = enableJsonLogging,
  },
}
dap.defaults.kotlin.auto_continue_if_many_stopped = true
dap.set_log_level("DEBUG")

dapui.setup()
