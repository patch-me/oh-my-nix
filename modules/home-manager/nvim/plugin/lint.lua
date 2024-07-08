local lint = require("lint")

-- local function get_file_name()
--   return vim.api.nvim_buf_get_name(0)
-- end
--
-- require('lint').linters.rupp{
--   cmd = "ruff",
--   stdin = true,
--   args = {
--     "check",
--     "--force-exclude",
--     "--quiet",
--     "--extend-select",
--     "ALL",
--     "--stdin-filename",
--     get_file_name,
--     "--no-fix",
--     "--output-format",
--     "json",
--     "-",
--   },
--   ignore_exitcode = true,
--   stream = "stdout",
--   parser = function(output)
--     local diagnostics = {}
--     local ok, results = pcall(vim.json.decode, output)
--     if not ok then
--       return diagnostics
--     end
--     for _, result in ipairs(results or {}) do
--       local diagnostic = {
--         message = result.message,
--         col = result.location.column - 1,
--         end_col = result.end_location.column - 1,
--         lnum = result.location.row - 1,
--         end_lnum = result.end_location.row - 1,
--         code = result.code,
--         severity = severities[result.code] or vim.diagnostic.severity.WARN,
--         source = "ruff",
--       }
--       table.insert(diagnostics, diagnostic)
--     end
--     return diagnostics
--   end,
-- },

lint.linters_by_ft = {
	python = { "ruff" },
	c = { "cpplint" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})
