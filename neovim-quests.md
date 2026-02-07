# NEOVIM ODYSSEY — The Exile's Return

The road to Neovim is overgrown. You haven't walked it in years.

You were a warrior of the Vi Order — terminal monks who mastered modal editing
before most developers learned to type. A schism split the order: the old guard
clung to Vim, while the builders forged something new. They called it Neovim —
a city raised on Vi's ancient foundations but open to the world beyond.

You left during the schism. You wandered. You survived on borrowed tools and
bloated IDEs that did the thinking for you — and charged you for the privilege.

Now you return. The city still stands. But its borders are threatened by
sprawling GUI empires, and the old disciplines are being forgotten. The
gatekeepers are looking for warriors who remember the old ways and are willing
to learn the new ones.

Your blade is sharp. Your muscle memory runs deep. But this city has changed,
and so must you.

---

## Zone 1 — The Crossroads

The road ends at a stone archway, half-reclaimed by moss. Beyond it, a dusty
courtyard where new arrivals are tested. Weapon racks line the walls — each one
holding a different version of the same blade, each one slightly different from
the one you remember. A fire pit crackles in the center, tended by no one.

A man stands at the gate. His hands are scarred from decades of terminal work.
He looks you over once, says nothing, then tosses you a scabbard.

> **Kael:** "Everyone who comes through here thinks they know the blade.
> Most of them are wrong. Let's find out which kind you are."

### Quest Chain: First Steps

- [x] **Quest 1.1 — Install the Blade** (10 XP)

  > **Kael:** "First things first. You can't fight with a weapon you
  > don't have. Get Neovim on your machine — I don't care how. Brew,
  > apt, build from source if you're the stubborn type. Just make sure
  > it's sharp enough. Version 0.9 or better."

  Install Neovim (`brew install neovim` / `apt install neovim`).
  Run `nvim --version`. You need 0.9+.

  > **Kael:** *nods slowly* "Good steel. That'll do."

- [x] **Quest 1.2 — The Old Ways Still Work** (10 XP)

  > **Kael:** "I've seen warriors come from those GUI empires.
  > Soft hands. Can't navigate without a mouse. But you —
  > you've got that look. Show me the old ways still live in you."

  Open a file with `nvim`. Navigate using only `hjkl`. Edit, save, quit.
  Confirm to yourself: this is home.

  > **Kael:** *a rare half-smile* "You remember. Good. The old ways
  > are the foundation. Everything else is built on top."

- [x] **Quest 1.3 — Forge Your Config** (20 XP)

  > **Kael:** "Every warrior's blade is different. In this city, your
  > config file is your blade. Forge it wrong and it'll shatter in your
  > hand. Forge it right and it becomes an extension of your will."

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

  > **Kael:** "Relative numbers. Smart. You'll know exactly how far
  > to jump before you even think about it."

- [x] **Quest 1.4 — The Adventurer's Map** (20 XP)

  > **Kael:** "Before you go deeper, learn to read the terrain. The city
  > has a built-in diagnostic — `:checkhealth`. It'll tell you what's
  > working and what's broken. Fix what it complains about. You don't
  > want surprises where you're going."

  Learn `:checkhealth`. Run it. Fix any warnings about missing providers.
  This is your diagnostic tool — you'll return to it often.

  > **Kael:** "Clean health check. You're better prepared than most
  > who pass through here."

### Boss Encounter: The Config Gauntlet (50 XP)

> **Kael:** "All right. I've been easy on you so far. Now I want to see
> if you actually *understand* what you've done, or if you just copied
> what I told you. Start from nothing. Build it back."

Without looking anything up, from a blank `init.lua`:
1. Set line numbers on
2. Set the leader key to space: `vim.g.mapleader = " "`
3. Create a keymap that saves the file with `<leader>w`
   *Hint: `vim.keymap.set("n", "<leader>w", ":w<CR>")`*
4. Reload config with `:source %`

> **Kael:** *leans against the gate, arms crossed* "You understand now.
> Neovim config is just Lua. No magic. No mystery. Just code you control.
> The Plugin Forest is through those trees. A girl named Lyra runs things
> there — she's... enthusiastic. Tell her I sent you."

