local util = require 'lspconfig.util'
return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.document_formatting = true
		end,
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"typescript",
		},
		init_options = {
			hostInfo = "neovim",
		},
		root_dir = util.find_node_modules_ancestor,
		single_file_support = true,
	}
end
