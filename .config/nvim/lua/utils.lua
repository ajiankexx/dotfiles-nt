local M = {}

local map = vim.keymap

--- Return if rime_ls should be disabled in current context
function M.rime_ls_disabled(context)
    local line = context.line
    local cursor_column = context.cursor[2]
    for _, pattern in ipairs(vim.g.disable_rime_ls_pattern) do
        local start_pos = 1
        while true do
            local match_start, match_end = string.find(line, pattern, start_pos)
            if not match_start then
                break
            end
            if cursor_column >= match_start and cursor_column < match_end then
                return true
            end
            start_pos = match_end + 1
        end
    end
    return false
end

--- @param keys string
--- @param mode string
function M.feedkeys(keys, mode)
    local termcodes = vim.api.nvim_replace_termcodes(keys, true, true, true)
    vim.api.nvim_feedkeys(termcodes, mode, false)
end

--- @param callback function
--- @return function function():boolean always return true
function M.always_true_wrapper(callback)
    return function()
        callback()
        return true
    end
end

--- @return boolean
function M.has_root_directory()
    if vim.g.root_markers == nil then
        return false
    end
    return vim.fs.root(0, vim.g.root_markers) ~= nil
end

--- Return the root directory of current buffer by vim.g.root_markers
--- If the root directory is not found, return vim.fn.getcwd()
--- @return string
function M.get_root_directory()
    if vim.g.root_markers == nil then
        return vim.fn.getcwd()
    end
    return vim.fs.root(0, vim.g.root_markers) or vim.fn.getcwd()
end

--- Return whether the buffer is visible
--- @param buf number|nil default 0 for current buffer
function M.is_visible_buffer(buf)
    buf = buf or 0
    return vim.api.nvim_buf_is_valid(buf) and
        vim.api.nvim_get_option_value('buflisted', { buf = buf })
end

--- Return whether the buffer is empty
--- @param buf number|nil default 0 for current buffer
function M.is_empty_buffer(buf)
    buf = buf or 0
    return vim.api.nvim_buf_line_count(buf) and
        vim.api.nvim_buf_get_lines(buf, 0, 1, true)[1] == ""
end

--- Set a map with rhs
--- @param mode string|string[]
--- @param lhs string
--- @param rhs string|function
--- @param opts? table default: { silent = true, remap = false }
function M.map_set(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', { silent = true, remap = false }, opts or {})
    map.set(mode, lhs, rhs, opts)
end

--- Delete a map by lhs
--- @param mode string|string[] the mode to delete
--- @param lhs string the key to delete
--- @param opts? { buffer: integer|boolean }
function M.map_del(mode, lhs, opts)
    map.del(mode, lhs, opts)
end

return M
