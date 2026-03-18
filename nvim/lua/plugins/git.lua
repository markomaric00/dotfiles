return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre", -- Only load when a buffer is read (likely to be a git repo)
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000,
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "rounded",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview Open" },
            { "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", desc = "File History" },
            ---{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Repo History" },
            { "<leader>gx", "<cmd>DiffviewClose<CR>", desc = "Diffview Close" },
        },
        config = function()
            require("diffview").setup({})
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed.
            "ibhagwan/fzf-lua",      -- optional
        },
    }

}

