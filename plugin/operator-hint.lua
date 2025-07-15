if vim.g.loaded_operator_hint then
  return
end
vim.g.loaded_operator_hint = 1

vim.api.nvim_create_user_command('OperatorHint', function()
  require('operator-hint').show_hints()
end, { desc = 'Show operator hints' })

vim.api.nvim_create_user_command('OperatorHintToggle', function()
  require('operator-hint').toggle_hints()
end, { desc = 'Toggle operator hints' })

vim.api.nvim_create_user_command('OperatorHintHide', function()
  require('operator-hint').hide_hints()
end, { desc = 'Hide operator hints' })