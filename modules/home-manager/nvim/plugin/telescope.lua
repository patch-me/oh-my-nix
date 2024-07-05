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
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = {"png", "webp", "jpg", "jpeg"},
            -- find command (defaults to `fd`)
            find_cmd = "rg"
        },
        live_grep_args = {
            auto_quoting = true,
        }
        -- file_browser = {
        --     theme = "ivy",
        --     -- disables netrw and use telescope-file-browser in its place
        --     hijack_netrw = true,
        --     mappings = {
        --         ["i"] = {
        --             -- your custom insert mode mappings
        --         },
        --         ["n"] = {
        --             -- your custom normal mode mappings
        --         },
        --     },
        -- },
    },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('undo')
require('telescope').load_extension('vim_bookmarks')
require('telescope').load_extension('media_files')
require("telescope").load_extension("file_browser")
require("telescope").load_extension('hoogle')
require("telescope").load_extension("live_grep_args")


local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
