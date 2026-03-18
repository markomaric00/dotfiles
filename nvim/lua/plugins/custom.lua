-- ~/.config/nvim/lua/plugins/custom.lua

return {
  {
    -- 'dir' points to the *directory* where your plugin's main module is located.
    -- The module name itself will be `todo_float` because your file is `todo_float.lua`
    -- inside the `my_plugins` directory.
    dir = vim.fn.stdpath('config') .. '/lua/my_plugins',
    name = 'todo-float-plugin', -- A descriptive name for lazy.nvim
    -- You can trigger it with a command, or very lazily.
    -- Since you have commands, `cmd = "TodoFloat"` is a good choice.
    cmd = "TodoFloat",
    -- Alternatively, you could use event = "VeryLazy" if you want it loaded on startup.
    -- event = "VeryLazy",

    config = function()
      -- Require your plugin module. The path matches your file location relative to `lua/`
      local todo_float = require("my_plugins.todo_float")

      -- Call your plugin's setup function (if it has one)
      todo_float.setup({}) -- Pass any options here if your setup function accepted them

    end,
  },
}