
local LspManagerBehavior = {}


function LspManagerBehavior.load(self)
    self:register()
    self:activate()
end


function LspManagerBehavior.register(self)
    self:register_rust_lsp()
    self:register_typescript_lsp()

    self:register_lsp_hover_cmd()
    self:register_lsp_info_cmd()
    self:register_lsp_diagnostic_cmd()

    self:register_lsp_attach_autocmd()
end


function LspManagerBehavior.activate(self)
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("typescript_lsp")
end


function LspManagerBehavior.register_rust_lsp(self)
    vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = {
            "Cargo.toml",
            ".git",
        },
    })
end


function LspManagerBehavior.register_typescript_lsp(self)
    vim.lsp.config("typescript_lsp", {
        cmd = {
            "typescript-language-server",
            "--stdio",
        },
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_markers = {
            "tsconfig.json",
            "package.json",
            ".git",
        },
    })
end


function LspManagerBehavior.register_lsp_hover_cmd(self)
    vim.api.nvim_create_user_command("LspHover", function()
        vim.lsp.buf.hover()
    end, {})
end


function LspManagerBehavior.register_lsp_diagnostic_cmd(self)
    vim.api.nvim_create_user_command("LspDiagnostic", function()
      vim.diagnostic.open_float()
    end, {})
end


function LspManagerBehavior.register_lsp_info_cmd(self)
    vim.api.nvim_create_user_command("LspInfo", function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })

        if #clients == 0 then
            print("No LSP attached to current buffer")
            return
        end

        for i, client in ipairs(clients) do
            print(string.format(
                "Active LSPs: %d.",
                #clients
            ))
            print(string.format(
                "LSP %d: id=%d, name=%s.",
                i,
                client.id,
                client.name
            ))
        end
    end, {})
end


function LspManagerBehavior.register_lsp_attach_autocmd(self)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)

            vim.lsp.completion.enable(true, client.id, ev.buf, {
              autotrigger = true,
            })
        end,
    })
end


local LspManagerMetatable = {}


function LspManagerMetatable.__index(self, key)
    return LspManagerBehavior[key]
end


local function create()
    local lsp_manager = {}
    setmetatable(lsp_manager, LspManagerMetatable)

    return lsp_manager
end


return {
    create = create
}
