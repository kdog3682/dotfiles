-- require("general")
-- require("ui")
-- require("commands")

local plugins = {
	"fzf",
	"nvim-tree",
	"dressing",

	-- "cmp",
	-- "luasnip",
}

require("kdog3682.lazy-plugin-loader")(plugins)
require("kdog3682.hide_diagnostics")

-- operates via AutoCmd
require("kdog3682.disable_newline_comments")
require("kdog3682.unmap_brackets")
