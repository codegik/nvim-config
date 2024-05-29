-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  print("Telescope not found!") -- print error if telescope not installed
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  print("Telescope actions not found!") -- print error if telescope actions not installed
  return
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
        ["<C-e>"] = actions.close,
      },
    },
    file_ignore_patterns = { "node_modules", "target", ".git", "build" },
    path_display = { "smart" },
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      vertical = {
        prompt_position = "top",
        mirror = true,
      },
    },
  },
  pickers = {
    find_files = {
      layout_config = {
        width = 0.8,
      }
    }
  },
})

telescope.load_extension("fzf")
