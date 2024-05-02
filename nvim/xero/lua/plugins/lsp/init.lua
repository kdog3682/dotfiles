return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local remaps = require("plugins.lsp.remaps")
		local icons = require("utils.icons")

		local function on_attach(client, bufnr)
			remaps.set_default_on_buffer(client, bufnr)
		end

		local border = {
			border = "shadow",
		}
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, border)
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)

		local capabilities
		capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			lua_ls = require("plugins.lsp.servers.luals")(on_attach),
			tsserver = require("plugins.lsp.servers.tsserver")(on_attach),
			typst_lsp = require("plugins.lsp.servers.typstlsp")(on_attach),
			volar = require("plugins.lsp.servers.volar")(on_attach),
		}

		local default_lsp_config = {
			on_attach = on_attach,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 200,
				allow_incremental_sync = true,
			},
		}

		local server_names = {}
		for server_name, _ in pairs(servers) do
			table.insert(server_names, server_name)
		end

		local present_mason, mason = pcall(require, "mason-lspconfig")
		if present_mason then
			mason.setup({ ensure_installed = server_names })
		end

		for server_name, server_config in pairs(servers) do
			local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_config)
			lspconfig[server_name].setup(merged_config)
		end
	end,
}
