local M = {}

local config = require('operator-hint.config')
local ui = require('operator-hint.ui')
local mappings = require('operator-hint.mappings')

function M.setup(opts)
  config.setup(opts)
  mappings.setup_mappings()
end

function M.show_hints()
  local hints = config.get_hints()
  ui.show(hints)
end

function M.hide_hints()
  ui.hide()
  mappings.reset()
end

function M.toggle_hints()
  if ui.is_visible() then
    M.hide_hints()
  else
    M.show_hints()
  end
end

return M