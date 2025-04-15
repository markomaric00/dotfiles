local opt = vim.opt

--opt.background = "light"
opt.breakindent = true -- Enable break indent
opt.completeopt = "menu,menuone,noselect"
opt.clipboard="unnamed,unnamedplus" -- Sync with system clipboard
opt.expandtab = true -- Use spaces instead of tabs
opt.hlsearch = false -- Set highlight on search
opt.ignorecase = true -- Ignore case
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.relativenumber = true
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true -- Save undo history
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.inccommand = 'split'-- Preview substitutions live, as you type!

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
