-- :help dap-configuration
local dap = require('dap')

-- Adapter setup
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
    args = { "--port", "${port}" },
  }
}

-- Rust configuration
dap.configurations.rust = {
  {
    type = 'codelldb',
    request = 'launch',
    name = 'Launch file',
    program = function()
      vim.fn.system('cargo build')

      -- this just gets where nvim was opened
      local cwd = vim.fn.getcwd()
      
      -- this gets the last part of cwd, so if .../code/rust_dap_test it would return rust_dap_test
      local bin = vim.fn.fnamemodify(cwd, ':t') -- guesses binary name from folder
      local path = cwd .. '/target/debug/' .. bin

      if vim.fn.filereadable(path) == 0 then
          path = vim.fn.input('Path to executable: ', cwd .. '/target/debug/', 'file')
      end

      return path
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
