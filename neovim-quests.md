# ⚔️ NEOVIM ODYSSEY — A Quest-Based Learning System

> *You are a seasoned Vi warrior, battle-hardened in the ways of modal editing.*
> *But a new world has opened up. The ancient skills serve you well here,*
> *yet powerful artifacts and allies await those brave enough to explore.*

---

## HOW THIS WORKS

- **Complete quests** by actually doing the task in Neovim (not just reading about it)
- **Mark quests done** by changing `[ ]` to `[x]`
- **XP thresholds** unlock the next zone — no skipping ahead
- **Boss encounters** are practical challenges that combine skills from the zone
- **Loot** = config snippets you add to your `init.lua` as rewards
- **Side quests** are optional but grant powerful upgrades

```
LEVEL 1  ........  0 XP      Greenhorn
LEVEL 5  ........  200 XP    Apprentice
LEVEL 10 ........  500 XP    Journeyman
LEVEL 15 ........  900 XP    Expert
LEVEL 20 ........  1400 XP   Master
LEVEL 25 ........  2000 XP   Grandmaster
```

---

## 🏕️ ZONE 1 — THE CROSSROADS (0 XP to enter)

*"Your vi instincts are strong, warrior. But first, let us see if this new land recognizes your blade."*

**Theme:** Get Neovim installed, configured, and verify your vi skills carry over.

### Quest Chain: First Steps

- [x] **Quest 1.1 — Install the Blade** (10 XP)
  Install Neovim (`brew install neovim` / `apt install neovim`).
  Run `nvim --version`. You need 0.9+.
  *Turn-in: You see a version number >= 0.9*

- [x] **Quest 1.2 — The Old Ways Still Work** (10 XP)
  Open a file with `nvim`. Navigate using only hjkl. Edit, save, quit.
  Confirm to yourself: this is home.
  *Turn-in: Edit and save a file using only vi motions*

- [x] **Quest 1.3 — Forge Your Config** (20 XP)
  Create `~/.config/nvim/init.lua`. Add these lines:
  ```lua
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.signcolumn = "yes"
  vim.opt.clipboard = "unnamedplus"
  ```
  *Turn-in: Open nvim — you see relative line numbers*

- [x] **Quest 1.4 — The Adventurer's Map** (20 XP)
  Learn `:checkhealth`. Run it. Fix any warnings about missing providers.
  This is your diagnostic tool — you'll return to it often.
  *Turn-in: `:checkhealth` runs with no critical errors*

### 🗡️ BOSS: The Config Gauntlet (50 XP)
Without looking anything up, from a blank `init.lua`:
1. Set line numbers on
2. Set the leader key to space: `vim.g.mapleader = " "`
3. Create a keymap that saves the file with `<leader>w`
   *Hint: `vim.keymap.set("n", "<leader>w", ":w<CR>")`*
4. Reload config with `:source %`

*Reward: You now understand that Neovim config is just Lua. No magic.*

**Zone 1 Total: 110 XP — You are LEVEL 3**

---

## 🌲 ZONE 2 — THE PLUGIN FOREST (100 XP to enter)

*"Alone, a warrior is strong. With allies, unstoppable."*

**Theme:** Plugin management and your first essential plugins.

### Quest Chain: Summoning Allies

- [ ] **Quest 2.1 — The Summoner's Tome** (20 XP)
  Install **lazy.nvim** (the plugin manager). Add the bootstrap code from
  https://lazy.folke.io/installation to your `init.lua`.
  *Turn-in: `:Lazy` opens the plugin manager UI*

- [ ] **Quest 2.2 — First Ally: The Pathfinder** (30 XP)
  Install **telescope.nvim** (fuzzy finder). Add keymaps:
  - `<leader>ff` — find files
  - `<leader>fg` — live grep across project
  - `<leader>fb` — list open buffers
  *Turn-in: `<leader>ff` opens a fuzzy file picker*

- [ ] **Quest 2.3 — Second Ally: The Cartographer** (20 XP)
  Install **oil.nvim** or **neo-tree.nvim** (file explorer).
  Learn to navigate, create, rename, and delete files from within Neovim.
  *Turn-in: Create a new file without leaving Neovim*

