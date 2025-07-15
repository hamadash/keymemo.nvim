local M = {}

local config = require("keymemo.config")
local ui = require("keymemo.ui")
local mappings = require("keymemo.mappings")

function M.setup(opts)
	config.setup(opts)
	mappings.setup_mappings()
end

function M.show_memo_list()
	local memo_list = config.get_memo_list()
	ui.show(memo_list)
end

function M.hide_memo_list()
	ui.hide()
	mappings.reset()
end

function M.toggle_memo_list()
	if ui.is_visible() then
		M.hide_memo_list()
	else
		M.show_memo_list()
	end
end

return M

