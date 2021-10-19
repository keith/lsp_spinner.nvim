## lsp_spinner.nvim

Nvim plugin to display the name of the running LSP server(s) and a spinner when a job is in progress.

### install

```lua
paq('doums/lsp_spinner.nvim')
```

### setup

```lua
local lspconfig = require('lspconfig')
local lsp_spinner = require('lsp_spinner')

-- register an handler for `$/progress` method
-- options are optional
lsp_spinner.setup({
  spinner = {
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  },
  interval = 80, -- spinner frame rate in ms
  redraw_rate = 100, -- max refresh rate of statusline in ms
  placeholder = '  ', -- it will be displayed when there is no activity
})

local capabilities = lsp.protocol.make_client_capabilities()

-- turn on `window/workDoneProgress` capability
lsp_spinner.init_capabilities(capabilities)

local function on_attach(client, bufnr)
  -- ... other stuff

  lsp_spinner.on_attach(client, bufnr)
end

-- Rust Analyzer setup
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
```

### get status

just call the method `status`
```lua
require('lsp_spinner').status(bufnr)
```

example using it with [ponton.nvim](https://github.com/doums/ponton.nvim)
```lua
    lsp_spinner = {
      style = { '#C5656B', line_bg },
      fn = require('lsp_spinner').status,
      padding = { nil, 2 },
    },
```

### license
Mozilla Public License 2.0
