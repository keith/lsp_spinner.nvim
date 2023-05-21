## DEPRECATED

This plugin is now deprecated and will no longer receive updates.

If you look for a similar plugin with a better implementation use
[doums/lswip.nvim](https://github.com/doums/lswip.nvim) instead

## lsp_spinner.nvim

Nvim library to get the name of the running LSP client(s) and
a spinner when there are jobs in progress. Intended for use in
statusline.

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

local capabilities = vim.lsp.protocol.make_client_capabilities()

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

The library exposes 2 Lua functions:

- `status()`

Returns (`string`) the name(s) of **all** running LSP client(s).\
Returns `nil` if there is no running client.

```lua
local status = require('lsp_spinner').status()
```

- `buf_status(bufnr)`

Returns (`string`) the name(s) of the running LSP client(s)
attached to the given buffer. If no `bufnr` is given, the current
buffer is used.\
Returns `nil` if there is no running client.

```lua
local status = require('lsp_spinner').buf_status(bufnr)
```

Each client name is followed by a spinner frame if there is work
in progress for the given client.

Example with [ponton.nvim](https://github.com/doums/ponton.nvim)

```lua
    lsp_spinner = {
      style = { '#C5656B', line_bg },
      fn = require('lsp_spinner').status,
      padding = { nil, 2 },
    },
```

### License

Mozilla Public License 2.0
