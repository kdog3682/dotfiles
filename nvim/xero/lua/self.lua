-- Custom filetype detection logic with the new Lua filetype plugin
vim.filetype.add({
	extension = {
		png = "image",
		jpg = "image",
		jpeg = "image",
		gif = "image",
		es6 = "javascript",
		mts = "typescript",
		cts = "typescript",
		typ = "typst",
		vue = "vue",
	},
	filename = {
		[".eslintrc"] = "json",
		[".prettierrc"] = "json",
		[".babelrc"] = "json",
		[".stylelintrc"] = "json",
	},
	pattern = {
		[".*config/git/config"] = "gitconfig",
		[".env.*"] = "sh",
	},
})

local function hide_diagnostics()
	vim.diagnostic.config({ -- https://neovim.io/doc/user/diagnostic.html
		virtual_text = false,
		signs = false,
		underline = false,
	})
end

hide_diagnostics()

vim.keymap.set("n", "1", ":e ~/abc.js<CR>", { noremap = true })
vim.keymap.set("n", "2", ":e ~/abc.typ<CR>", { noremap = true })
vim.keymap.set("n", "3", ":e ~/abc.vue<CR>", { noremap = true })
vim.keymap.set("n", "4", ":e ~/abc.ts<CR>", { noremap = true })
vim.keymap.set("n", "5", ":e ~/def.ts<CR>", { noremap = true })
vim.keymap.set("n", "q", ":q<cr>", { noremap = true })
vim.keymap.set("n", "s", ":update<cr>", { noremap = true })
vim.keymap.set("n", "0", ":update<cr>", { noremap = true })

