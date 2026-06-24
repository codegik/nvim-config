return {
  {
    "codegik/claude-chat.nvim",
    cmd = { "ClaudeChat", "ClaudeChatReset", "ClaudeChatContinue", "ClaudeChatFile" },
    keys = {
      { "<leader>ai", "<cmd>ClaudeChat<cr>", desc = "Claude Chat" },
      { "<leader>ac", "<cmd>ClaudeChatContinue<cr>", desc = "Claude Chat Continue" },
      { "<leader>af", "<cmd>ClaudeChatFile<cr>", desc = "Claude Chat: add current file" },
    },
    config = function()
      require("claude-chat").setup()
    end,
  },
}
