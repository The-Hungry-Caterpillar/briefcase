-- ~/.config/nvim/lua/plugins/markdownlint.lua
return {
	"mfussenegger/nvim-lint",
	opts = {
		linters_by_ft = {
			markdown = {}, -- disable markdown linting
		},
	},
}
