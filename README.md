vim-es6-unused-imports
=====================

This plugin highlights unused import statements in ECMAScript 6 code.

Usage
-----

To check for unused import statements upon opening a javascript file, add this to your `.vimrc`:

```vim
autocmd BufWinEnter *.js execute "ES6ImportsHighlight"
```

To also check for unused import statements on save, add this to your `.vimrc`:

```vim
autocmd BufWritePost *.js execute "ES6ImportsHighlight"
```

To clear the highlighting, run the command `ES6ImportsClear`.

Options
-------

Use the `cterm` options if you are running a terminal version of vim,
and use the `gui` options if you are running a GUI version of vim.

| Option                          | Default     | Description                                               |
| ------                          | -------     | -----------                                               |
| `g:es6_imports_cterm_fg_color`  | `'blue'`    | The foreground (`ctermfg`) color of the highlighted line. |
| `g:es6_imports_cterm_bg_color`  | `'darkred'` | The background (`ctermbg`) color of the highlighted line. |
| `g:es6_imports_gui_fg_color`    | `'blue'`    | The foreground (`guifg`) color of the highlighted line.   |
| `g:es6_imports_gui_bg_color`    | `'darkred'` | The foreground (`guibg`) color of the highlighted line.   |
| `g:es6_imports_excludes`        | `['']`      | An array of strings to exclude from the search.           |