---

## Zone 2 — The Plugin Forest

The trees here are strange — their bark shifts with syntax colors, and their
roots tangle into `.lua` files that snake across the forest floor. Floating
orbs drift between the branches, each one a plugin waiting to be bound.
Something rustles in the canopy. It sounds like autocomplete.

A young woman drops from a branch and lands in front of you, grinning. A
shimmering creature — half telescope, half falcon — perches on her shoulder.

> **Lyra:** "Kael sent you? Perfect! I've been waiting for someone who
> actually knows what `hjkl` means. Welcome to the Forest. Everything
> here is alive — you just need to learn how to call them."

### Quest Chain: Summoning Allies

- [ ] **Quest 2.1 — The Summoner's Tome** (20 XP)

  > **Lyra:** "Before you can summon anything, you need the Tome.
  > It's called lazy.nvim — the spellbook that manages all your
  > creatures. Without it, you're just shouting into the trees."

  Install **lazy.nvim** (the plugin manager). Add the bootstrap code from
  https://lazy.folke.io/installation to your `init.lua`.

  > **Lyra:** *bounces on her heels* "You've got the Tome! Open it
  > with `:Lazy` — see? All your future allies will appear there."

- [ ] **Quest 2.2 — First Ally: The Pathfinder** (30 XP)

  > **Lyra:** "Meet Telescope — she's my fastest scout." *the creature
  > on her shoulder spreads luminous wings* "Point her at any forest
  > and she'll find what you're looking for in seconds. But she needs
  > your keybindings to know where to search."

  Install **telescope.nvim** (fuzzy finder). Configure these keymaps:
  - `<leader>ff` — find files
  - `<leader>fg` — live grep across your project
  - `<leader>fb` — list open buffers

  > **Lyra:** *strokes the telescope fondly* "There — see how she
  > found that file? She's yours now. Treat her well."

- [ ] **Quest 2.3 — Second Ally: The Cartographer** (20 XP)

  > **Lyra:** "Telescope finds things, but she doesn't *organize*
  > them. For that, you need a Cartographer — something that maps
  > the territory and lets you reshape it. I like Oil, personally.
  > Some people prefer Neo-tree. They're both good creatures."

  Install **oil.nvim** or **neo-tree.nvim** (file explorer).
  Learn to navigate, create, rename, and delete files from within Neovim.

  > **Lyra:** "You just created a file without ever leaving Neovim.
  > Think about that. The forest answers to you now."

- [ ] **Quest 2.4 — Third Ally: The Chronomancer** (20 XP)

  > **Lyra:** "This one's special. Gitsigns — she can see through
  > time. Every change you make, she marks in the gutter. Green
  > for new, blue for changed, red for deleted. She even lets you
  > stage hunks one at a time, like plucking threads from a tapestry."

  Install **gitsigns.nvim**. You should now see git diff markers in
  the sign column. Learn: `]c` / `[c` to jump between hunks, preview
  hunk, stage hunk, reset hunk.

  > **Lyra:** "You staged a single hunk. Not the whole file — just
  > the exact change you wanted. That's precision. That's control."

- [ ] **Quest 2.5 — Vanity and Glory** (10 XP)

  > **Lyra:** "Okay, real talk — you can't walk around the Forest
  > looking like *that*. Your editor is giving 'default terminal,
  > circa 2003.' Let's fix that."

  Install a **colorscheme** you love (catppuccin, tokyonight, gruvbox,
  rose-pine) and a **statusline** (lualine.nvim).

  > **Lyra:** *chef's kiss* "Now THAT is a warrior's interface.
  > Looking dangerous."

### Side Quest: The Whisperer (30 XP)

> **Lyra:** "Almost forgot — there's a creature hiding near the
> clearing called Which-Key. Press your leader and wait... she
> whispers every keybinding you've set. Like having a tooltip
> system built into your muscle memory."

Install **which-key.nvim**. Now when you press `<leader>` and pause,
a popup shows all available keymaps.

> **Lyra:** "See? She remembers everything, even when you forget."

