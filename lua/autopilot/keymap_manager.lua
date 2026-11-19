
local KeyMapManagerBehavior = {}


function KeyMapManagerBehavior.load(self)
    vim.keymap.set("i", "<S-Tab>", "    ", {
        noremap = true,
        silent = true,
        desc = "Insert 4 spaces",
    })
end


local KeyMapManagerMetabase = {}


function KeyMapManagerMetabase.__index(self, key)
	return KeyMapManagerBehavior[key]
end


local function create()
    local self = setmetatable({}, KeyMapManagerMetabase)

    return self
end


return {
    create = create
}
