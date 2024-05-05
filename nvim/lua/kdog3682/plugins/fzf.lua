return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>/c",
			function()
				require("fzf-lua").commands()
			end,
			desc = "Search commands",
		},
		{
			"<leader>/C",
			function()
				require("fzf-lua").command_history()
			end,
			desc = "Search command history",
		},
		{
			"<leader>/f",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find files",
		},
		{
			"<leader>/o",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "Find files",
		},
		{
			"<leader>/h",
			function()
				require("fzf-lua").highlights()
			end,
			desc = "Search highlights",
		},
		{
			"<leader>/M",
			function()
				require("fzf-lua").marks()
			end,
			desc = "Search marks",
		},
		{
			"<leader>/k",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Search keymaps",
		},
		{
			"<leader>/t",
			function()
				require("fzf-lua").treesitter()
			end,
			desc = "Search treesitter",
		},
		{
			"<leader>/gf",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "Find git files",
		},
		{
			"<leader>/gb",
			function()
				require("fzf-lua").git_branches()
			end,
			desc = "Search git branches",
		},
		{
			"<leader>/gc",
			function()
				require("fzf-lua").git_commits()
			end,
			desc = "Search git commits",
		},
		{
			"<leader>/gC",
			function()
				require("fzf-lua").git_bcommits()
			end,
			desc = "Search git buffer commits",
		},
		{
			"<leader>bc",
			function()
				require("fzf-lua").git_bcommits()
			end,
			desc = "Search git buffer commits",
		},
		{
			"<leader>//",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume FZF",
		},
	},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			keymap = {
				fzf = {
					["CTRL-Q"] = "select-all+accept",
				},
				fzf_layout = {
					window = {
						width = 0.9,
						height = 0.9,
						highlight = "Comment",
					},
					preview = {
						hidden = "ctrl-/",
					},
				},
				fzf_preview = {
					preview = "head {} -n 100",
					preview_batched_files = true,
					resources = {
						"relative:1", -- show only basename of relative paths
					},
					files_trailing_ellipsis = true,
					hide_leading_characters_count = 1,
				},
				fzf_opts = {
					["--layout"] = "reverse",
				},
			},
		})
		fzf.register_ui_select()
	end,
}
