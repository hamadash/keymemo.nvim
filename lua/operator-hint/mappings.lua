local M = {}

local config = require('operator-hint.config')
local ui = require('operator-hint.ui')

local timer = nil
local current_operator = nil
local pending_keys = ""

local function clear_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

local function start_hint_timer()
  clear_timer()
  
  timer = vim.loop.new_timer()
  timer:start(config.get_show_delay(), 0, vim.schedule_wrap(function()
    if current_operator then
      local hints = config.get_hints()
      if hints[current_operator] then
        ui.show({ [current_operator] = hints[current_operator] })
      end
    end
  end))
end

local function start_timeout_timer()
  local timeout_timer = vim.loop.new_timer()
  timeout_timer:start(config.get_timeout(), 0, vim.schedule_wrap(function()
    M.reset()
    timeout_timer:close()
  end))
end

local function handle_operator_input(operator)
  current_operator = operator
  pending_keys = operator
  start_hint_timer()
  start_timeout_timer()
end

local function handle_motion_input(motion)
  if current_operator then
    local full_mapping = pending_keys .. motion
    pending_keys = full_mapping
    
    local hints = config.get_hints()
    if hints[current_operator] and hints[current_operator].mappings[full_mapping] then
      M.reset()
      return full_mapping
    elseif string.len(pending_keys) > 10 then
      M.reset()
    end
  end
  return motion
end

function M.reset()
  clear_timer()
  ui.hide()
  current_operator = nil
  pending_keys = ""
end

function M.setup_mappings()
  local hints = config.get_hints()
  
  for operator, _ in pairs(hints) do
    if operator ~= "<C-w>" then
      vim.keymap.set('n', operator, function()
        handle_operator_input(operator)
        return operator
      end, { expr = true, silent = true, desc = "Operator hint: " .. operator })
    else
      vim.keymap.set('n', '<C-w>', function()
        handle_operator_input('<C-w>')
        return '<C-w>'
      end, { expr = true, silent = true, desc = "Window operator hint" })
    end
  end
  
  local motions = { 'w', 'e', 'b', '$', '0', '^', 'g', 'G', 'h', 'j', 'k', 'l', 'f', 't', 'F', 'T', 
                   '(', ')', '{', '}', '[', ']', 'i', 'a', 'd', 'y', 'c', 'p', 'P', 's', 'v', 'q' }
  
  for _, motion in ipairs(motions) do
    vim.keymap.set('n', motion, function()
      local result = handle_motion_input(motion)
      return result
    end, { expr = true, silent = true })
  end
  
  vim.keymap.set('n', '<Esc>', function()
    M.reset()
    return '<Esc>'
  end, { expr = true, silent = true })
end

return M