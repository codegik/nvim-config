
local function file_exists(name)
   local f = io.open(name,"r")
   if f ~= nil then io.close(f) return true else return false end
end


local home = os.getenv('HOME')
local jdtls_dir = "/opt/homebrew/Cellar/jdtls/1.34.0/libexec"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/workspaces-jdtls"
local jdtls_runnable = {"/usr/local/bin/jdtls", "/opt/homebrew/bin/jdtls"}
local jdtls_cmd = jdtls_runnable[1]

for i = 1, #jdtls_runnable do
  if file_exists(jdtls_runnable[i]) then
    jdtls_cmd = jdtls_runnable[i]
    break
  end
end


local config = {
    cmd = {
      home .. '/.sdkman/candidates/java/17.0.3.6.1-amzn/bin/java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '-javaagent:' .. home .. '/.local/share/lib/lombok.jar',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar',
      '-configuration', jdtls_dir .. '/config_mac_arm',
      '-data', workspace_dir .. "/" .. project_name,
  },
  -- cmd = { jdtls_cmd, "--jvm-arg=-javaagent:" .. workspace_dir .. "/lombok.jar", "-data", workspace_dir .. "/" .. project_name },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw", "pom.xml" }, { upward = true })[1]),
}

local pkg_status, jdtls = pcall(require, "jdtls")
if not jdtls then
  print("Error loading jdtls")
  return
end

jdtls.start_or_attach(config)
