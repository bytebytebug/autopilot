
vim.api.nvim_create_user_command("Autopilot", function()
    print("Starting Autopilot.")

    require("autopilot.config").load()
end, {})
