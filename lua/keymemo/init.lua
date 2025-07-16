local M = {}

local config = require("keymemo.config")
local ui = require("keymemo.ui")
local mappings = require("keymemo.mappings")

function M.setup(opts)
	config.setup(opts)
	mappings.setup_mappings()
end

function M.show_memos()
	local memos = config.get_memos()
	ui.show(memos)
end

function M.hide_memos()
	ui.hide()
	mappings.reset()
end

function M.toggle_memos()
	if ui.is_visible() then
		M.hide_memos()
	else
		M.show_memos()
	end
end

return M
