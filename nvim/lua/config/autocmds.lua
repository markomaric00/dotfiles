-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Rename the variable under your cursor.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('<leader>fc', vim.lsp.buf.format, '[F]ormat [C]ode')

        -- The following two autocommands are used to highlight references of the
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end,
})