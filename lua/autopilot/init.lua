
local function initialize()
    local config_manager_mod = require("autopilot.config_manager")

    local config_manager = config_manager_mod.create_with_default_config()

    config_manager:load()
end


return {
    initialize = initialize
}
