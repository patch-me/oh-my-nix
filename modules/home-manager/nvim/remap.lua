vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)


vim.g.vimtex_view_method = 'zathura'


-- local lsp = require("lsp-zero")
--
-- lsp.preset("recommended")
--
--
-- -- Fix Undefined global 'vim'
-- local cmp = require("cmp")
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
--     ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
--     ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--     ["<C-Space>"] = cmp.mapping.complete(),
-- })
--
-- cmp_mappings["<Tab>"] = nil
-- cmp_mappings["<S-Tab>"] = nil
--
-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = "E",
--         warn = "W",
--         hint = "H",
--         info = "I",
--     },
-- })
--
-- lsp.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--
--     vim.keymap.set("n", "gd", function()
--         vim.lsp.buf.definition()
--     end, opts)
--     vim.keymap.set("n", "K", function()
--         vim.lsp.buf.hover()
--     end, opts)
--     vim.keymap.set("n", "<leader>vws", function()
--         vim.lsp.buf.workspace_symbol()
--     end, opts)
--     vim.keymap.set("n", "<leader>vd", function()
--         vim.diagnostic.open_float()
--     end, opts)
--     vim.keymap.set("n", "[d", function()
--         vim.diagnostic.goto_next()
--     end, opts)
--     vim.keymap.set("n", "]d", function()
--         vim.diagnostic.goto_prev()
--     end, opts)
--     vim.keymap.set("n", "<leader>vca", function()
--         vim.lsp.buf.code_action()
--     end, opts)
--     vim.keymap.set("n", "<leader>vrr", function()
--         vim.lsp.buf.references()
--     end, opts)
--     vim.keymap.set("n", "<leader>vrn", function()
--         vim.lsp.buf.rename()
--     end, opts)
--     vim.keymap.set("i", "<C-h>", function()
--         vim.lsp.buf.signature_help()
--     end, opts)
-- end)
--
-- lsp.setup()
--
-- vim.diagnostic.config({
--     virtual_text = true,
-- })
--
