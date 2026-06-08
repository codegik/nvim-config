return {
  {
    "codegik/claude-chat.nvim",
    cmd = { "ClaudeChat", "ClaudeChatReset", "ClaudeChatFile" },
    keys = {
      { "<leader>ai", "<cmd>ClaudeChat<cr>", desc = "Claude Chat" },
      { "<leader>af", "<cmd>ClaudeChatFile<cr>", desc = "Claude Chat: add current file" },
    },
    config = function()
      require("claude-chat").setup()
    end,
  },
}
