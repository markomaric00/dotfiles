local M = {}

-- Store references to the floating window and its buffer
M.win_id = nil
M.buf_id = nil

-- Check if the window is still valid
local function is_win_valid()
    return M.win_id ~= nil and vim.api.nvim_win_is_valid(M.win_id)
end

-- Close the floating window
function M.close_todo_float()
    if not is_win_valid() then
        return -- If window not valid, nothing to do
    end

    if M.buf_id and vim.api.nvim_buf_is_valid(M.buf_id) then
        -- Use nvim_buf_call to ensure the command runs in the context of the todo buffer
        local status_ok, err = pcall(vim.api.nvim_buf_call, M.buf_id, function()
            -- Force write to ensure edits are saved even if the file exists
            vim.cmd("write!")
        end)
        if not status_ok then
            vim.notify("Failed to save TODO.md: " .. err, vim.log.levels.ERROR, { title = "TodoFloat Error" })
        else
            vim.notify("TODO.md saved successfully.", vim.log.levels.INFO, { title = "TodoFloat" })
        end
    end

    vim.api.nvim_win_close(M.win_id, true)
    M.win_id = nil
    M.buf_id = nil
end

-- Open the floating window with TODO.md
function M.open_todo_float()
    if is_win_valid() then
        M.close_todo_float() -- Close existing one if open to ensure a fresh state
    end

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")
    local win_width = math.floor(width * 0.5)
    local win_height = math.floor(height * 0.5)
    local row = math.floor((height - win_height) / 2)
    local col = math.floor((width - win_width) / 2)

    -- Create a new buffer: not listed, and a scratch buffer initially
    local buf = vim.api.nvim_create_buf(false, true)
    M.buf_id = buf

    local opts = {
        relative = 'editor',
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        focusable = true,
        noautocmd = true, -- Avoid unwanted autocommands on window creation
    }

    M.win_id = vim.api.nvim_open_win(buf, true, opts)

    -- Set buffer options for the floating window
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') -- Allow buffer to be wiped on close
    vim.api.nvim_buf_set_option(buf, 'swapfile', false)  -- Don't create swap file
    vim.api.nvim_buf_set_option(buf, 'modifiable', true) -- Ensure it's modifiable

    -- Important: Set buftype to empty string to make it a normal, writeable buffer
    vim.api.nvim_buf_set_option(buf, 'buftype', '')

    local todo_file_path = vim.fn.resolve(vim.fn.getcwd() .. '/TODO.md')

    local file_content = {}
    local file_exists = (vim.fn.filereadable(todo_file_path) == 1)

    if file_exists then
        file_content = vim.fn.readfile(todo_file_path)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, file_content)
        vim.api.nvim_buf_set_option(buf, 'modified', false) -- Mark as unmodified after loading existing content
    else
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "# My Project TODOs", "" }) -- Initial content for a new file
        vim.api.nvim_buf_set_option(buf, 'modified', true) -- Mark as modified to ensure it saves on first close
    end

    vim.api.nvim_buf_set_name(buf, todo_file_path) -- Set buffer name to the file path
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

    -- Set up keybindings specific to the floating window
    vim.keymap.set(
        'n', 'q',
        function() require('my_plugins.todo_float').close_todo_float() end, -- Direct Lua function
        { buffer = buf, silent = true, noremap = true, desc = 'Close TODO float' }
    )
    vim.keymap.set(
        'n', '<esc>',
        function() require('my_plugins.todo_float').close_todo_float() end, -- Direct Lua function
        { buffer = buf, silent = true, noremap = true, desc = 'Close TODO float (Esc)' }
    )


    vim.api.nvim_set_current_win(M.win_id)
    vim.api.nvim_set_current_buf(M.buf_id)
end

-- Toggle the TODO floating window
function M.toggle_todo_float()
    if is_win_valid() then
        M.close_todo_float()
    else
        M.open_todo_float()
    end
end

-- Setup function (optional, but good practice for extensibility)
function M.setup(opts)
    opts = opts or {}
    -- Add any configuration options for your plugin here if needed in the future
end

return M