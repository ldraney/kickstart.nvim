-- Auto-reload configuration for external file changes
return {
  {
    "auto-reload",
    name = "auto-reload",
    virtual = true,
    lazy = false,
    config = function()
      -- Enable autoread to detect when a file changes outside of nvim
      vim.o.autoread = true

      -- Create an autocommand group for auto-reload functionality
      local group = vim.api.nvim_create_augroup("auto_reload", { clear = true })

      -- Check for file changes on common trigger events
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained", "BufEnter" }, {
        group = group,
        pattern = "*",
        callback = function()
          pcall(vim.cmd, "checktime")
        end,
      })

      -- Notify when file is reloaded due to external changes
      vim.api.nvim_create_autocmd("FileChangedShellPost", {
        group = group,
        pattern = "*",
        callback = function()
          vim.notify("File reloaded due to external changes", vim.log.levels.INFO)
        end,
      })

      -- Optional: Add a manual reload command
      vim.api.nvim_create_user_command("Reload", function()
        vim.cmd("checktime")
        vim.notify("Checked for file changes", vim.log.levels.INFO)
      end, {})
    end,
  },
}
