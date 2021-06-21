## lsp_status

Nvim plugin to display the name of the running LSP server(s) and a spinner when a job is in progress.

### install

```
paq 'doums/lsp_status'
```

### setup
```lua
local lspconfig = require'lspconfig'
local lsp_status = require'lsp_status'

-- register an handler for `$/progress` method
-- options are optional
lsp_status.setup {
  spinner = {'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'},
  interval = 80 -- in ms
}

local capabilities = lsp.protocol.make_client_capabilities()

-- turn on `window/workDoneProgress` capability
lsp_status.init_capabilities(capabilities)

local function on_attach(client, bufnr)
  -- ... other stuff

  lsp_status.on_attach(client, bufnr)
end

lspconfig.rust_analyzer.setup {  -- Rust Analyzer setup
  on_attach = on_attach,
  capabilities = capabilities
}
```

### get status

just call the method `status`
```lua
require'lsp_status'.status(bufnr)
```

example using it with [ponton.nvim](https://github.com/doums/ponton.nvim)
```lua
    lsp_status = {
      style = {'#C5656B', line_bg},
      fn = require'lsp_status'.status,
      padding = {nil, 2},
    },
```

### license
Mozilla Public License 2.0
