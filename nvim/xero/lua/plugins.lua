local pluginspath = vim.fn.stdpath("data") .. "/lazy"
local lazypath = pluginspath .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print("lazy just installed, please restart neovim")
	return
end

-- install plugins
lazy.setup({
	spec = {
		require("plugins.miasma"),
		require("plugins.luasnip"),
		require("plugins.which-key"),
		require("plugins.treesitter"),
		require("plugins.mason"),
		require("plugins.lsp"),
		require("plugins.cmp"),
		require("plugins.comments"),
		require("plugins.surround"),
		require("plugins.fzf"),
		require("plugins.devicons"),
	},
	dev = {
		path = "~/.local/src",
	},
	lockfile = vim.fn.stdpath("config") .. "/lua/plugins/lazy-lock.json",
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "shadow",
		icons = require("utils.icons").lazy,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
