return {

	-- tmux integration
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		keys = {
			{ "<C-h>", "<cmd>TmuxNavigateLeft<CR>", "window left" },
			{ "<C-j>", "<cmd>TmuxNavigateUp<CR>", "window up" },
			{ "<C-k>", "<cmd>TmuxNavigateDown<CR>", "window down" },
			{ "<C-l>", "<cmd>TmuxNavigateRight<CR>", "window right" },
		},
	},

	-- vertical column
	{ "xiyaowong/virtcolumn.nvim" },

	-- string and hex color previews
	{ "norcalli/nvim-colorizer.lua" },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "norg", "rmd", "org", "Rmd" },
		opts = {
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
				style = "none",
				disable_background = true,
			},
			heading = {
				sign = false,
				icons = {},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
		end,
	},

	{
		"R-nvim/R.nvim",
		lazy = false,
		config = function()
			local opts = {

				bracketed_paste = true,
				-- external_term = "tmux split-window -h -l 70",

				R_args = { "--quiet", "--no-save" },

				pdfviewer = "xdg-open",

				quarto_chunk_hl = {
					highlight = false,
					bg = "#222222",
				},

				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
						vim.api.nvim_buf_set_keymap(0, "i", "fd", "<Plug>RInsertAssign", { noremap = true })
					end,
				},

				-- for vertical split
				min_editor_width = 72,
				rconsole_width = 80,

				-- -- for horizontal split
				-- rconsole_width = 0,
				-- rconsole_height = 40,

				disable_cmds = {
					"RClearConsole",
					"RCustomStart",
					"RSPlot",
					"RSaveClose",
				},
			}
			if vim.env.R_AUTO_START == "true" then
				opts.auto_start = 1
				opts.objbr_auto_start = true
			end
			require("r").setup(opts)
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp").setup({ sources = { { name = "cmp_r" } } })
			require("cmp_r").setup({})
		end,
	},

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
			filetypes = { "*" },
		},
	},
}
