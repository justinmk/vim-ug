# Ug, the git wrapper-rapper

Ug provides mappings (prefixed with `U`) for [vim-fugitive](https://github.com/tpope/vim-fugitive),
and a few other QoL tweaks.

## Usage

All of the `U…` mappings have aliases for uppercase and lowercase, to avoid
worrying about typos. For example `Ux` is aliased to `UX`.

- Show the Git status with `Us`.
- Show the blame with `Ub`.
- Jump to the next change with `<c-n>`, or previous with `<c-p>`.
- Show Git branch with `<c-g>`.

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
