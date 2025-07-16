if vim.g.loaded_keymemo then
	return
end
vim.g.loaded_keymemo = 1

vim.api.nvim_create_user_command("KeyMemo", function()
	require("keymemo").show_memos()
end, { desc = "Show key memo" })

vim.api.nvim_create_user_command("KeyMemoToggle", function()
	require("keymemo").toggle_memos()
end, { desc = "Toggle key memo" })

vim.api.nvim_create_user_command("KeyMemoHide", function()
	require("keymemo").hide_memos()
end, { desc = "Hide key memo" })
