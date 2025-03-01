-- telescope-config.lua

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end


local actions = require("telescope.actions")
require('telescope').setup{
	defaults = {
	    -- Default configuration for telescope goes here:
    -- config_key = value,
    --layout_strategy = "center",
    --results_title = false,
    --sorting_strategy = "ascending",
    --layout_config = {
     --   center = {
      --      width = 0.9,
       --     height = 0.5,
        --    },
        -- other layout configuration here
       -- },
    prompt_prefix = " ",
    selection_caret = " ",
    --path_display = { "smart" },
--           mappings = {
--             i = { ['<c-enter>'] = require('telescope.actions').to_fuzzy_refine },
--			 n = { ['<c-enter>'] = require('telescope.actions').to_fuzzy_refine },
--           },
         },

--    pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_ key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
-- },
  extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
      -- Enable Telescope extensions if they are installed
	}
}
	  pcall(require("telescope").load_extension("live_grep_args"))
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  --vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  --vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  --vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  --vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  --vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  --vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  --vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",  { desc = '[F]ind and [Grep] inside certain folder' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
	builtin.live_grep {
	  grep_open_files = true,
	  prompt_title = 'Live Grep in Open Files',
	}
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
	builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
