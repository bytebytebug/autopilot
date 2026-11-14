local M = {}

function M.load()
    print("Loading config.")

    vim.opt.number = true
    vim.opt.relativenumber = true
end

return M
