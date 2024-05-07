local plugins = {
	"fzf",
	"nvim-tree",
	-- "treesitter",
    -- "whichkey",
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
}

utils = require("kdog3682.functions.utils")

lockfilepath = vim.fn.stdpath("config") .. "/lua/plugins/lazy-lock.json"
local devpath = "~/.local/src"
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

function loader(plugins)
	local disabled = {
		"gzip",
		"netrwPlugin",
		"tarPlugin",
		"tohtml",
		"tutor",
		"zipPlugin",
	}

	function callback(plugin)
		return require("kdog3682.plugins." .. plugin)
	end
	lazy.setup({
		spec = utils.map(plugins, callback),
		dev = {
			path = devpath,
		},
		lockfile = lockfilepath,
		defaults = {
			lazy = false,
			version = nil,
		},
		checker = {
			enabled = false,
			notify = false,
			frequency = 86400,
		},
		change_detection = {
			enabled = aflse,
			notify = false,
		},
		ui = {
			size = { width = 0.8, height = 0.8 },
			wrap = true,
			border = "shadow",
		},
		performance = {
			cache = {
				enabled = true,
			},
			reset_packpath = true,
			rtp = {
				disabled_plugins = disabled,
			},
		},
	})
end

loader(plugins)
