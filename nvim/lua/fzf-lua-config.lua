-- fzf-lua-config.lua

local status_ok, fzflua = pcall(require, "fzf-lua")
if not status_ok then
  return
end


vim.keymap.set('n', '<leader>F', ':FzfLua<CR>', { desc = '[F]ind and [G]rep inside folder' })
vim.keymap.set('n', '<leader>fg', fzflua.live_grep, { desc = '[F]ind and [G]rep inside folder' })
vim.keymap.set('n', '<leader>gb', fzflua.git_blame, { desc = '[G]it [B]lame' })
vim.keymap.set('n', '<leader>sf', fzflua.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sn', function()
fzflua.files({ cwd = vim.fn.stdpath 'config' })
end, { desc = '[S]earch [N]eovim files' })
