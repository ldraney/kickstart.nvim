-- Auto-reload configuration for external file changes
return {
  {
    "auto-reload",
    name = "auto-reload",
    dir = ".", -- Local plugin
    lazy = false,
    config = function()
      -- Enable autoread to detect when a file changes outside of nvim
      vim.o.autoread = true

      -- Create an autocommand group for auto-reload functionality
      local group = vim.api.nvim_create_augroup("auto_reload", { clear = true })

      -- Check for file changes when cursor stops moving
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        pattern = "*",
        callback = function()
          vim.cmd("checktime")
        end,
      })

      -- Check for file changes when entering a buffer
      vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
        group = group,
        pattern = "*",
        callback = function()
          vim.cmd("checktime")
        end,
      })

      -- Check for file changes when entering terminal
      vim.api.nvim_create_autocmd("TermEnter", {
        group = group,
        pattern = "*",
        callback = function()
          vim.cmd("checktime")
        end,
      })

      -- Optionally reload file without prompting if it hasn't been modified in nvim
      vim.api.nvim_create_autocmd("FileChangedShellPost", {
        group = group,
        pattern = "*",
        callback = function()
          vim.notify("File reloaded due to external changes", vim.log.levels.INFO)
        end,
      })

      -- Set shorter updatetime for more frequent checks (default is 4000ms)
      vim.o.updatetime = 1000

      -- Optional: Add a manual reload command
      vim.api.nvim_create_user_command("Reload", function()
        vim.cmd("checktime")
        vim.notify("Checked for file changes", vim.log.levels.INFO)
      end, {})
    end,
  },
}
