vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, { desc = "Disable autoformat on save (bang = this buffer)", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function(args)
	if args.bang then
		vim.b.disable_autoformat = false
	else
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	end
end, { desc = "Enable autoformat on save (bang = this buffer)", bang = true })
