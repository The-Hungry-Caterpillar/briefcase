-- ~/.config/nvim/lua/plugins/conform-r.lua
return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			r = { "styler" }, -- use R's styler
		},
	},
}
