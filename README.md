# vim-ug: a Git wrapper rapper

Ug provides mappings (prefixed with `U`) for [vim-fugitive](https://github.com/tpope/vim-fugitive),
and a few other QoL tweaks.

## Usage

Use the standard fugitive commands with enhanced mappings.

See help file for details.

## Install

Requires Nvim 0.12. Partial support for Vim and older Nvim.

```lua
vim.pack.add{
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/justinmk/vim-ug',
}
```

## How it works

1. Provides convenient keymaps for common fugitive operations.
2. Wraps fugitive commands with minimal, opinionated defaults.

## Todo

- make `<c-g>` mapping compatible with Vim

## Credits

Ug is a minimal wrapper around [vim-fugitive](https://github.com/tpope/vim-fugitive) by Tim Pope.
