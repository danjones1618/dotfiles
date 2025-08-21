return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			integrations = {
				coc_nvim = true,
				indent_blankline = {
					enabled = true,
					scope_color = "mauve",
					colored_indent_levels = false,
				},
				vim_sneak = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = false,
					},
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
			},
			inactive_sections = {
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {},
	},
	{
		"mrded/nvim-lsp-notify",
		dependencies = {
			"rcarriga/nvim-notify",
		},
		config = function()
			require("lsp-notify").setup({
				notify = require("notify"),
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			"fzf-native",
			grep = {
				no_esc = true,
				rg_glob = false,
				rg_glob_fn = function(query, opts)
					local regex, flags = query:match("^(.-)%s%-%-(.*)$")
					return (regex or query), flags
				end,
			},
		},
	},
}