### Boss Encounter: The Lost File (60 XP)

> **Lyra:** *looking sheepish* "So... I may have lost something
> in the deep forest. A treasure file. I hid it for safekeeping
> and now I can't remember where. Use everything you've learned —
> all your allies working together. Find it for me?"

1. Use Telescope's `find_files` to locate a file named `treasure.txt`
2. Use Telescope's `live_grep` to find which file contains the word "gold"
3. Use your file explorer to rename it to `claimed.txt`
4. Use gitsigns to stage and preview your changes

All without leaving Neovim.

> **Lyra:** *hugs her telescope creature* "You found it! And you
> did the whole thing without touching a file manager or a GUI.
> That's the power of the Forest." *points deeper into the trees*
> "The Tower of Language is that way. Archivist Solen runs it.
> He's... formal. Don't touch his scrolls without asking."

---

## Zone 3 — The Tower of Language

The Tower rises above the canopy, its walls covered in flowing script that
shifts between programming languages — Lua one moment, Python the next, then
TypeScript, then something older that looks like raw assembly. Inside, the
air smells of parchment and electricity. Shelves stretch to the ceiling, each
one holding a language server — small glowing orbs that pulse with understanding.

An elderly man in precise robes looks up from a massive codex. He adjusts
spectacles that somehow display type signatures.

> **Archivist Solen:** "Ah. Another one from the Forest. I trust
> Lyra's creatures didn't chew on anything important. Welcome to
> the Tower. Here, we teach your blade to *understand* what it cuts."

### Quest Chain: The Language Protocols

- [ ] **Quest 3.1 — The Interpreter's Guild** (30 XP)

  > **Archivist Solen:** "The Language Server Protocol. It is —
  > and I do not use this word lightly — *elegant*. A single
  > interface through which your editor speaks to any language.
  > Install nvim-lspconfig and bind it to a server you trust."

  Install **nvim-lspconfig**. Configure an LSP server for a language you use
  (e.g., `pyright` for Python, `ts_ls` for TypeScript, `lua_ls` for Lua).

  > **Archivist Solen:** "You see the diagnostics in the gutter?
  > Those are not guesses. The server *parsed your code*. It knows."

- [ ] **Quest 3.2 — The Oracle Speaks** (30 XP)

  > **Archivist Solen:** "A language server that cannot be queried
  > is a library with no index. Set these keymaps. They are the
  > fundamental queries every scholar must know."

  Set up LSP keymaps:
  - `gd` — go to definition
  - `gr` — find references
  - `K` — hover documentation
  - `<leader>rn` — rename symbol
  - `<leader>ca` — code actions

  > **Archivist Solen:** "You jumped to a definition and returned.
  > The code is no longer opaque to you. You can trace any thread
  > to its origin."

- [ ] **Quest 3.3 — The Scribe's Quill** (30 XP)

  > **Archivist Solen:** "Typing every function name in full is
  > the mark of a novice. The Scribe's Quill — nvim-cmp — will
  > suggest completions drawn directly from the language server.
  > It does not guess. It *knows*."

  Install **nvim-cmp** (autocompletion) with LSP source.
  Configure it so completions appear as you type.

  > **Archivist Solen:** *permits himself a thin smile*
  > "Intelligent suggestions. Not snippets from a database —
  > completions that understand your code's type system."

- [ ] **Quest 3.4 — The Living Syntax** (20 XP)

  > **Archivist Solen:** "Regex-based highlighting is... adequate.
  > In the way that a candle is adequate when the sun exists.
  > Treesitter builds an actual syntax tree. It *understands*
  > your code's structure, not just its surface."

  Install **nvim-treesitter**. Enable `highlight`, `indent`, and
  `incremental_selection`. Your code should now be highlighted with
  actual syntactic understanding, not regex.

  > **Archivist Solen:** "Notice the difference. Nested strings,
  > embedded languages, complex expressions — all correct. The
  > candle has been replaced."

