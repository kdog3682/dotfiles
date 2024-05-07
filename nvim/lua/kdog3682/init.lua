-- require("general")
-- require("ui")
-- require("commands")

local plugins = {
	"fzf",
	"nvim-tree",
	"dressing",
}

require("kdog3682.plugin_loader")(plugins)
require("kdog3682.hide_diagnostics")
require("kdog3682.disable_newline_comments")
require("kdog3682.unmap_brackets")
