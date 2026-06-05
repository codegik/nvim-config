-- Make Metals/Bloop run on a Metals-supported LTS JDK (21) even though the
-- system default JDK is newer (25). Auto-detects the installed JDK 21 under
-- sdkman so it survives patch-version bumps.
return {
  {
    "scalameta/nvim-metals",
    opts = function(_, metals_config)
      local base = vim.fn.expand("~/.sdkman/candidates/java")
      local jdk21
      if vim.fn.isdirectory(base) == 1 then
        for _, name in ipairs(vim.fn.readdir(base)) do
          if name:match("^21") then
            jdk21 = base .. "/" .. name
            break
          end
        end
      end
      if jdk21 then
        metals_config.settings = metals_config.settings or {}
        metals_config.settings.javaHome = jdk21
      end
      return metals_config
    end,
  },
}
