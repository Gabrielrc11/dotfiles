# Keybindings Cheat Sheet

> [!note]
>
> - The `<leader>` is the Space key.
> - In some cases, I've defined 2 or more keybindings for the same action.
> - Most of the keybindings are define in [`which-key.lua`](./lua/plugins/interface/which-key.lua),
>   but others keybindins may also be found in [`snacks.lua`](./lua/plugins/interface/snacks.lua),
>   [`mini.lua`](./lua/plugins/interface/mini.lua), [`gitsigns.lua`](./lua/plugins/programming/gitsigns.lua),
>   and [`enable_lsp.lua`](./lua/config/enable_lsp.lua).

## NORMAL Mode (with `<leader>`)

### Buffer and Window

| Keybinding         | Description                                     |
| ------------------ | ----------------------------------------------- |
| `<leader>c`        | Close buffer                                    |
| `<leader>q`        | Quit window/split                               |
| `<leader>sv`       | Split window vertically                         |
| `<leader>sh`       | Split window horizontally                       |
| `<leader>s=`       | Make splits equal size                          |
| `<leader>sc`       | Close current split                             |
| `<leader>e`        | Open `Snacks.explorer` (file manager)           |
| `<leader>ef`       | Open `mini.files` in the folder of current file |
| `<leader><leader>` | List other open buffers                         |
| `<leader>rf`       | Fast rename current file                        |
| `<leader>/`        | Grep in open buffers                            |

### Spelling

| Keybinding   | Description                                                 |
| ------------ | ----------------------------------------------------------- |
| `<leader>Se` | Activate English spelling                                   |
| `<leader>Sp` | Activate Portuguese spelling                                |
| `<leader>Sf` | Activate French spelling                                    |
| `<leader>ss` | Show spelling suggestions when pressed over misspelled word |

> [!NOTE]
> To turn off spelling use `ts`, which toggles on/off spelling in any language. See below.

### Toggling stuff on/off

| Keybinding   | Description [initial value]                       |
| ------------ | ------------------------------------------------- |
| `<leader>tf` | Toggle automatic formatting when saving file [ON] |
| `<leader>tg` | Toggle Gitsigns on buffer [ON]                    |
| `<leader>tl` | Toggle LSP diagnostics [ON]                       |
| `<leader>tn` | Toggle numbering [ON]                             |
| `<leader>tr` | Toggle relative numbering [ON]                    |
| `<leader>ts` | Toggle spell check [OFF]                          |
| `<leader>tt` | Toggle diagnostic virtual text [ON]               |
| `<leader>tw` | Toggle wrap lines [OFF]                           |

### LSP (Language Server Protocol)

#### Formatting

| Keybinding        | Description                                                         |
| ----------------- | ------------------------------------------------------------------- |
| `<leader>=`       | Format buffer (via LSP)                                             |
| `<leader>lf`      | Format buffer (via LSP)                                             |
| `=`               | Format buffer (with plugin `conform`)                               |
| Saving the buffer | Triggers regular vim formatting (use `tf` to turn this feature off) |

#### Navigation

These keybindings work when the cursor is over a variable in a program and the LSP server is active.

| Keybinding | Description                            |
| ---------- | -------------------------------------- |
| `gd`       | Go to definition                       |
| `gD`       | Go to declaration                      |
| `gi`       | Go to implementation                   |
| `gr`       | Go to references                       |
| `grr`      | List all references in a quickfix list |
| `grd`      | Go to definition                       |

> [!note]
> Added `grd` keybinding to keep compatibility with GLOBAL keymaps shown next.

