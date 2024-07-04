local telescope = require("telescope")
telescope.load_extensions("undo")
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