- [ ] **Quest 2.4 — Third Ally: The Chronomancer** (20 XP)
  Install **gitsigns.nvim**. You should now see git diff markers in the sign column.
  Learn: `]c` / `[c` to jump between hunks, preview hunk, stage hunk, reset hunk.
  *Turn-in: Stage a single hunk from within Neovim*

- [ ] **Quest 2.5 — Vanity and Glory** (10 XP)
  Install a **colorscheme** you love (catppuccin, tokyonight, gruvbox, rose-pine)
  and a **statusline** (lualine.nvim).
  *Turn-in: Your editor no longer looks like 1985*

### Side Quest: The Whisperer (30 XP)
Install **which-key.nvim**. Now when you press `<leader>` and pause,
a popup shows all available keymaps. This is your in-game tooltip system.
*Turn-in: Press `<leader>` and see the popup*

### 🗡️ BOSS: The Lost File (60 XP)
Your quest giver hid a file somewhere in a large project directory.
1. Use Telescope's `find_files` to locate a file named `treasure.txt`
2. Use Telescope's `live_grep` to find which file contains the word "gold"
3. Use your file explorer to rename it to `claimed.txt`
4. Use gitsigns to stage and preview your changes

All without leaving Neovim.

*Reward: You now understand that Neovim can replace most of what you used the GUI for.*

**Zone 2 Total: 190 XP — You are LEVEL 7**

---

## 🏰 ZONE 3 — THE TOWER OF LANGUAGE (300 XP to enter)

*"The scribes in this tower speak every language. They will teach your blade to understand code itself."*

**Theme:** LSP, autocompletion, and syntax-aware editing.

### Quest Chain: The Language Protocols

- [ ] **Quest 3.1 — The Interpreter's Guild** (30 XP)
  Install **nvim-lspconfig**. Configure an LSP server for a language you use.
  (e.g., `pyright` for Python, `ts_ls` for TypeScript, `lua_ls` for Lua)
  *Turn-in: Open a file and see real diagnostics (errors/warnings) in the gutter*

- [ ] **Quest 3.2 — The Oracle Speaks** (30 XP)
  Set up LSP keymaps:
  - `gd` — go to definition
  - `gr` — find references
  - `K` — hover documentation
  - `<leader>rn` — rename symbol
  - `<leader>ca` — code actions
  *Turn-in: Jump to a function's definition with `gd`, then back with `Ctrl-o`*

- [ ] **Quest 3.3 — The Scribe's Quill** (30 XP)
  Install **nvim-cmp** (autocompletion) with LSP source.
  Configure it so completions appear as you type.
  *Turn-in: Start typing a function name and see intelligent suggestions*

- [ ] **Quest 3.4 — The Living Syntax** (20 XP)
  Install **nvim-treesitter**. Enable `highlight`, `indent`, and `incremental_selection`.
  Your code should now be highlighted with actual syntactic understanding, not regex.
  *Turn-in: Notice the difference in highlighting quality*

- [ ] **Quest 3.5 — The Surgeon's Tools** (30 XP)
  Learn Treesitter text objects (with **nvim-treesitter-textobjects**):
  - `af` / `if` — around/inside function
  - `ac` / `ic` — around/inside class
  - `aa` / `ia` — around/inside argument
  Practice: `daf` deletes an entire function. `cia` changes an argument.
  *Turn-in: Delete a function, undo, then change a single argument — all with motions*

### Side Quest: The Formatter (20 XP)
Install **conform.nvim**. Configure format-on-save for your language.
*Turn-in: Save a messy file and watch it auto-format*

### Side Quest: The Lint Hound (20 XP)
Install **nvim-lint**. Configure a linter for your language.
*Turn-in: See linting diagnostics separate from LSP warnings*

### 🗡️ BOSS: The Refactoring Trial (80 XP)
Take a real file from one of your projects (100+ lines). Without leaving Neovim:
1. Use `gd` to trace a function call to its definition
2. Rename a symbol with `<leader>rn` across the whole project
3. Use `gr` to verify all references updated
4. Delete an entire function using `daf`
5. Move it to another file using Treesitter-aware selection
6. Format both files on save

*Reward: Your editor now understands code as well as any IDE.*

