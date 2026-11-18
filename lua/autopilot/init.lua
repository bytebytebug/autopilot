
local function initialize()
    local config = require("autopilot.config")

    config.load()
end


return {
    initialize = initialize
}
