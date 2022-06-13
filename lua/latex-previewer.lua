local function get_first_line()
    -- test
    local tbl = vim.api.nvim_buf_get_lines(0, 0, 1, false)
    local first_line = tbl[1]
    if tbl[0] ~= nil then
        first_line = tbl[0]
    else
        first_line = tbl[1]
    end
    -- print(vim.pretty_print(first_line))
    return first_line
end

local function preview()
    if vim.bo.filetype == "tex" or vim.bo.filetype == "plaintex" then
        local first_line = get_first_line()
        local start_idx = string.find(first_line, "<")
        local end_idx = string.find(first_line, ">")
        if start_idx ~= nil and end_idx ~= nil then
            local name_main_tex = string.sub(first_line, start_idx + 1,
                                             end_idx - 1 - 4)
            local pdf_name = name_main_tex .. ".pdf"
            local r, c = unpack(vim.api.nvim_win_get_cursor(0))
            local position = r .. ":" .. c .. ":" .. vim.fn.expand("%:p")
            local command = string.format(
                                "zathura -x 'nvr --remote +%%{line} %%{input}' --synctex-forward %s %s",
                                position, pdf_name)
            vim.fn.jobstart(command)
        else
            print("insert magic comment to this file")
        end
    end
end
return {get_first_line = get_first_line, preview = preview}
