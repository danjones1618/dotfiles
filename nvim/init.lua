require("config.lazy")
require("config.base_vim")
require("core.lsp")
require("config.keymaps")
require("config.autocmds")
require("config.global_cmds")
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"python",
		"rust",
		"c",
		"cpp",
		"cmake",
		"make",
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"go",
		"gotmpl",
		"hcl",
		"markdown",
		"markdown_inline",
		"nginx",
		"typst",
		"yang",
		"xml",
		"ssh_config",
		"sql",
		"toml",
	},
	highlight = {
		enabled = true,
		additional_vim_regex_highlighting = false,
	},
})
require("treesitter-context").setup()
require("fzf-lua").setup_fzfvim_cmds()
require("nvim-rooter").setup({
	rooter_patterns = { ".git", "=nvim" },
	tirgger_patterns = { "*" },
	manual = false,
	fallback_to_parent = false,
	cd_scope = "global",
})
require("nvim-tmux-navigation").setup({
	disabled_when_zoomed = false,
	keybindings = {
		left = "<C-h>",
		down = "<C-j>",
		up = "<C-k>",
		right = "<C-l>",
		last_active = "<C-\\>",
		next = "<C-space>",
	},
})

vim.notify = require("notify")

vim.lsp.enable({ "taplo" })
