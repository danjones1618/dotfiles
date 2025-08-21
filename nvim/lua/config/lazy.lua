-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "nvim-treesitter/nvim-treesitter", lazy = false },
		{ "nvim-treesitter/nvim-treesitter-context", lazy = false },
		{ "tpope/vim-sensible" },
		{ "tpope/vim-fugitive" },
		{ "tpope/vim-commentary" },
		{ "tpope/vim-surround" },
		{ "tpope/vim-speeddating" },
		{ "tpope/vim-repeat" },
		{ "tpope/vim-unimpaired" },
		{ "notjedi/nvim-rooter.lua", lazy = false },
		{ "lewis6991/gitsigns.nvim" },
		{ "justinmk/vim-sneak" },
		{ "alexghergh/nvim-tmux-navigation" },
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
		{
			"zakissimo/smoji.nvim",
			cmd = "Smoji",
			keys = {
				{ "<leader><leader>e", "<cmd>Smoji<cr>", desc = "Git[e]moji" },
				{ "<C-e", "<cmd>Smoji<cr>", desc = "Git[e]moji", mode = "i" },
				{ "<C-e", "<cmd>Smoji<cr>", desc = "Git[e]moji", mode = "t" },
			},
			config = function()
				require("fzf-lua").register_ui_select()
				require("smoji")
			end,
		},
		{
			"nvim-tree/nvim-tree.lua",
			lazy = false,
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("nvim-tree").setup({})
			end,
		},
		{
			"mason-org/mason.nvim",
			lazy = false,
			opts = {},
		},
		{ "neovim/nvim-lspconfig" },
		{
			"mason-org/mason-lspconfig.nvim",
			lazy = false,
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
			opts = {
				ensure_installed = {
					"rust_analyzer",
				},
			},
		},
		{
			"filipdutescu/renamer.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {},
			event = "LspAttach",
		},
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin-mocha" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
