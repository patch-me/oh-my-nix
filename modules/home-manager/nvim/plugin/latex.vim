local g = vim.g
g.vimtex_view_method = "zathura"
g.vimtex_view_method = "zathura_simple"
g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex" }
g.vimtex_compiler_latexmk = {
    aux_dir = ".build",
    -- out_dir = "",
    options = {
	    "-shell-escape",
        "-verbose",
	    "-file-line-error",
	    "-synctex=1",
	    "-interaction=nonstopmode",
	},
}

