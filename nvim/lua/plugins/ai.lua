-- ~/.config/nvim/lua/plugins/ai.lua
return {

  -- CopilotChat
  {
    "zbirenbaum/copilot.lua", -- CopilotChat needs this plugin for Copilot access
    cmd = "Copilot",          -- Lazy load on command
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
            },
            panel = { enabled = false },
            filetypes = { '*' },
        })
    end,
  },
  
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "zbirenbaum/copilot.lua" },                  
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    config = function()
    require("CopilotChat").setup({
        model = 'claude-haiku-4.5',

        clear_chat_on_new_prompt = false,
        show_help = true,
    })
    end,
    },
}
