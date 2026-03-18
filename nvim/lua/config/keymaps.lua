local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- left window
keymap("n", "<C-k>", "<C-w>k", opts) -- up window
keymap("n", "<C-j>", "<C-w>j", opts) -- down window
keymap("n", "<C-l>", "<C-w>l", opts) -- right window

-- Resize with arrows when using multiple windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-down>", ":resize +2<cr>", opts)
keymap("n", "<c-right>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-left>", ":vertical resize +2<cr>", opts)

-- navigate buffers
keymap("n", "<tab>", ":bnext<cr>", opts)       -- Next Tab
keymap("n", "<s-tab>", ":bprevious<cr>", opts) -- Previous tab

-- move text up and down
keymap("n", "<a-j>", "<esc>:m .+1<cr>==gi", opts) -- Alt-j
keymap("n", "<a-k>", "<esc>:m .-2<cr>==gi", opts) -- Alt-k

-- Clear highlights on search when pressing <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Scroll half a page down/up and center the cursor vertically
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Moves to the next (n) or previous (N) search match.
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Delete without yanking
keymap( "n", "<leader>d", "\"_d", opts)
-- Change without yanking
keymap( "n", "<leader>c", "\"_c", opts)

-- insert --
-- press jk fast to exit insert mode
keymap("i", "jk", "<esc>", opts) -- Insert mode -> jk -> Normal mode
keymap("i", "kj", "<esc>", opts) -- Insert mode -> kj -> Normal mode

-- Visual Block --
-- Move text up and down
keymap("v", "<a-j>", ":m .+1<cr>==", opts)
keymap("v", "<a-k>", ":m .-2<cr>==", opts)

-- Delete without yanking
keymap( "v", "<leader>d", "\"_d", opts)

--Terminal --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


--Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)

local function insertFullPath()
  local filepath = vim.fn.fnamemodify(vim.fn.expand("%"), ":p")
  vim.fn.setreg('+', filepath) -- write to clippoard
end
vim.keymap.set('n', '<leader>fp', insertFullPath, opts)


--UNDOTREE
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

--NVIMTREE
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

--COPILOT CHAT
local opts = { remap = false }
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", opts)
vim.keymap.set("n", "<leader>ccm", "<cmd>CopilotChatCommit<CR>", opts)

--FZF
vim.keymap.set('n', '<leader>F', '<cmd>FzfLua<CR>', { desc = '[F]zfLua Start' })
vim.keymap.set('n', '<leader>fg', "<cmd>FzfLua live_grep<CR>", { desc = '[F]ind and [G]rep inside folder' })
vim.keymap.set('n', '<leader>gb', "<cmd>FzfLua git_blame<CR>", { desc = '[G]it [B]lame' })
vim.keymap.set('n', '<leader>gc', "<cmd>FzfLua git_commits<CR>", { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gh', "<cmd>FzfLua git_bcommits<CR>", { desc = '[G]it [H]istory' })
vim.keymap.set('n', '<leader>gs', "<cmd>FzfLua git_status<CR>", { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>sf', "<cmd>FzfLua files<CR>", { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', "<cmd>FzfLua buffers<CR>", { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sn', '<cmd>FzfLua files cwd=C:\\Users\\u19y01\\AppData\\Local\\nvim<CR>', { desc = '[S]earch [N]eovim files' })

--PROJECTMGR
keymap("n", "<leader>P", ":ProjectMgr<CR>", {})


--TODO LIST
-- Add a keymapping for toggling
vim.keymap.set('n', '<leader>tf', function()
require("my_plugins.todo_float").toggle_todo_float()
end, { desc = 'Toggle TODO in floating window' })

--NEOGIT
vim.keymap.set('n', '<leader>G', '<cmd>Neogit kind=floating<CR>', { desc = '[G]it [F]loating' })

--GITSIGNS
vim.keymap.set('n', '<leader>ph', '<cmd>Gitsigns preview_hunk<CR>', { desc = '[P]review [H]unk' })
vim.keymap.set('n', '<leader>rh', '<cmd>Gitsigns reset_hunk<CR>', { desc = '[R]estore [H]unk' })
