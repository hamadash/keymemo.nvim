if vim.g.loaded_keymemo then
  return
end
vim.g.loaded_keymemo = 1

vim.api.nvim_create_user_command('KeyMemo', function()
  require('keymemo').show_hints()
end, { desc = 'Show key memo' })

vim.api.nvim_create_user_command('KeyMemoToggle', function()
  require('keymemo').toggle_hints()
end, { desc = 'Toggle key memo' })

vim.api.nvim_create_user_command('KeyMemoHide', function()
  require('keymemo').hide_hints()
end, { desc = 'Hide key memo' })