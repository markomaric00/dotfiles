-- aliases
local opt  = vim.opt     -- global

--global options
opt.completeopt = "menuone,noselect"
opt.smartcase = true
opt.laststatus = 2
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.scrolloff = 1
opt.showcmd = true
opt.wildmenu = true
opt.mouse = 'a'
opt.showmatch = true
opt.ruler = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.number = true

local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Better window navigation
map("n", "<C-h>", "<C-w>h" )
map("n", "<C-j>", "<C-w>j" )
map("n", "<C-k>", "<C-w>k" )
map("n", "<C-l>", "<C-w>l" )
