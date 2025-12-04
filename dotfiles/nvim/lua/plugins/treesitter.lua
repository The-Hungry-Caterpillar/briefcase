-- lua/plugins/treesitter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	-- LazyVim already sets up most defaults; we just override ensure_installed
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"json",
			"lua",
			"latex",
			"markdown",
			"markdown_inline",
			"python",
			"r",
			"rnoweb",
			"vim",
			"yaml",
		},
	},
}
