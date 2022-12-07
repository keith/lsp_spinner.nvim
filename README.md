## lsp_spinner.nvim

Nvim plugin to display the name of the running LSP client(s) and
a spinner when there are jobs in progress.

### Install

```lua
paq('doums/lsp_spinner.nvim')
```

### Setup

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
  -- placeholder displayed in place of the spinner when there is
  -- no activity for a given LSP client
  placeholder = ' ',
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

### Usage

The plugin exposes 2 Lua functions to get the LSP clients status:

- `status()`

Returns the name(s) of all running LSP client(s).

```lua
local status = require('lsp_spinner').status()
```

- `buf_status(bufnr)`

Returns the name(s) of the running LSP client(s) attached to the
given buffer. If no `bufnr` is given, the current buffer is used.

```lua
local status = require('lsp_spinner').buf_status(bufnr)
```

Example with [ponton.nvim](https://github.com/doums/ponton.nvim)

```lua
    lsp_spinner = {
      style = { '#C5656B', line_bg },
      fn = require('lsp_spinner').status,
      padding = { nil, 2 },
    },
```

### license

Mozilla Public License 2.0
