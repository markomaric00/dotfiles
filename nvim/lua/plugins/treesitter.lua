return {
  -- nvim-treesitter
  
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Command to run after installation
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }, -- If you use text objects
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "python", "html", "css", "json", "yaml", "markdown",'markdown_inline', 'bash', 'c', 'luadoc',
        },
        sync_install = false, -- Install parsers synchronously (good for initial setup)
        auto_install = true,  -- Automatically install missing parsers
        highlight = {
          enable = true, -- Enable syntax highlighting
          disable = { "markdown" }, -- Disable for specific filetypes if needed
        },
        indent = { enable = true }, -- Enable indentation
       })
      end,
  },

  -- hlchunk.nvim
      {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                    use_treesitter = true,
                    chars = {
                        horizontal_line = "─",
                        vertical_line = "│",
                        left_top = "╭",
                        left_bottom = "╰",
                        right_arrow = ">",
                        --left_top = "┌",
                        --left_bottom = "└",
                        --right_arrow = "─",
                    },
                    style = "#00ffff",
                },
            })
        end
    },
  
}