return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "ruff format", "ruff check --select I --fix" },
			rust = { "rustfmt", lsp_format = "fallback" },
			lua = { "stylua" },
			toml = { "taplo format" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