- [ ] **Quest 3.5 — The Surgeon's Tools** (30 XP)

  > **Archivist Solen:** "And now, the crown jewel. Treesitter
  > text objects. The ability to select, delete, and manipulate
  > code by its *meaning*, not its position. A function is not
  > 'lines 42 through 58.' A function is a function."

  Learn Treesitter text objects (with **nvim-treesitter-textobjects**):
  - `af` / `if` — around/inside function
  - `ac` / `ic` — around/inside class
  - `aa` / `ia` — around/inside argument

  Practice: `daf` deletes an entire function. `cia` changes an argument.

  > **Archivist Solen:** "You deleted a function with three
  > keystrokes, then changed a single argument with three more.
  > Your blade now cuts with surgical precision."

### Side Quest: The Formatter (20 XP)

> **Archivist Solen:** "A scholar who leaves their manuscripts
> inconsistently formatted is no scholar at all. Conform.nvim
> will enforce discipline on every save."

Install **conform.nvim**. Configure format-on-save for your language.

> **Archivist Solen:** "Automatic. Consistent. As it should be."

### Side Quest: The Lint Hound (20 XP)

> **Archivist Solen:** "The language server catches errors. The
> linter catches *opinions* — style violations, suspicious patterns,
> potential bugs the server is too polite to mention."

Install **nvim-lint**. Configure a linter for your language.

> **Archivist Solen:** "Two layers of analysis. The server and
> the linter. Nothing escapes the Tower's scrutiny now."

### Boss Encounter: The Refactoring Trial (80 XP)

> **Archivist Solen:** *places a thick file on the desk*
> "This is the Trial. A real file from one of your projects.
> One hundred lines or more. You will refactor it using every
> tool the Tower has given you. No shortcuts. No excuses."

Take a real file from one of your projects (100+ lines). Without leaving Neovim:
1. Use `gd` to trace a function call to its definition
2. Rename a symbol with `<leader>rn` across the whole project
3. Use `gr` to verify all references updated
4. Delete an entire function using `daf`
5. Move it to another file using Treesitter-aware selection
6. Format both files on save

> **Archivist Solen:** *closes the codex with a decisive snap*
> "Your editor now understands code as well as any IDE. Better,
> perhaps — because you understand what it's doing." *gestures
> toward the plains below* "Dash is down there. He'll teach you
> speed. Try to keep up."

---

## Zone 4 — The Speed Plains

The land opens into vast golden plains where the wind never stops. Paths
crisscross the grass in impossible patterns — shortcuts, wormholes, routes
that fold space and time. In the distance, a figure moves so fast it leaves
afterimages. Then it's standing right in front of you, not even breathing hard.

> **Dash:** "You're slow."

A pause. He tilts his head.

> **Dash:** "That's fine. Everyone's slow at first. Speed isn't about
> moving fast — it's about never stopping. Let's fix your workflow."

### Quest Chain: The Way of Speed

- [ ] **Quest 4.1 — The Leap** (20 XP)

  > **Dash:** "hjkl. Line by line. Word by word. *Slow.*
  > Flash lets you jump to any visible word in two keystrokes.
  > Two. Not twenty. Two."

  Install **flash.nvim** or **leap.nvim**. Learn to jump to any visible
  word in 2-3 keystrokes.

  > **Dash:** "Better. Still slow. But better."

- [ ] **Quest 4.2 — The Portal Network** (30 XP)

  > **Dash:** "You have four files you touch every day. Maybe five.
  > Why are you *searching* for them? Harpoon. Mark them. Switch
  > between them like breathing."

  Master **Harpoon** (by ThePrimeagen). Mark 4 files you work with
  frequently. Switch between them with `<leader>1` through `<leader>4`.

  > **Dash:** "Four files. Under two seconds. That's the baseline.
  > Get faster."

- [ ] **Quest 4.3 — Window Mastery** (20 XP)

  > **Dash:** "One file at a time? What is this, a typewriter?
  > Splits. Learn them. Live in them."

  Learn split management:
  - `<C-w>v` vertical split, `<C-w>s` horizontal split
  - `<C-w>h/j/k/l` navigate splits
  - `<C-w>=` equalize, `<C-w>_` maximize height, `<C-w>|` maximize width

  Remap these to something faster (e.g., `<C-h/j/k/l>` to move between splits).

  > **Dash:** "Three splits. Three contexts. Zero friction.
  > Now you're thinking in parallel."

