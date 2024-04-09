
local function file_exists(name)
   local f = io.open(name,"r")
   if f ~= nil then io.close(f) return true else return false end
end


local home = os.getenv('HOME')
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
  cmd = { jdtls_cmd, "--jvm-arg=-javaagent:" .. workspace_dir .. "/lombok.jar", "-data", workspace_dir .. "/" .. project_name },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
}

local pkg_status, jdtls = pcall(require,"jdtls")
if not jdtls then
  print("Error loading jdtls")
  return
end

jdtls.start_or_attach(config)
