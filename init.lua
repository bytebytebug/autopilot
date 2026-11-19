
vim.api.nvim_create_user_command("Autopilot", function()
    local autopilot = require("autopilot")

    autopilot.initialize()
    
end, {})
