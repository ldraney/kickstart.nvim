-- Enhanced JavaScript development with JSDoc + quickfix integration
return {
  {
    'neovim/nvim-lspconfig',
    keys = {
      -- Diagnostics -> Quickfix workflow
      { '<leader>dq', vim.diagnostic.setqflist, desc = '[D]iagnostics to [Q]uickfix' },
      { '<leader>de', function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
      end, desc = '[D]iagnostic [E]rrors to quickfix' },

      -- Navigate diagnostics
      { '[d', vim.diagnostic.goto_prev, desc = 'Previous [D]iagnostic' },
      { ']d', vim.diagnostic.goto_next, desc = 'Next [D]iagnostic' },
      { '[e', function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, desc = 'Previous [E]rror' },
      { ']e', function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, desc = 'Next [E]rror' },

      -- Show diagnostic in floating window
      { '<leader>df', vim.diagnostic.open_float, desc = '[D]iagnostic [F]loat' },

      -- Quickfix navigation
      { '<leader>qo', '<cmd>copen<cr>', desc = '[Q]uickfix [O]pen' },
      { '<leader>qc', '<cmd>cclose<cr>', desc = '[Q]uickfix [C]lose' },
      { '<leader>qn', '<cmd>cnext<cr>', desc = '[Q]uickfix [N]ext' },
      { '<leader>qp', '<cmd>cprev<cr>', desc = '[Q]uickfix [P]revious' },
      { '<leader>qa', '<cmd>cclose | cexpr []<cr>', desc = '[Q]uickfix Clear [A]ll' },
    },
  },
}
