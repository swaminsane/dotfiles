vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    package.loaded["theme"] = nil
    package.loaded["theme_apply"] = nil
    require("theme_apply")
  end,
})