- [ ] **Quest 4.4 — The Tmux Bridge** (30 XP)

  > **Dash:** "Your terminal has walls. Tmux panes on one side,
  > Neovim splits on the other. vim-tmux-navigator tears those
  > walls down. One set of keys. Seamless."

  Install **vim-tmux-navigator** (or the Lua equivalent). Now
  `<C-h/j/k/l>` moves seamlessly between Neovim splits AND tmux panes.
  Claude Code in one pane, Neovim in another — one fluid workspace.

  > **Dash:** "You didn't even think about the boundary, did you?
  > That's the point."

- [ ] **Quest 4.5 — Macro Warfare** (20 XP)

  > **Dash:** "Fifty lines. Same edit. You could do it one at a time.
  > Or you could do it once and let the macro do the rest.
  > `qq`, record, `q`, `50@q`. Done."

  You probably know macros from vi (`qq...q` then `@q`).
  Practice using them on real editing tasks. Record a macro that:
  1. Reformats a line of data
  2. Apply it to 50 lines with `50@q`

  > **Dash:** "Under thirty seconds. That's a macro warrior.
  > Everything else is just typing."

### Side Quest: The Undying (20 XP)

> **Dash:** "Made a mistake? Wrong branch? Don't care. Undotree
> gives you a visual history of every change — including the ones
> you thought you lost. Time is a tree, not a line."

Install **undotree**. Now you have a visual, branching undo history.

> **Dash:** "You recovered a change from a dead branch. Time
> itself bends for you now."

### Boss Encounter: The Five-Minute Sprint (80 XP)

> **Dash:** *starts a timer* "Five minutes. Real project. Everything
> you've learned, all at once. If you stop to think about which key
> to press, you've already lost. Go."

Set a 5-minute timer. In a real project:
1. Use Telescope to find a file by name
2. Jump to a function with Treesitter motion
3. Rename a variable across the project
4. Harpoon-switch to your test file
5. Use a tmux pane to run the tests
6. Jump back, fix an issue, format on save
7. Use gitsigns to stage your changes

All in 5 minutes, no mouse, no leaving the terminal.

> **Dash:** *stops the timer, looks at it, then at you*
> "You're faster in the terminal than you ever were with a GUI."
> *points down, toward a cave entrance* "Maren's down there.
> The Depths. Bring a light."

---

## Zone 5 — The Debugging Depths

The cave mouth exhales cold air that smells of copper and logic. Bioluminescent
fungi line the walls, pulsing in patterns that look suspiciously like stack
traces. The deeper you go, the more the walls narrow — until you find a vast
underground chamber, lit by hundreds of floating diagnostic markers. Red for
errors. Yellow for warnings. Green for the rare, beautiful passing test.

A woman in engineer's overalls sits cross-legged on a rock, surrounded by
blueprints of call stacks. She looks up calmly.

> **Maren:** "Welcome to the Depths. Up there, you learned to write code.
> Down here, you learn to understand why it breaks. Take a breath.
> This part requires patience."

### Quest Chain: Into the Depths

- [ ] **Quest 5.1 — The Debug Adapter** (40 XP)

  > **Maren:** "The Debug Adapter Protocol. DAP. It's the bridge
  > between your editor and your language's debugger. Set a breakpoint.
  > Launch a session. Step through the code line by line. See what
  > the machine actually does, not what you think it does."

  Install **nvim-dap** (debug adapter protocol). Configure it for your
  primary language. Set a breakpoint. Launch a debug session. Step through code.

  > **Maren:** "You hit a breakpoint. You inspected a variable.
  > You saw the truth, not the assumption. That's the foundation
  > of everything down here."