**Zone 3 Total: 260 XP — You are LEVEL 13**

---

## ⚡ ZONE 4 — THE SPEED PLAINS (550 XP to enter)

*"Knowledge is nothing without speed. Here, we forge reflexes."*

**Theme:** Advanced motions, workflow speed, and tmux integration.

### Quest Chain: The Way of Speed

- [ ] **Quest 4.1 — The Leap** (20 XP)
  Install **flash.nvim** or **leap.nvim**. Learn to jump to any visible
  word in 2-3 keystrokes.
  *Turn-in: Jump across a long file without hjkl or searching*

- [ ] **Quest 4.2 — The Portal Network** (30 XP)
  Master **Harpoon** (by ThePrimeagen). Mark 4 files you work with frequently.
  Switch between them with `<leader>1` through `<leader>4`.
  *Turn-in: Bounce between 4 files in under 2 seconds*

- [ ] **Quest 4.3 — Window Mastery** (20 XP)
  Learn split management:
  - `<C-w>v` vertical split, `<C-w>s` horizontal split
  - `<C-w>h/j/k/l` navigate splits
  - `<C-w>=` equalize, `<C-w>_` maximize height, `<C-w>|` maximize width
  Remap these to something faster (e.g., `<C-h/j/k/l>` to move between splits).
  *Turn-in: Work with 3 splits open comfortably*

- [ ] **Quest 4.4 — The Tmux Bridge** (30 XP)
  Install **vim-tmux-navigator** (or the Lua equivalent). Now `<C-h/j/k/l>`
  moves seamlessly between Neovim splits AND tmux panes.
  Claude Code in one pane, Neovim in another — one fluid workspace.
  *Turn-in: Navigate from a Neovim split to a tmux pane without thinking*

- [ ] **Quest 4.5 — Macro Warfare** (20 XP)
  You probably know macros from vi (`qq...q` then `@q`).
  Practice using them on real editing tasks. Record a macro that:
  1. Reformats a line of data
  2. Apply it to 50 lines with `50@q`
  *Turn-in: Solve a repetitive editing task with a macro in under 30 seconds*

### Side Quest: The Undying (20 XP)
Install **undotree**. Now you have a visual, branching undo history.
*Turn-in: Undo, branch, and recover a change you thought was lost*

### 🗡️ BOSS: The Five-Minute Sprint (80 XP)
Set a 5-minute timer. In a real project:
1. Use Telescope to find a file by name
2. Jump to a function with Treesitter motion
3. Rename a variable across the project
4. Harpoon-switch to your test file
5. Use a tmux pane to run the tests
6. Jump back, fix an issue, format on save
7. Use gitsigns to stage your changes

All in 5 minutes, no mouse, no leaving the terminal.

*Reward: You are faster in the terminal than you ever were with a GUI.*

**Zone 4 Total: 220 XP — You are LEVEL 17**

---

## 🌋 ZONE 5 — THE DEBUGGING DEPTHS (800 XP to enter)

*"Even the greatest warriors must sometimes descend into darkness to find the truth."*

**Theme:** Debugging, testing, and advanced LSP features.

### Quest Chain: Into the Depths

- [ ] **Quest 5.1 — The Debug Adapter** (40 XP)
  Install **nvim-dap** (debug adapter protocol). Configure it for your primary language.
  Set a breakpoint. Launch a debug session. Step through code.
  *Turn-in: Hit a breakpoint and inspect a variable value*

- [ ] **Quest 5.2 — The Debug UI** (20 XP)
  Install **nvim-dap-ui**. Now you have watch windows, call stacks, and REPL.
  Learn: continue (`<F5>`), step over (`<F10>`), step into (`<F11>`), step out (`<F12>`).
  *Turn-in: Step through a bug and find the issue using the DAP UI*

- [ ] **Quest 5.3 — The Test Runner** (30 XP)
  Install **neotest** with the adapter for your test framework.
  Run a single test, run a file, run the whole suite — all from within Neovim.
  *Turn-in: Run a single test and see inline pass/fail results*

- [ ] **Quest 5.4 — Diagnostics Mastery** (20 XP)
  Learn to navigate diagnostics efficiently:
  - `]d` / `[d` — jump between diagnostics
  - `<leader>d` — show diagnostic float
  - Telescope diagnostics — see all project issues at once
  *Turn-in: Find and fix 3 warnings in a file using only diagnostic navigation*

