# Ug, the git wrapper-rapper

Ug provides `U` mappings for [vim-fugitive](https://github.com/tpope/vim-fugitive),
and a few other QoL tweaks.

## Usage

See `:help ug-mappings` for the full list. Examples:

- Show the Git status with `Us`.
- Show the blame with `Ub`.
- Jump to the next change with `<c-n>`, or previous with `<c-p>`.
- Show Git branch with `<c-g>`.

All `U…` mappings have uppercase aliases (`Ux` is aliased to `UX`, etc.), to
avoid worrying about typos.

## Install

Requires Nvim 0.12. Partial support for Vim and older Nvim.

```lua
vim.pack.add{
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/justinmk/vim-ug',
}
```

## Todo

- make `<c-g>` mapping compatible with Vim

## Credits

Ug is a minimal wrapper around [vim-fugitive](https://github.com/tpope/vim-fugitive) by Tim Pope.
