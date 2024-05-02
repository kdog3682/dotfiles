return {
	"williamboman/mason.nvim",
	build = ":MasonInstallAll",
	config = function()
		local f = require("utils.functions")
		require("mason").setup({
			ui = {
				border = "shadow",
				icons = require("utils.icons").mason,
				zindex = 99,
			},
		})
		f.cmd("MasonInstallAll", function()
			vim.cmd('MasonUpdate')
			local ensure_installed = {
				"lua-language-server",
				"typescript-language-server",
				"yaml-language-server",
				"typst-lsp",
			}
			vim.cmd('MasonInstall ' .. table.concat(ensure_installed, ' '))
		end, { desc = "install all lsp tools" })
	end,
}
