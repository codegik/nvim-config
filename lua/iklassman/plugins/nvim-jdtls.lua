local home = os.getenv('HOME')
local jdtls_dir = "/opt/homebrew/Cellar/jdtls/1.33.0/libexec"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/workspaces-jdtls/" .. project_name


local config = {
  -- cmd = {
  --   home .. '/.sdkman/candidates/java/17.0.3.6.1-amzn/bin/java',
  --   '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  --   '-Dosgi.bundles.defaultStartLevel=4',
  --   '-Declipse.product=org.eclipse.jdt.ls.core.product',
  --   '-Dlog.protocol=true',
  --   '-Dlog.level=ALL',
  --   '-Xmx1g',
  --   '--add-modules=ALL-SYSTEM',
  --   '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  --   '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  --   '-jar', jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
  --   '-configuration', jdtls_dir .. '/config_mac',
  --   '-data', workspace_dir,
  -- },
  cmd = {
    "/opt/homebrew/bin/jdtls",
    "-data",
    workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
}
local jdtls = require("jdtls")
jdtls.start_or_attach(config)
