<a href="https://github.com/hamadash/operator-hint.nvim/releases/latest"><img src="https://img.shields.io/github/release/hamadash/operator-hint.nvim.svg" /></a>

# operator-hint.nvim

A Neovim plugin that provides which-key style hints for Vim operators to help you remember useful operations.

## Features

- 🚀 **which-key style hints**: Shows available operations when you start typing an operator
- ⚙️ **Configurable**: Customize operators and their descriptions
- 🎯 **LazyNvim compatible**: Works seamlessly with LazyNvim
- ⏱️ **Smart timing**: Configurable delays and timeouts
- 🎨 **Clean UI**: Floating window with customizable appearance

## Installation

### LazyNvim

```lua
{
  "hamadash/operator-hint.nvim",
  event = "VeryLazy",
  config = function()
    require("operator-hint").setup({
      -- your configuration here
    })
  end,
}
```

### Packer

```lua
use {
  "hamadash/operator-hint.nvim",
  config = function()
    require("operator-hint").setup()
  end
}
```

## Usage

Once installed and configured, the plugin will automatically show hints when you:

1. Press an operator key (like `d`, `y`, `c`, `g`, `<C-w>`)
2. Wait for the configured delay (default: 300ms)
3. See a popup with available operations

Press `<Esc>` or `q` to close the hints manually.

### Commands

- `:OperatorHint` - Manually show operator hints
- `:OperatorHintToggle` - Toggle operator hints visibility
- `:OperatorHintHide` - Hide operator hints

## Configuration

### Default Configuration

```lua
require("operator-hint").setup({
  operators = {
    d = {
      name = "Delete",
      mappings = {
        dd = "Delete line",
        dw = "Delete word",
        d$ = "Delete to end of line",
        -- ... more mappings
      }
    },
    y = {
      name = "Yank",
      mappings = {
        yy = "Yank line",
        yw = "Yank word",
        -- ... more mappings
      }
    },
    -- ... more operators
  },
  timeout = 1000,        -- Hide hints after this time (ms)
  show_delay = 300,      -- Show hints after this delay (ms)
  ui = {
    border = "rounded",  -- Border style
    position = "center", -- Position of the popup
    min_width = 40,      -- Minimum popup width
    max_width = 80,      -- Maximum popup width
  }
})
```

### Adding Custom Operators

```lua
require("operator-hint").setup({
  operators = {
    -- Add your custom operator
    ["<leader>f"] = {
      name = "Find",
      mappings = {
        ["<leader>ff"] = "Find files",
        ["<leader>fg"] = "Find in files",
        ["<leader>fb"] = "Find buffers",
      }
    },
    -- Override default operators
    d = {
      name = "Delete",
      mappings = {
        dd = "Delete current line",
        dw = "Delete word under cursor",
        -- your custom mappings
      }
    }
  }
})
```

## License

MIT