- [ ] **Quest 5.2 — The Debug UI** (20 XP)

  > **Maren:** "DAP alone is powerful but blind. The UI gives you
  > eyes — watch windows, call stacks, a REPL. Now you can see
  > the whole machine at once."

  Install **nvim-dap-ui**. Now you have watch windows, call stacks,
  and REPL. Learn: continue (`<F5>`), step over (`<F10>`), step into
  (`<F11>`), step out (`<F12>`).

  > **Maren:** "You stepped through a bug and found it. Not by
  > guessing — by watching. That's the difference between a
  > developer and a debugger."

- [ ] **Quest 5.3 — The Test Runner** (30 XP)

  > **Maren:** "Tests are your map of the Depths. Without them,
  > you're wandering blind. Neotest lets you run them right here —
  > one test, one file, the whole suite. Inline results. No context
  > switching."

  Install **neotest** with the adapter for your test framework.
  Run a single test, run a file, run the whole suite — all from
  within Neovim.

  > **Maren:** "Inline pass/fail. Right there in your code.
  > You never have to leave to know if something works."

- [ ] **Quest 5.4 — Diagnostics Mastery** (20 XP)

  > **Maren:** "The Depths are full of warnings. Most people ignore
  > them until they become errors. Don't be most people. Learn to
  > navigate diagnostics like you navigate code — with precision."

  Learn to navigate diagnostics efficiently:
  - `]d` / `[d` — jump between diagnostics
  - `<leader>d` — show diagnostic float
  - Telescope diagnostics — see all project issues at once

  > **Maren:** "Three warnings found and fixed using only diagnostic
  > navigation. You didn't grep. You didn't scroll. You *navigated*."

### Boss Encounter: The Bug Hunt (100 XP)

> **Maren:** *hands you a failing test report* "Real bug. Real project.
> This is why you came down here. Find it, fix it, prove it's fixed.
> Every tool you have. No guessing."

Take a real bug in one of your projects:
1. Write a failing test with neotest
2. Set breakpoints with nvim-dap
3. Step through to identify the root cause
4. Fix it using LSP rename/refactor tools
5. Run the test again — green
6. Stage and commit without leaving Neovim (using gitsigns + a git plugin or terminal)

> **Maren:** *nods with quiet satisfaction* "Your terminal setup now does
> everything a $400/year IDE does. And you understand every piece of it."
> *gestures toward a staircase carved into the rock* "The Summit is up
> there. You'll know what to do when you reach it."

---

## Zone 6 — The Summit

The air thins. The view is infinite. From up here, you can see every zone
you've crossed — the Crossroads where Kael tested you, the Forest where Lyra
introduced you to your first allies, the Tower where Solen taught your blade
to think, the Plains where Dash taught your hands to fly, the Depths where
Maren taught you to see in the dark.

There is no NPC waiting. No quest giver at the gate. Just a flat stone, a
cold wind, and the realization that there is nothing left to learn from others.

Then you notice the stone has an inscription:

> *"The summit is not the end. It is the place where you stop following
> and start building."*

And behind you — footsteps. Kael. Older. Slower. But smiling.

> **Kael:** "You made it. I had a feeling you would. But this zone
> is different. Up here, there are no teachers. No guides. You
> know enough now to forge your own path. I'm just here to watch."

### Quest Chain: Forge Your Legend

- [ ] **Quest 6.1 — The Snippet Forge** (30 XP)

  > **Kael:** "Every master I've known had their own shortcuts.
  > Patterns they typed so often they could do it in their sleep.
  > LuaSnip lets you bottle those patterns. Five snippets.
  > The ones you type every single day."

  Install **LuaSnip**. Create 5 custom snippets for patterns you type daily
  (e.g., function templates, test boilerplate, logging statements).

  > **Kael:** "Custom snippets. Your workflow, encoded. That's
  > not configuration — that's craftsmanship."

- [ ] **Quest 6.2 — Your Own Commands** (30 XP)

  > **Kael:** "Plugins are other people's solutions. Now write your own.
  > Three functions. Things only *you* need. Bind them to keys.
  > Make Neovim do something it's never done before — because you
  > told it to."

  Write 3 custom Lua functions in your config that automate something
  you do often. Bind them to keymaps.

  > **Kael:** "That function exists because you needed it and you built it.
  > Nobody else in the world has that keymap. It's yours."