### 🗡️ BOSS: The Bug Hunt (100 XP)
Take a real bug in one of your projects:
1. Write a failing test with neotest
2. Set breakpoints with nvim-dap
3. Step through to identify the root cause
4. Fix it using LSP rename/refactor tools
5. Run the test again — green
6. Stage and commit without leaving Neovim (using gitsigns + a git plugin or terminal)

*Reward: Your terminal setup now does everything a $400/year IDE does.*

**Zone 5 Total: 210 XP — You are LEVEL 20 (Master)**

---

## 🏔️ ZONE 6 — THE SUMMIT (1100 XP to enter)

*"Few reach the summit. Those who do reshape the world to their will."*

**Theme:** Full customization, personal workflow optimization, and mastery.

### Quest Chain: Forge Your Legend

- [ ] **Quest 6.1 — The Snippet Forge** (30 XP)
  Install **LuaSnip**. Create 5 custom snippets for patterns you type daily.
  (e.g., function templates, test boilerplate, logging statements)
  *Turn-in: Trigger a custom snippet and tab through its placeholders*

- [ ] **Quest 6.2 — Your Own Commands** (30 XP)
  Write 3 custom Lua functions in your config that automate something you do often.
  Bind them to keymaps.
  *Turn-in: Trigger your custom function with a keymap*

- [ ] **Quest 6.3 — The Multi-Cursor Illusion** (20 XP)
  While Neovim has no native multi-cursor, learn to replicate it:
  - Visual block mode (`<C-v>`) + `I` or `A` for columnar edits
  - `:s` substitution with ranges
  - `cgn` pattern (change next search match, then `.` to repeat)
  *Turn-in: Make the same edit on 10 lines faster than a multi-cursor would*

- [ ] **Quest 6.4 — Session Management** (20 XP)
  Configure **auto-session** or **persistence.nvim**. Now when you open Neovim
  in a project directory, it restores your last session (open files, splits, cursor positions).
  *Turn-in: Close Neovim, reopen it, and find everything exactly as you left it*

- [ ] **Quest 6.5 — The Claude Workflow** (40 XP)
  Design your ideal Claude Code + Neovim tmux layout:
  - Claude Code in one pane
  - Neovim in another
  - A small pane for running tests/servers
  - Seamless navigation between all of them
  Write a tmux script that launches this layout with one command.
  *Turn-in: Run your script and land in your perfect workspace*

### 🗡️ FINAL BOSS: The Full Day (150 XP)
Spend an entire workday using only your terminal setup. No GUI editor.
No browser-based editor. Track every time you feel friction and note it.
At the end of the day, configure away each friction point.

*Reward: You have completed the Neovim Odyssey.*

**Zone 6 Total: 290 XP — You are LEVEL 25 (Grandmaster)**

---

## 📊 PROGRESS TRACKER

```
Zone 1: The Crossroads       [ ] Complete  60/110 XP
Zone 2: The Plugin Forest     [ ] Complete  ___/190 XP
Zone 3: The Tower of Language [ ] Complete  ___/260 XP
Zone 4: The Speed Plains      [ ] Complete  ___/220 XP
Zone 5: The Debugging Depths  [ ] Complete  ___/210 XP
Zone 6: The Summit            [ ] Complete  ___/290 XP
                                    TOTAL:  60/1280 XP
Side Quests Completed:        ___/4
Boss Encounters Cleared:      ___/6
```

---

## 🎒 DAILY QUESTS (Repeatable, 5 XP each)

Do these regularly to build muscle memory:

- [ ] Open a project. Find a file with Telescope. Make an edit. Save. All under 10 seconds.
- [ ] Use `gd` → `gr` → `<leader>rn` chain on a real symbol.
- [ ] Navigate your tmux+neovim layout without thinking about the keys.
- [ ] Solve a repetitive edit with a macro instead of doing it manually.
- [ ] Use Treesitter text objects (`daf`, `cif`, `via`) in real editing.

---

*"The blade was always sharp. Now the warrior sees the whole battlefield."*
