local function hide_diagnostics()
	vim.diagnostic.config({ -- https://neovim.io/doc/user/diagnostic.html
		virtual_text = false,
		signs = false,
		underline = false,
	})
end

hide_diagnostics()
