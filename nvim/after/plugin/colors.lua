function ColorMyPencils(color)
	color = color or "catppuccin-macchiato"
	vim.cmd.colorscheme(color)

	if (IS_BASH) then
		vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })
	end
end

ColorMyPencils()
