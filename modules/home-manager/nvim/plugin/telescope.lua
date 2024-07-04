require('telescope').setup({
	extensions = {
    	fzf = {
      	fuzzy = true,                    -- false will only do exact matching
      	override_generic_sorter = true,  -- override the generic sorter
      	override_file_sorter = true,     -- override the file sorter
      	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    	},
        undo={
            side_by_side = true,
            layout_strategy = "horizontal",
            layout_config = {
            preview_height = 0.8,
        },
      },
  	},
})
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

require('telescope').load_extension('fzf')
require('telescope').load_extension('undo')
