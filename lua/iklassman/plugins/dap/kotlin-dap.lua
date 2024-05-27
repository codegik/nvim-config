local dap_status, dap = pcall(require, "dap")
if not dap_status then
  print("Error loading dap")
  return
end

local home = os.getenv('HOME')

dap.adapters.kotlin = {
    type = 'executable';
    command = home .. '/.local/share/nvim/mason/bin/kotlin-debug-adapter';
}

dap.defaults.kotlin.auto_continue_if_many_stopped = false

dap.configurations.kotlin = {
    {
        type = 'kotlin';
        request = 'launch';
        name = 'Launch kotlin program';
        projectRoot = "${workspaceFolder}/app";
        mainClass = "AppKt";
    };
}