- [ ] **Quest 6.3 — The Multi-Cursor Illusion** (20 XP)

  > **Kael:** "The GUI warriors love their multi-cursors. Flashy.
  > Impressive looking. Slow. You have something better — three
  > techniques that are faster and more precise."

  While Neovim has no native multi-cursor, learn to replicate it:
  - Visual block mode (`<C-v>`) + `I` or `A` for columnar edits
  - `:s` substitution with ranges
  - `cgn` pattern (change next search match, then `.` to repeat)

  > **Kael:** "Ten lines. Same edit. Faster than any multi-cursor.
  > And you didn't need a mouse to place a single one of them."

- [ ] **Quest 6.4 — Session Management** (20 XP)

  > **Kael:** "A warrior who has to rebuild their camp every morning
  > is wasting daylight. Session management. When you close Neovim
  > and reopen it, everything should be exactly where you left it."

  Configure **auto-session** or **persistence.nvim**. Now when you open
  Neovim in a project directory, it restores your last session (open files,
  splits, cursor positions).

  > **Kael:** "You closed it. You reopened it. Everything's still there.
  > That's not a feature — that's respect for your time."

- [ ] **Quest 6.5 — The Claude Workflow** (40 XP)

  > **Kael:** "The old order worked alone. That was its weakness.
  > You have something we never had — an AI companion that can write
  > code, answer questions, and work alongside you. But only if
  > your workspace is built for it."

  Design your ideal Claude Code + Neovim tmux layout:
  - Claude Code in one pane
  - Neovim in another
  - A small pane for running tests/servers
  - Seamless navigation between all of them

  Write a tmux script that launches this layout with one command.

  > **Kael:** "One command. Perfect workspace. Human and AI,
  > side by side. This is what the future of the order looks like."

### Final Boss: The Full Day (150 XP)

> **Kael:** *sits on the summit stone* "Last one. No timer this time.
> No artificial challenge. Just a full day of real work. Your projects.
> Your problems. Your terminal. Nothing else. Every time something
> feels wrong, write it down. Then fix it."

Spend an entire workday using only your terminal setup. No GUI editor.
No browser-based editor. Track every time you feel friction and note it.
At the end of the day, configure away each friction point.

> **Kael:** *watches the sunset from the summit* "You came here a
> wanderer. You leave a master. The Neovim Odyssey is complete —
> but the road never really ends. There's always another plugin,
> another keybinding, another workflow to sharpen."
>
> *He pauses.*
>
> "Someone new will come through the Crossroads tomorrow. Maybe
> you'll be the one standing at the gate."

---

## Chronicle of the Vi Warrior

*You keep this journal in the margins of your config files.*

### Territories
- [x] **The Crossroads** — Kael judged me worthy.
- [ ] **The Plugin Forest** — Lyra's creatures await.
- [ ] **The Tower of Language** — Solen's protocols remain unlearned.
- [ ] **The Speed Plains** — Dash's challenge stands.
- [ ] **The Debugging Depths** — Maren's caverns are dark.
- [ ] **The Summit** — The inscription waits.

### Battle Record
Quests completed: 4/30 | Bosses: 0/6 | Side Quests: 0/4 | XP: 60/1280 | Level: 3

---

## The Training Grounds

*A flat clearing near the Crossroads. Dash maintains it — he says warriors
who don't drill daily aren't warriors, they're tourists.*

> **Dash:** "Five drills. Every day. No excuses. Speed is a muscle.
> If you don't use it, you lose it."

Do these regularly to build muscle memory (5 XP each):

- [ ] Open a project. Find a file with Telescope. Make an edit. Save. All under 10 seconds.
- [ ] Use `gd` → `gr` → `<leader>rn` chain on a real symbol.
- [ ] Navigate your tmux+neovim layout without thinking about the keys.
- [ ] Solve a repetitive edit with a macro instead of doing it manually.
- [ ] Use Treesitter text objects (`daf`, `cif`, `via`) in real editing.

> **Dash:** "Same drills, every day. Until the keys disappear and
> only the intent remains."

---

*"The blade was always sharp. Now the warrior sees the whole battlefield."*
