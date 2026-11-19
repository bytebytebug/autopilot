
local ConfigManagerBehavior = {}


function ConfigManagerBehavior.load(self)
    print("Loading config.")

    vim.opt.number = self.opt.number
    vim.opt.relativenumber = self.opt.relativenumber
    vim.opt.completeopt = self.opt.completeopt
    vim.opt.list = self.opt.list
    vim.opt.listchars = self.opt.listchars
    vim.opt.breakindent = self.opt.breakindent
    vim.opt.showbreak = self.opt.showbreak
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
        list = true,
        listchars = {
            eol = vim.fn.nr2char(0x240D),
        },
        breakindent = true,
        showbreak = vim.fn.nr2char(0x21B3),
    }

    return create(opt)
end


return {
    create = create,
    create_with_default_config = create_with_default_config,
}
