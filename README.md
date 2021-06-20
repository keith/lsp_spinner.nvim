## lsp_status

Nvim plugin to retrieve the name of the running LSP client(s) and display a spinner when a job is in progress.

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

local function on_attach(client)
  -- ... other stuff

  lsp_status.on_attach(client)
end

lspconfig.rust_analyzer.setup {  -- Rust Analyzer setup
  on_attach = on_attach,
  capabilities = capabilities
}
```

### get status

```lua
require'lsp_status'.status()
```

### license
Mozilla Public License 2.0
