local copilot_chat = require("CopilotChat")

copilot_chat.setup({
    debug = true,
    clear_chat_on_new_prompt = false,
    suggestion = {
        auto_trigger = false,
    },
})

local keymap = vim.keymap.set
local opts = { remap = false }

keymap("n", "<leader>cc", ":CopilotChat<CR>", opts)
keymap("n", "<leader>ccm", ":CopilotChatCommit<CR>", opts)
keymap("n", "<leader>ccb", ":CopilotChatBuffer<CR>", opts)
