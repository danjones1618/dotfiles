return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "ruff_organize_imports", "ruff_format" },
			rust = { "rustfmt", lsp_format = "fallback" },
			lua = { "stylua" },
			toml = { "taplo" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
