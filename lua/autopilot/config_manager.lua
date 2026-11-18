
local ConfigManagerBehavior = {}


function ConfigManagerBehavior.load(self)
    print("Loading config.")

    vim.opt.number = self.opt.number
    vim.opt.relativenumber = self.opt.relativenumber
    vim.opt.completeopt = self.opt.completeopt
end


local ConfigManagerMetatable = {}


function ConfigManagerMetatable.__index(self, key)
	return ConfigManagerBehavior[key]
end


local function create(opt)
    local config = {
        opt = opt
    }

    return setmetatable(config, ConfigManagerMetatable)
end


local function create_with_default_config()
    local opt = {
        number = true,
        relativenumber = true,
        completeopt = {
          "menu",
          "menuone",
          "noinsert",
          "noselect",
        },
    }

    return create(opt)
end


return {
    create = create,
    create_with_default_config = create_with_default_config,
}
