![GitHub Release](https://img.shields.io/github/v/release/hamadash/keymemo.nvim)

# keymemo.nvim

A Neovim plugin that provides memo for Vim keys to help you remember useful keys.

## Features

- ⚙️ **Configurable**: Customize keys and their descriptions
- 🎨 **Clean UI**: Floating window with customizable appearance

## Installation

### LazyNvim

```lua
{
  "hamadash/keymemo.nvim",
  event = "VeryLazy",
  config = function()
    require("keymemo").setup({
      keys = {
        -- Define your keys here
      }
    })
  end,
}
```

### Packer

```lua
use {
  "hamadash/keymemo.nvim",
  config = function()
    require("keymemo").setup({
      -- your configuration here
    })
  end
}
```

## Usage

Use the following commands to display key memo:

### Commands

- `:KeyMemo` - Show key memo
- `:KeyMemoToggle` - Toggle key memo visibility
- `:KeyMemoHide` - Hide key memo

Press `<Esc>` or `q` to close the memo when it is visible.

## Configuration

### Configuration

```lua
require("keymemo").setup({
  keys = {
    -- You must define all keys yourself
    d = {
      name = "Delete",
      mappings = {
        dd = "Delete line",
        dw = "Delete word",
        ["d$"] = "Delete to end of line",
        d0 = "Delete to beginning of line",
        di = "Delete inside",
        da = "Delete around",
      }
    },
    y = {
      name = "Yank",
      mappings = {
        yy = "Yank line",
        yw = "Yank word",
        ["y$"] = "Yank to end of line",
        y0 = "Yank to beginning of line",
        yi = "Yank inside",
        ya = "Yank around",
      }
    },
    c = {
      name = "Change",
      mappings = {
        cc = "Change line",
        cw = "Change word",
        ["c$"] = "Change to end of line",
        c0 = "Change to beginning of line",
        ci = "Change inside",
        ca = "Change around",
      }
    },
    g = {
      name = "Go",
      mappings = {
        gg = "Go to first line",
        ["G"] = "Go to last line",
        gf = "Go to file under cursor",
        gd = "Go to definition",
        gr = "Go to references",
        gi = "Go to implementation",
        gt = "Next tab",
        gT = "Previous tab",
      }
    },
    ["<C-w>"] = {
      name = "Window",
      mappings = {
        ["<C-w>h"] = "Move to left window",
        ["<C-w>j"] = "Move to down window",
        ["<C-w>k"] = "Move to up window",
        ["<C-w>l"] = "Move to right window",
        ["<C-w>s"] = "Split window horizontally",
        ["<C-w>v"] = "Split window vertically",
        ["<C-w>q"] = "Close window",
        ["<C-w>w"] = "Switch to next window",
      }
    }
  },
  ui = {
    border = "rounded",  -- Border style
    position = "center", -- Position of the popup
    min_width = 40,      -- Minimum popup width
    max_width = 80,      -- Maximum popup width
  }
})
```

## License

MIT
