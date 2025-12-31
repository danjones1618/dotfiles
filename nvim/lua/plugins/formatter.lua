local web_formatting = { "biome-organize-iumports", "biome-check", "biome" }
return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "ruff_organize_imports", "ruff_format" },
			rust = { "rustfmt", lsp_format = "fallback" },
			lua = { "stylua" },
			toml = { "taplo" },
			javascript = web_formatting,
			javascriptreact = web_formatting,
			typescript = web_formatting,
			typescriptreact = web_formatting,
			json = web_formatting,
			css = web_formatting,
			html = web_formatting,
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
