local M = {}

local config = require("keymemo.config")

local popup_win = nil
local popup_buf = nil

local function close_popup()
	if popup_win and vim.api.nvim_win_is_valid(popup_win) then
		vim.api.nvim_win_close(popup_win, true)
	end
	if popup_buf and vim.api.nvim_buf_is_valid(popup_buf) then
		vim.api.nvim_buf_delete(popup_buf, { force = true })
	end
	popup_win = nil
	popup_buf = nil
end

local function format_memos(memos)
	local lines = {}
	local max_key_width = 0

	for key, memo in pairs(memos) do
		if memo.mappings then
			for mapping, desc in pairs(memo.mappings) do
				max_key_width = math.max(max_key_width, #mapping)
			end
		end
	end

	for key, memo in pairs(memos) do
		if memo.mappings then
			table.insert(lines, string.format(" %s - %s ", key, memo.name))
			table.insert(lines, string.rep("─", #lines[#lines] + 10))

			for mapping, desc in pairs(memo.mappings) do
				local padding = string.rep(" ", max_key_width - #mapping)
				table.insert(lines, string.format(" %s%s  %s", mapping, padding, desc))
			end
			table.insert(lines, "")
		end
	end

	if #lines > 0 then
		table.remove(lines)
	end

	return lines
end

local function calculate_popup_size(lines)
	local ui_config = config.get_ui_config()
	local max_width = 0

	for _, line in ipairs(lines) do
		max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
	end

	local width = math.max(ui_config.min_width, math.min(max_width + 4, ui_config.max_width))
	local height = #lines

	return width, height
end

function M.show(memos)
	M.hide()

	local lines = format_memos(memos)
	if #lines == 0 then
		return
	end

	local width, height = calculate_popup_size(lines)
	local ui_config = config.get_ui_config()

	popup_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(popup_buf, "modifiable", false)
	vim.api.nvim_buf_set_option(popup_buf, "bufhidden", "wipe")

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = (vim.o.columns - width) / 2,
		row = (vim.o.lines - height) / 2 - 2,
		style = "minimal",
		border = ui_config.border,
		title = " Key Memo ",
		title_pos = "center",
	}

	popup_win = vim.api.nvim_open_win(popup_buf, true, opts)

	vim.api.nvim_win_set_option(popup_win, "winhl", "Normal:Normal,FloatBorder:FloatBorder")

	vim.api.nvim_buf_set_keymap(
		popup_buf,
		"n",
		"<Esc>",
		'<cmd>lua require("keymemo").hide_memos()<CR>',
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		popup_buf,
		"n",
		"q",
		'<cmd>lua require("keymemo").hide_memos()<CR>',
		{ noremap = true, silent = true }
	)
end

function M.hide()
	close_popup()
end

function M.is_visible()
	return popup_win ~= nil and vim.api.nvim_win_is_valid(popup_win)
end

return M
