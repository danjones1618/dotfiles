vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		local fzf = require("fzf-lua")

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("[g", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Go to previous diagnostic item")
		map("]g", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Go to next diagnostic item")
		map("<leader>gs", vim.lsp.buf.signature_help, "Signature Documentation")
		map("<leader>gd", fzf.lsp_declarations, "Goto Declaration")
		map("<leader>gr", fzf.lsp_references, "Goto refrences")
		map("<leader>gf", fzf.lsp_finder, "All LSP locations combined view")
		map("<leader>gi", fzf.lsp_implementations, "Goto implementions")
		map("<leader>gy", fzf.lsp_typedefs, "Goto type definitions")
		map("<leader>a", fzf.lsp_code_actions, "Code Action")
		map("<leader>d", fzf.lsp_document_diagnostics, "Document diagnostics")
		map("<leader>D", fzf.lsp_workspace_diagnostics, "Workspace diagnostics")
		map("<leader>o", fzf.lsp_document_symbols, "Document symbols")
		map("<leader>O", fzf.lsp_workspace_symbols, "Worksapce symbols")
		-- map("<leader>gd", vim.lsp.buf.declaration, "Goto Declaration")
		-- map("<leader>a", vim.lsp.buf.code_action, "Code Action")
		-- map("<leader>rn", vim.lsp.buf.rename, "Rename all references")
		map("<leader>rn", require("renamer").rename, "Rename all references")
		map("<leader>lf", vim.lsp.buf.format, "Format")
		map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client.supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			-- When cursor stops moving: Highlights all instances of the symbol under the cursor
			-- When cursor moves: Clears the highlighting
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- When LSP detaches: Clears the highlighting
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function(args)
--         require("conform").format({ bufnr = args.buf })
--     end
-- })
