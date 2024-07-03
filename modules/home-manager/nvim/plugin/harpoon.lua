local harpoon = require("harpoon")

-- REQUIRED
harpoon.setup{
    mapping = harpoon.mapping.preset.insert {
        ["<leader>a"]= harpoon.list().add(),
        ["<C-e>"]= harpoon.ui.toggle_quick_menu(harpoon:list())

        -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
        --
        -- -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    },
}