These are the regular global mapping neovim provides by default (source: neovim's help):

```vim
These GLOBAL keymaps are created unconditionally when Nvim starts:
- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
- "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
- "an" and "in" are mapped in Visual mode to outer and inner incremental
  selections, respectively, using |vim.lsp.buf.selection_range()|
```

### Groups (with sub-options)

| Prefix      | Group                 |
| ----------- | --------------------- |
| `<leader>l` | LSP related           |
| `<leader>f` | Finding               |
| `<leader>g` | Snacks Git picker     |
| `<leader>G` | Gitsigns              |
| `<leader>w` | Workspaces (sessions) |

These letters stars the selection of a keybinding (sub-option) within the corresponding group.

Next, we list the keybindings for each group.

#### Information and Help

| Keybinding   | Description       |
| ------------ | ----------------- |
| `<leader>lh` | Show [h]elp/hover |
| `Shift+k`    | Show help/hover   |

#### Code Actions

| Keybinding   | Description               |
| ------------ | ------------------------- |
| `<leader>ln` | Smart re[n]ame            |
| `<leader>la` | List code [a]ctions       |
| `<leader>lf` | [F]ormat buffer (via LSP) |

#### Diagnostics

| Keybinding   | Description                                      |
| ------------ | ------------------------------------------------ |
| `<leader>ll` | Show [l]ine diagnostic                           |
| `]d`         | Go to next [d]iagnostic                          |
| `[d`         | Go to previous [d]iagnostic                      |
| `<leader>ly` | Toggle inla[y] hints                             |
| `<leader>le` | Show [e]rrors diagnostics of the current buffer  |
| `<leader>lx` | Show [x]-ray diagnostics of the current buffer   |
| `<leader>lE` | Show [E]rrors diagnostics for the entire project |
| `<leader>lX` | Show [x]-ray diagnostics for the entire project  |
| `<leader>ls` | Show [s]ymbols of the current buffer             |
| `<leader>ld` | Go to [d]efnitions                               |
| `<leader>lD` | Go to [D]eclarations                             |
| `<leader>li` | Go to [i]mplementations                          |
| `<leader>lr` | List [r]eferences                                |

#### Text objet navigation

| Keybinding | Description                                          |
| ---------- | ---------------------------------------------------- |
| `]n`       | Go to **next** [n]ode begin (native nvim-treesitter) |
| `[n`       | Go to **prev** [n]ode begin (native nvim-treesitter) |
| `]m`       | Go to **next** [m]ethod/function begin               |
| `[m`       | Go to **prev** [m]ethod/function begin               |
| `]M`       | Go to **next** [m]ethod/function end                 |
| `[M`       | Go to **prev** [m]ethod/function end                 |
| `]o`       | Go to **next** l[o]op begin                          |
| `[o`       | Go to **prev** l[o]op begin                          |
| `]O`       | Go to **next** l[o]op end                            |
| `[O`       | Go to **prev** l[o]op end                            |
| `]/`       | Go to **next** comment begin                         |
| `[/`       | Go to **prev** comment begin                         |

#### Text objet selection

After activating selection (`v`, `V`, `Ctrl+v`), type
the following to select the corresponding text objects.

| Keybinding | Description                                     |
| ---------- | ----------------------------------------------- |
| `an`       | Select [a]round [n]ode (native nvim-treesitter) |
| `in`       | Select [i]nside [n]ode (native nvim-treesitter) |
| `af`       | Select [a]round [f]unction                      |
| `if`       | Select [i]nside [f]unction                      |
| `ac`       | Select [a]round [c]lass                         |
| `ic`       | Select [i]nside [c]lass                         |
| `ab`       | Select [a]round [b]lock                         |
| `ib`       | Select [i]nside [b]lock                         |
| `ar`       | Select [a]round pa[r]amater                     |
| `ir`       | Select [i]nside pa[r]amater                     |
| `as`       | Select [a]round [s]cope                         |
| `is`       | Select [i]nside [s]cope                         |
| `a/`       | Select [a]round comment                         |
| `i/`       | Select [i]nside comment                         |

#### Text objet swap

Inside a function argument, in normal mode, press

| Keybinding  | Description                      |
| ----------- | -------------------------------- |
| `<leader>a` | Swap next function parameter     |
| `<leader>A` | Swap previous function parameter |

### Finding group

| Prefix       | Group                                      |
| ------------ | ------------------------------------------ |
| `<leader>fb` | Grep inside open buffers                   |
| `<leader>fc` | Select available colorschemes              |
| `<leader>ff` | Select files in workspace                  |
| `<leader>fg` | Grep content in all files of the workspace |
| `<leader>fh` | Grep in the nvim's help documentation      |
| `<leader>fk` | Grep in keybindings                        |
| `<leader>fn` | Select files in the nvim's worktree        |
| `<leader>fN` | List notifications                         |
| `<leader>fp` | Select possible pickers                    |
| `<leader>fr` | Select content from nvim registers         |
| `<leader>fw` | Grep selected word in workspace            |

### Snacks git related pickers

| Prefix       | Group                |
| ------------ | -------------------- |
| `<leader>Gb` | List git branches    |
| `<leader>Gl` | List git history log |
| `<leader>GL` | List git log line    |
| `<leader>Gs` | List git status      |
| `<leader>GS` | List git stash       |
| `<leader>Gd` | List git diff hunks  |
| `<leader>Gf` | List git log file    |

### Gitsigns

| Keybinding   | Description           |
| ------------ | --------------------- |
| `<leader>gj` | [n]ext hunk           |
| `]h`         | [n]ext hunk           |
| `<leader>gk` | [p]rev hunk           |
| `[h`         | [p]rev hunk           |
| `<leader>gs` | [s]tage hunk          |
| `<leader>gS` | [S]tage buffer        |
| `<leader>gr` | [r]eset hunk          |
| `<leader>gR` | [R]eset buffer        |
| `<leader>gp` | [p]review hunk        |
| `<leader>gi` | preview hunk [i]nline |
| `<leader>gd` | [d]iff index          |
| `<leader>gl` | [b]lame line          |

### Workspace

| Prefix       | Group               |
| ------------ | ------------------- |
| `<leader>wr` | AutoSession restore |
| `<leader>ws` | AutoSession save    |
| `<leader>wf` | AutoSession search  |

### Mini surround

| Prefix       | Group                                |
| ------------ | ------------------------------------ |
| `<leader>sa` | Add delimiter around text object     |
| `<leader>sd` | Delete delimiter around text object  |
| `<leader>sr` | Replace delimiter around text object |

## NORMAL Mode (without `<leader>`)

### Navigation, Buffer and window

| Keybinding         | Description                               |
| ------------------ | ----------------------------------------- |
| `-`                | Open `mini.files` (oil-like file manager) |
| `<Esc>`            | Remove search highlight                   |
| `\|`               | Split window horizontally                 |
| `\`                | Split window vertically                   |
| `<right>`/`<tab>`  | Next buffer                               |
| `<left>`/`<s-tab>` | Previous buffer                           |
| `[b`               | Move current buffer forwards              |
| `]b`               | Move current buffer backwards             |
| `[B`               | First buffer                              |
| `]B`               | Last buffer                               |

### Save and Quit

| Keybinding | Description         |
| ---------- | ------------------- |
| `<C-s>`    | Save current buffer |
| `<C-q>`    | Force quit          |

### Search

| Keybinding | Description                  |
| ---------- | ---------------------------- |
| `*`        | Search without moving cursor |
| `n`        | Next result (centered)       |
| `N`        | Previous result (centered)   |

### Window Navigation

| Keybinding | Description                           |
| ---------- | ------------------------------------- |
| `<C-h>`    | Move to left split / Tmux pane left   |
| `<C-j>`    | Move to below split / Tmux pane down  |
| `<C-k>`    | Move to above split / Tmux pane up    |
| `<C-l>`    | Move to right split / Tmux pane right |

### Window Resizing

| Keybinding  | Description        |
| ----------- | ------------------ |
| `<C-Up>`    | Resize split up    |
| `<C-Down>`  | Resize split down  |
| `<C-Left>`  | Resize split left  |
| `<C-Right>` | Resize split right |

### Page Navigation

| Keybinding | Description               |
| ---------- | ------------------------- |
| `<C-d>`    | Half page down (centered) |
| `<C-u>`    | Half page up (centered)   |
| `<C-f>`    | Full page down (centered) |
| `<C-b>`    | Full page up (centered)   |

### Move Panes

| Keybinding  | Description     |
| ----------- | --------------- |
| `<A-Down>`  | Move pane down  |
| `<A-Up>`    | Move pane up    |
| `<A-Left>`  | Move pane left  |
| `<A-Right>` | Move pane right |

### Maximize Windows

| Keybinding | Description     |
| ---------- | --------------- |
| `<C-w>\`   | Maximize width  |
| `<C-w>\|`  | Maximize height |

### Quickfix List

| Keybinding | Description             |
| ---------- | ----------------------- |
| `<A-j>`    | Next quickfix entry     |
| `<A-k>`    | Previous quickfix entry |
| `[q`       | Previous quickfix entry |
| `]q`       | Next quickfix entry     |
| `[Q`       | First quickfix entry    |
| `]Q`       | Last quickfix entry     |

### Location List

| Keybinding | Description                  |
| ---------- | ---------------------------- |
| `<A-J>`    | Next location list entry     |
| `<A-K>`    | Previous location list entry |
| `[l`       | Previous loclist entry       |
| `]l`       | Next loclist entry           |
| `[L`       | First loclist entry          |
| `]L`       | Last loclist entry           |

## VISUAL Mode

| Keybinding  | Description                                |
| ----------- | ------------------------------------------ |
| `<C-s>`     | Save current buffer                        |
| `<`         | Unindent line                              |
| `>`         | Indent line                                |
| `y`         | Yank without moving cursor                 |
| `p`         | Paste replacing previous selection         |
| `<leader>p` | Paste without replacing previous selection |
| `<leader>+` | Increment number                           |
| `<leader>-` | Decrement number                           |

## VISUAL BLOCK Mode

| Keybinding | Description     |
| ---------- | --------------- |
| `<A-j>`    | Move block down |
| `<A-k>`    | Move block up   |

## INSERT Mode

| Keybinding | Description           |
| ---------- | --------------------- |
| `jj`       | Escape to Normal mode |
| `jk`       | Escape to Normal mode |
| `<C-s>`    | Save buffer           |

## Special Text Objects

Text objects between special characters (use with `i` for inner or `a` for around):

**Supported characters:** `_`, `.`, `:`, `,`, `;`, `|`, `/`, `\`, `*`, `+`, `%`, `` ` ``, `?`

**Examples:** `ci_` = change inner underscore, `da.` = delete around dot

---
