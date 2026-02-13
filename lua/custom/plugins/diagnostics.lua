-- Diagnostic navigation and quickfix integration
return {
  {
    'diagnostics-and-quickfix',
    name = 'diagnostics-and-quickfix',
    virtual = true,
    lazy = false,
    dependencies = { 'folke/which-key.nvim' },
    config = function()
      -- Register which-key groups
      require('which-key').add {
        { '<leader>d', group = '[D]iagnostics' },
        { '<leader>q', group = '[Q]uickfix' },
      }

      -- Diagnostics -> Quickfix workflow
      vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = '[D]iagnostics to [Q]uickfix' })
      vim.keymap.set('n', '<leader>de', function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
      end, { desc = '[D]iagnostic [E]rrors to quickfix' })

      -- Navigate diagnostics (severity-filtered only; [d/]d are built-in in nvim 0.11)
      vim.keymap.set('n', '[e', function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
      end, { desc = 'Previous [E]rror' })
      vim.keymap.set('n', ']e', function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
      end, { desc = 'Next [E]rror' })

      -- Show diagnostic in floating window
      vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = '[D]iagnostic [F]loat' })

      -- Quickfix navigation
      vim.keymap.set('n', '<leader>qo', '<cmd>copen<cr>', { desc = '[Q]uickfix [O]pen' })
      vim.keymap.set('n', '<leader>qc', '<cmd>cclose<cr>', { desc = '[Q]uickfix [C]lose' })
      vim.keymap.set('n', '<leader>qn', '<cmd>cnext<cr>', { desc = '[Q]uickfix [N]ext' })
      vim.keymap.set('n', '<leader>qp', '<cmd>cprev<cr>', { desc = '[Q]uickfix [P]revious' })
      vim.keymap.set('n', '<leader>qa', '<cmd>cclose | cexpr []<cr>', { desc = '[Q]uickfix Clear [A]ll' })
    end,
  },
}
