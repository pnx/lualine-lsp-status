# lualine-lsp-status

Plugin for showing connected lsp servers in [lualine](https://github.com/nvim-lualine/lualine.nvim).

## Screenshots

![image](https://github.com/user-attachments/assets/0d98f8b3-7e71-4faa-af31-7a41b8bfe53b)

![image](https://github.com/user-attachments/assets/b14c2f33-aa6b-4fb2-9d5d-7efe3896af86)
![image](https://github.com/user-attachments/assets/16fcb5a0-8829-4a30-8f17-6a94d2fd15d3)


## Install


### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ 'pnx/lualine-lsp-status' }
```

### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'pnx/lualine-lsp-status'
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use 'pnx/lualine-lsp-status'
```

## Usage

Just add `lsp-status` as a component.

```lua
require'lualine'.setup{
    ...
    sections = {
        lualine_c = {
            ...,
            'lsp-status'
        }
    }
}
```

## Configuration

This is the default configuration, feel free to change it to your liking.

```lua
{

    -- true if the number of lsp clients connected should be shown.
    show_count = true,

    -- true if icon should also be color coded.
    colored = true,

    -- List of filetypes to disable this component for.
    disabled_filetypes = {},

    -- Colors used.
    colors = {
        -- Color used if there are one or more clients connected
        active = {
            fg = utils.extract_color_from_hllist(
                'fg',
                { 'DiagnosticOk', 'DiagnosticSignOk' },
                '#89dceb'
            )
        },
        -- Color used if there is zero clients connected
        inactive = {
            fg = utils.extract_color_from_hllist(
                'fg',
                { 'DiagnosticError', 'DiagnosticSignError', 'Error' },
                '#f38ba8'
            )
        },
        -- Color used for the count.
        count = {
            fg = utils.extract_color_from_hllist(
                'fg',
                { 'StatusLineNormal' },
                '#ffffff'
            )
        },
    },

    -- Icon used.
    icons = {
        -- Icon used when there is one or more clients connected
        active = "",

        -- Icon used when there is zero clients connected.
        inactive = ""
    }
}
```
