local M = {}

local ui = require('keymemo.ui')

function M.reset()
  ui.hide()
end

function M.setup_mappings()
  -- No automatic mappings needed for manual-only mode
end

return M