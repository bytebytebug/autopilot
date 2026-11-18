
local function initialize()
    local config_manager_mod = require("autopilot.config_manager")
    local lsp_manager_mod = require("autopilot.lsp_manager")

    local config_manager = config_manager_mod.create_with_default_config()
    local lsp_manager = lsp_manager_mod.create()

    config_manager:load()
    lsp_manager:load()
end


return {
    initialize = initialize
}
