-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  print("Error loading lspsaga")
  return
end

saga.setup({
  -- keybinds for navigation in lspsaga window
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
  rename = {
    keys = {
      quit = "<C-e>"
    }
  },
  code_action = {
    keys = {
      quit = "<C-e>"
    }
  },
  diagnostic = {
    keys = {
      quit = {"<C-e>"},
      quit_in_show = {"<C-e>"}
    }
  },
  callHierarchy = {
    keys = {
      quit = "<C-e>"
    }
  },
  outline = {
    keys = {
      quit = "<C-e>",
      toggle_or_jump = "<CR>"
    }
  },
  finder = {
    keys = {
      quit = "<C-e>"
    }
  },
  -- use enter to open file with definition preview
  definition = {
    edit = "<CR>",
    quit = "<C-e>"
  },
  lightbulbs = {
    enable = false
  },
  ui = {
    colors = {
      normal_bg = "#022746",
    },
  },
})
