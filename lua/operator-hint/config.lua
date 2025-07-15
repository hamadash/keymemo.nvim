local M = {}

M.defaults = {
	operators = {},
	timeout = 1000,
	show_delay = 300,
	ui = {
		border = "rounded",
		position = "center",
		min_width = 40,
		max_width = 80,
	},
}

M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

function M.get_hints()
	return M.options.operators
end

function M.get_timeout()
	return M.options.timeout
end

function M.get_show_delay()
	return M.options.show_delay
end

function M.get_ui_config()
	return M.options.ui
end

return M

