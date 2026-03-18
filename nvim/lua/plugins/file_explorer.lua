-- ~/.config/nvim/lua/plugins/file_explorer.lua
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for icons
    cmd = "NvimTreeToggle", -- Lazy load on command
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        -- open_on_files = true, -- Open when opening files if no other buffer is open
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "💡",
            info = "ℹ",
            warning = "!",
            error = "✗",
          },
        },
        filters = {
          dotfiles = false,
          custom = { "node_modules", "vendor" }, -- Add common ignored directories
        },
        view = {
          width = 60,
          relativenumber = true,
          side = "left", -- "left" or "right"
        },
        git = {
          enable = true,
          ignore = true,
          show_on_dirs = true,
          timeout = 6000,
        },
        actions = {
          open_file = {
            quit_on_open = false, -- Close tree when opening a file
          },
        },
        -- etc.
      })

    end,
  },
}
