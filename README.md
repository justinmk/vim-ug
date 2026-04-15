# Ug, the git wrapper-rapper

Ug provides `U` mappings for [vim-fugitive](https://github.com/tpope/vim-fugitive),
and a few other QoL tweaks. Some features require [gh cli](https://cli.github.com/).

## Usage

See `:help ug-mappings` for the full list. Examples:

- `Us` shows the Git status.
- `Ub` shows the Git blame.
- Jump to the next change with `<c-n>`, or previous with `<c-p>`.
- `<c-g>` shows info including the Git branch name.
- `[count]Ux` tries to find and open the GitHub PR for the current branch.

All `U…` mappings have uppercase aliases (`Ux` is aliased to `UX`, etc.), to
avoid worrying about typos.

## Install

- Requires Nvim 0.12. Partial support for Vim and older Nvim.
- Some features require [gh cli](https://cli.github.com/).

Snippet:

```lua
vim.pack.add{
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/justinmk/vim-ug',
}
```

## Credits

Ug is a minimal wrapper around [vim-fugitive](https://github.com/tpope/vim-fugitive) by Tim Pope.
