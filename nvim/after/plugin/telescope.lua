require('telescope').setup{
	defaults = {
		path_display={"smart"}
	},
	pickers = {
		lsp_definitions = {
			file_ignore_patterns = { "%.d.ts" }
		}
	}
}

-- require('telescope').load_extension('fzf')

