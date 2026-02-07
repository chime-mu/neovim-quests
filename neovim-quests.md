# THE MERIDIAN — Engineering Log

The Meridian has been in drydock for nine years.

She was built eighteen years ago — a deep-space exploration vessel, mid-weight
class, designed for long missions into uncharted systems. Her hull is solid. Her
reactor is rated for another forty years. But her software systems are a mess:
half-finished calibrations from the previous engineer, deprecated configs
nobody cleaned up, displays that still show someone else's preferences.

She's been towed back to service for a new mission. Deep space. Discovery.
The kind of run that needs everything working.

You're the new systems engineer. Your workstation is a terminal — the ship runs
on a Lua-based OS, and every system is controlled through terminal interfaces.
Configuring your editor isn't a metaphor for anything. It IS configuring the
ship. Your workspace is your instrument panel, and right now it's blank.

The corridors smell like recycled air. Panels creak when you lean on them.
But underneath the dust, this ship is capable of extraordinary things.

Time to bring her online.

---

## Zone 1 — The Bridge

The bridge is quiet. Half the overhead lights are off — power conservation
during drydock. Your workstation is the third console from the left, still
showing the previous engineer's login screen. The chair is worn but comfortable.
Someone left a coffee mug in the cupholder. It's been here a while.

A woman at the command console looks up from a status display. Short hair,
no-nonsense posture, the kind of person who's already assessed you before
you've finished introducing yourself.

> **Chief Torres:** "You're the new engineer. Good. Your workstation is cold —
> hasn't been powered on since Kovacs left. Get it running. I don't need
> it pretty. I need it functional."

### Quest Chain: First Steps

- [x] **Quest 1.1 — Bootstrap the Terminal** (10 XP)

  > **Chief Torres:** "Ship runs Neovim on every terminal. If yours doesn't
  > have it, install it. I need version 0.9 or better — anything older
  > and you'll be fighting compatibility issues all mission."

  Install Neovim (`brew install neovim` / `apt install neovim`).
  Run `nvim --version`. You need 0.9+.

  > **Chief Torres:** *glances at your screen* "Good. That's current."

- [x] **Quest 1.2 — Systems Check: Manual Navigation** (10 XP)

  > **Chief Torres:** "The previous engineer relied on GUI overlays for
  > everything. When those crashed — and they did — he couldn't navigate
  > bare terminal. Don't be like Kovacs. Show me you can work raw."

  Open a file with `nvim`. Navigate using only `hjkl`. Edit, save, quit.
  Confirm to yourself: this is home.

  > **Chief Torres:** *a brief nod* "You know your way around a terminal.
  > That's the baseline. Everything else builds on this."

- [x] **Quest 1.3 — Write the Ship Profile** (20 XP)

  > **Chief Torres:** "Every workstation on the ship reads from a personal
  > config. Yours is blank. Write it. Line numbers, tab behavior,
  > clipboard integration — the basics. Get your profile right now and
  > everything downstream gets easier."

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

  > **Chief Torres:** "Relative line numbers. Smart. Makes jump commands
  > precise without counting."

- [x] **Quest 1.4 — Run Diagnostics** (20 XP)

  > **Chief Torres:** "Before you touch anything else, run a full diagnostic.
  > `:checkhealth`. It'll flag missing dependencies, broken providers,
  > anything that'll cause problems later. Fix what it finds. I don't
  > want surprises once we're underway."

  Learn `:checkhealth`. Run it. Fix any warnings about missing providers.
  This is your diagnostic tool — you'll return to it often.

  > **Chief Torres:** "Clean diagnostic. You're ahead of most new
  > engineers who come through here."

### Boss Encounter: Cold Restart Drill (50 XP)

> **Chief Torres:** "All right. Pop quiz. I'm going to wipe your profile
> and you're going to rebuild it from memory. No reference material.
> If you can't configure your own workstation cold, you're not ready
> for deep space."

Without looking anything up, from a blank `init.lua`:
1. Set line numbers on
2. Set the leader key to space: `vim.g.mapleader = " "`
3. Create a keymap that saves the file with `<leader>w`
   *Hint: `vim.keymap.set("n", "<leader>w", ":w<CR>")`*
4. Reload config with `:source %`

> **Chief Torres:** *leans back in her chair* "You understand what you
> built. That's what matters. Neovim config is Lua — no magic, no
> abstraction layers. Just code you control." *nods toward the corridor*
> "Module Bay is down on Deck 3. Ren handles subsystem installations.
> She's... energetic. You'll manage."

---

## Zone 2 — The Module Bay

Deck 3 is warmer than the bridge — the module bay runs hot from integration
testing. Racks of subsystem modules line both walls, each one a self-contained
unit waiting to be loaded into the ship's software stack. Status lights blink
amber: installed but unconfigured. The air hums with potential.

A young operator spins around in her chair as you enter, headset half-on,
three displays running simultaneously. Something on her secondary monitor
is doing a live grep across what looks like the entire sensor array.

> **Ren:** "Oh! You're the new engineer! Torres told me you'd be coming.
> Welcome to the Module Bay — this is where the ship gets interesting.
> Everything up on the bridge is manual. Down here, we install the
> systems that make manual obsolete."

### Quest Chain: Subsystem Installation

- [ ] **Quest 2.1 — Initialize the Module Loader** (20 XP)

  > **Ren:** "First thing — you need a module loader. It's called
  > lazy.nvim. Without it, you're installing subsystems by hand,
  > which... I mean, you *could*, but why would you? It handles
  > dependencies, load order, updates — everything."

  Install **lazy.nvim** (the plugin manager). Add the bootstrap code from
  https://lazy.folke.io/installation to your `init.lua`.

  > **Ren:** *bounces in her chair* "You've got the loader! Open it
  > with `:Lazy` — see? Every module you install from now on shows
  > up right there."

- [ ] **Quest 2.2 — Sensor Array: Telescope** (30 XP)

  > **Ren:** "This is my favorite subsystem on the whole ship."
  > *pulls up a display* "Telescope. It's a fuzzy-search sensor
  > array — point it at any dataset and it finds what you need in
  > seconds. But you need to bind it to your console keys."

  Install **telescope.nvim** (fuzzy finder). Configure these keymaps:
  - `<leader>ff` — find files
  - `<leader>fg` — live grep across your project
  - `<leader>fb` — list open buffers

  > **Ren:** *watches you search* "There — see how fast it found
  > that file? This thing is going to save you hours. Trust me."

- [ ] **Quest 2.3 — File Navigation System** (20 XP)

  > **Ren:** "Telescope finds things, but it doesn't *organize* them.
  > For that you need a proper file navigator — something that maps
  > the directory structure and lets you manipulate it. I use Oil.
  > Some people prefer Neo-tree. Both work."

  Install **oil.nvim** or **neo-tree.nvim** (file explorer).
  Learn to navigate, create, rename, and delete files from within Neovim.

  > **Ren:** "You just created a file without leaving the terminal.
  > Think about that. Full filesystem control, right from your
  > workstation."

- [ ] **Quest 2.4 — Version Tracking Module** (20 XP)

  > **Ren:** "Okay, this one's important. Gitsigns — it hooks into
  > the version control system and shows you exactly what's changed.
  > Green for new lines, blue for modified, red for deleted. You can
  > even stage individual hunks — just the lines you want, not the
  > whole file."

  Install **gitsigns.nvim**. You should now see git diff markers in
  the sign column. Learn: `]c` / `[c` to jump between hunks, preview
  hunk, stage hunk, reset hunk.

  > **Ren:** "You staged a single hunk. Not the whole file — just
  > the exact change you wanted. That's precision version control."

- [ ] **Quest 2.5 — Interface Calibration** (10 XP)

  > **Ren:** "Okay, real talk — your terminal looks like it's still
  > running the factory default theme from nine years ago. The ship's
  > not glamorous, but your workstation should at least look like
  > someone's home. Pick a color scheme. Get a status bar."

  Install a **colorscheme** you love (catppuccin, tokyonight, gruvbox,
  rose-pine) and a **statusline** (lualine.nvim).

  > **Ren:** *chef's kiss* "Now THAT looks like a proper engineering
  > console. Professional."

### Side Quest: Command Reference Overlay (30 XP)

> **Ren:** "Almost forgot — there's a module called Which-Key. Press
> your leader key and wait... it shows every binding you've configured.
> Like having a reference manual built into your muscle memory."

Install **which-key.nvim**. Now when you press `<leader>` and pause,
a popup shows all available keymaps.

> **Ren:** "See? It remembers everything, even when you forget."

### Boss Encounter: Retrieval Operation (60 XP)

> **Ren:** *looking sheepish* "So... during drydock, someone misfiled
> a critical system config. I've been looking for it for a week. It's
> somewhere in the data archives. Use every tool we just installed —
> search, navigate, track the changes. Find it for me?"

1. Use Telescope's `find_files` to locate a file named `treasure.txt`
2. Use Telescope's `live_grep` to find which file contains the word "gold"
3. Use your file explorer to rename it to `claimed.txt`
4. Use gitsigns to stage and preview your changes

All without leaving Neovim.

> **Ren:** *pumps her fist* "You found it! And you did the whole thing
> without switching to a file manager or a GUI. That's what a properly
> configured workstation can do." *points toward the elevator*
> "Analysis Deck is two floors up. SOLEN runs it. Fair warning — SOLEN
> is the ship's AI. It's... precise."

---

## Zone 3 — The Analysis Deck

The Analysis Deck is the quietest part of the ship. Temperature-controlled,
vibration-dampened, the hum of processors barely audible behind the wall panels.
Displays show streaming code analysis — syntax trees, type hierarchies, symbol
maps. This is where the ship's intelligence systems live.

The main display flickers to life as you enter. A calm, precise voice fills
the room.

> **SOLEN:** "Welcome, engineer. I am the ship's onboard analysis system.
> I observe that you will be configuring the subsystems that govern my
> own language comprehension. I find this arrangement... appropriately
> recursive. Please proceed."

### Quest Chain: Language Systems

- [ ] **Quest 3.1 — Bring the Language Daemon Online** (30 XP)

  > **SOLEN:** "The Language Server Protocol. A standardized interface
  > through which your terminal communicates with any language's analysis
  > engine. Install nvim-lspconfig and connect it to a language server.
  > I will observe the results with considerable interest."

  Install **nvim-lspconfig**. Configure an LSP server for a language you use
  (e.g., `pyright` for Python, `ts_ls` for TypeScript, `lua_ls` for Lua).

  > **SOLEN:** "Diagnostics are appearing in your gutter. Those are not
  > heuristics. The language server parsed your code structurally. It knows."

- [ ] **Quest 3.2 — Query Protocols** (30 XP)

  > **SOLEN:** "A language server that cannot be queried is a database
  > with no interface. Configure these keybindings. They represent the
  > fundamental queries any systems engineer must have at hand."

  Set up LSP keymaps:
  - `gd` — go to definition
  - `gr` — find references
  - `K` — hover documentation
  - `<leader>rn` — rename symbol
  - `<leader>ca` — code actions

  > **SOLEN:** "You navigated to a definition and returned. The codebase
  > is no longer opaque to you. You can trace any call to its origin."

- [ ] **Quest 3.3 — Predictive Input System** (30 XP)

  > **SOLEN:** "Typing every function name in full is inefficient by
  > a factor I find uncomfortable to calculate. nvim-cmp provides
  > completions drawn directly from the language server. It does not
  > guess. It queries the type system."

  Install **nvim-cmp** (autocompletion) with LSP source.
  Configure it so completions appear as you type.

  > **SOLEN:** *a brief pause* "Intelligent suggestions. Derived from
  > structural analysis, not pattern matching. This is... satisfactory."

- [ ] **Quest 3.4 — Structural Parser** (20 XP)

  > **SOLEN:** "Regex-based syntax highlighting is adequate in the way
  > that a flashlight is adequate when a floodlight exists. Treesitter
  > constructs an actual syntax tree. It understands your code's
  > structure, not merely its surface patterns."

  Install **nvim-treesitter**. Enable `highlight`, `indent`, and
  `incremental_selection`. Your code should now be highlighted with
  actual syntactic understanding, not regex.

  > **SOLEN:** "Observe the difference. Nested strings, embedded
  > languages, complex expressions — all parsed correctly. The
  > flashlight has been replaced."

- [ ] **Quest 3.5 — Precision Selectors** (30 XP)

  > **SOLEN:** "And now, what I consider the most significant capability.
  > Treesitter text objects. The ability to select, delete, and manipulate
  > code by its semantic meaning, not its line position. A function is not
  > 'lines 42 through 58.' A function is a function."

  Learn Treesitter text objects (with **nvim-treesitter-textobjects**):
  - `af` / `if` — around/inside function
  - `ac` / `ic` — around/inside class
  - `aa` / `ia` — around/inside argument

  Practice: `daf` deletes an entire function. `cia` changes an argument.

  > **SOLEN:** "You deleted a function with three keystrokes, then
  > changed a single argument with three more. Your terminal now
  > operates with surgical precision."

### Side Quest: Auto-Formatting Protocol (20 XP)

> **SOLEN:** "An engineer who leaves inconsistently formatted code in
> the ship's systems is introducing unnecessary entropy. Conform.nvim
> will enforce formatting standards on every save."

Install **conform.nvim**. Configure format-on-save for your language.

> **SOLEN:** "Automatic. Consistent. Entropy reduced."

### Side Quest: Code Audit Daemon (20 XP)

> **SOLEN:** "The language server identifies errors. The linter identifies
> opinions — style violations, suspicious patterns, potential issues the
> server is too conservative to flag."

Install **nvim-lint**. Configure a linter for your language.

> **SOLEN:** "Two layers of analysis. The server and the linter.
> My diagnostic coverage is now comprehensive."

### Boss Encounter: System Refactor: Live (80 XP)

> **SOLEN:** *displays a file on the main screen* "This is the trial.
> A real file from one of your projects. One hundred lines or more.
> You will refactor it using every analysis tool available to you.
> I will be monitoring the results."

Take a real file from one of your projects (100+ lines). Without leaving Neovim:
1. Use `gd` to trace a function call to its definition
2. Rename a symbol with `<leader>rn` across the whole project
3. Use `gr` to verify all references updated
4. Delete an entire function using `daf`
5. Move it to another file using Treesitter-aware selection
6. Format both files on save

> **SOLEN:** *a long pause* "Your workstation now provides code
> intelligence equivalent to any integrated development environment.
> Superior, perhaps — because you understand every component." *the
> display shifts to a navigation chart* "The Nav Array is on Deck 7.
> Jin operates it. I recommend... patience."

---

## Zone 4 — The Nav Array

Deck 7 is all open space and holographic navigation charts. Star maps drift
across the ceiling, routes plotted and replotted in real time. The consoles
here are standing-height — nobody sits in the Nav Array. Everything is built
for speed.

A figure is running navigation drills at the far console, fingers moving so
fast the keystrokes blur together. They finish, check a timer, mutter
something dissatisfied, and reset. Then they notice you.

> **Jin:** "You're slow."

A beat.

> **Jin:** "That's fine. Everybody's slow when they get up here. Speed
> isn't about moving fast — it's about never stopping. Let's fix your
> workflow."

### Quest Chain: Speed Protocols

- [ ] **Quest 4.1 — Jump Navigation** (20 XP)

  > **Jin:** "hjkl. Line by line. Word by word. *Slow.* Flash lets you
  > jump to any visible word in two keystrokes. Two. Not twenty. Two."

  Install **flash.nvim** or **leap.nvim**. Learn to jump to any visible
  word in 2-3 keystrokes.

  > **Jin:** "Better. Still slow. But better."

- [ ] **Quest 4.2 — Quick-Access Markers** (30 XP)

  > **Jin:** "You have four files you touch every shift. Maybe five.
  > Why are you *searching* for them? Harpoon. Mark them. Switch
  > between them like breathing."

  Master **Harpoon** (by ThePrimeagen). Mark 4 files you work with
  frequently. Switch between them with `<leader>1` through `<leader>4`.

  > **Jin:** "Four files. Under two seconds. That's the baseline.
  > Get faster."

- [ ] **Quest 4.3 — Split-Screen Operations** (20 XP)

  > **Jin:** "One file at a time? What is this, a single-display
  > terminal from the 2040s? Splits. Learn them. Live in them."

  Learn split management:
  - `<C-w>v` vertical split, `<C-w>s` horizontal split
  - `<C-w>h/j/k/l` navigate splits
  - `<C-w>=` equalize, `<C-w>_` maximize height, `<C-w>|` maximize width

  Remap these to something faster (e.g., `<C-h/j/k/l>` to move between splits).

  > **Jin:** "Three splits. Three contexts. Zero friction. Now you're
  > thinking in parallel."

- [ ] **Quest 4.4 — Unified Console Bridge** (30 XP)

  > **Jin:** "Your terminal has walls. Tmux panes on one side, Neovim
  > splits on the other. vim-tmux-navigator tears those walls down.
  > One set of keys. Seamless."

  Install **vim-tmux-navigator** (or the Lua equivalent). Now
  `<C-h/j/k/l>` moves seamlessly between Neovim splits AND tmux panes.
  Claude Code in one pane, Neovim in another — one fluid workspace.

  > **Jin:** "You didn't even think about the boundary, did you?
  > That's the point."

- [ ] **Quest 4.5 — Batch Operations** (20 XP)

  > **Jin:** "Fifty lines. Same edit. You could do it one at a time.
  > Or you could do it once and let the macro do the rest.
  > `qq`, record, `q`, `50@q`. Done."

  You probably know macros from vi (`qq...q` then `@q`).
  Practice using them on real editing tasks. Record a macro that:
  1. Reformats a line of data
  2. Apply it to 50 lines with `50@q`

  > **Jin:** "Under thirty seconds. That's batch processing.
  > Everything else is just typing."

### Side Quest: Branch Recovery Protocol (20 XP)

> **Jin:** "Made a mistake? Wrong branch? Don't care. Undotree gives
> you a visual history of every change — including the ones you
> thought you lost. Time is a tree, not a line."

Install **undotree**. Now you have a visual, branching undo history.

> **Jin:** "You recovered a change from a dead branch. Version
> history bends for you now."

### Boss Encounter: Emergency Response Drill (80 XP)

> **Jin:** *starts a timer* "Five minutes. Real project. Everything
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

> **Jin:** *stops the timer, looks at it, then at you*
> "Faster in the terminal than any GUI jockey on the fleet."
> *nods toward the floor hatch* "Engine Room is below us.
> Vasquez runs it. Bring your focus."

---

## Zone 5 — The Engine Room

The Engine Room is deep in the ship — low ceilings, exposed conduit, the
constant thrum of the reactor behind the bulkhead. Status displays line every
surface, most of them showing nominal readings in green. A few pulse yellow.
One, in the corner, blinks red. Nobody seems alarmed.

A woman in engineer's coveralls sits on a crate, reviewing a diagnostic readout
with the calm of someone who's seen every failure mode there is. She looks
up. Unhurried.

> **Vasquez:** "Welcome to the Engine Room. Up there, you learned to write
> systems. Down here, you learn why they break." *taps the red display*
> "Take a breath. This part requires patience."

### Quest Chain: Deep Diagnostics

- [ ] **Quest 5.1 — Diagnostic Bridge Protocol** (40 XP)

  > **Vasquez:** "The Debug Adapter Protocol. DAP. It's the bridge
  > between your terminal and your language's debugger. Set a breakpoint.
  > Launch a session. Step through the code line by line. See what the
  > machine actually does, not what you think it does."

  Install **nvim-dap** (debug adapter protocol). Configure it for your
  primary language. Set a breakpoint. Launch a debug session. Step through code.

  > **Vasquez:** "You hit a breakpoint. You inspected a variable. You
  > saw the truth, not the assumption. That's the foundation of
  > everything down here."

- [ ] **Quest 5.2 — Diagnostic Interface** (20 XP)

  > **Vasquez:** "DAP alone is powerful but blind. The UI gives you
  > eyes — watch windows, call stacks, a REPL. Now you can see the
  > whole system at once."

  Install **nvim-dap-ui**. Now you have watch windows, call stacks,
  and REPL. Learn: continue (`<F5>`), step over (`<F10>`), step into
  (`<F11>`), step out (`<F12>`).

  > **Vasquez:** "You stepped through a fault and found it. Not by
  > guessing — by watching. That's the difference between patching
  > and engineering."

- [ ] **Quest 5.3 — Automated Test Harness** (30 XP)

  > **Vasquez:** "Tests are your early warning system. Without them,
  > you're flying blind. Neotest lets you run them right here — one
  > test, one file, the whole suite. Inline results. No context
  > switching."

  Install **neotest** with the adapter for your test framework.
  Run a single test, run a file, run the whole suite — all from
  within Neovim.

  > **Vasquez:** "Inline pass/fail. Right there in your code. You
  > never have to leave your workstation to know if something works."

- [ ] **Quest 5.4 — Error Navigation** (20 XP)

  > **Vasquez:** "The Engine Room is full of warnings. Most engineers
  > ignore them until they become failures. Don't be most engineers.
  > Learn to navigate diagnostics like you navigate code — with precision."

  Learn to navigate diagnostics efficiently:
  - `]d` / `[d` — jump between diagnostics
  - `<leader>d` — show diagnostic float
  - Telescope diagnostics — see all project issues at once

  > **Vasquez:** "Three warnings found and fixed using only diagnostic
  > navigation. You didn't grep. You didn't scroll. You *navigated*."

### Boss Encounter: Engine Fault: Trace and Repair (100 XP)

> **Vasquez:** *hands you a failing test report* "Real fault. Real system.
> This is why you're down here. Find it, fix it, prove it's fixed.
> Every tool you have. No guessing."

Take a real bug in one of your projects:
1. Write a failing test with neotest
2. Set breakpoints with nvim-dap
3. Step through to identify the root cause
4. Fix it using LSP rename/refactor tools
5. Run the test again — green
6. Stage and commit without leaving Neovim (using gitsigns + a git plugin or terminal)

> **Vasquez:** *nods once* "Your workstation now does everything a
> $400/year IDE does. And you understand every piece of it." *gestures
> toward the ladder* "Bridge is up top. Torres is waiting."

---

## Zone 6 — The Command Chair

The bridge looks different now. When you first came aboard, half the lights
were off and the displays were dark. Now every console is live. Systems you
configured are running across every screen — the sensor array, the analysis
systems, the navigation charts, the diagnostic feeds. The ship is alive.

Your workstation isn't the third console from the left anymore. It's the
central one.

Torres is standing by the viewport, watching the stars. The ship launched
weeks ago — drydock is a memory. You're in deep space now.

She doesn't turn around right away.

> **Chief Torres:** "When you came aboard, I gave you a cold workstation
> and told you to make it functional. You did more than that. You made
> this ship run." *she turns* "This zone is different. No more
> instruction. You know enough to build your own systems. I'm just
> here to sign off."

### Quest Chain: Custom Systems

- [ ] **Quest 6.1 — Custom Macros Library** (30 XP)

  > **Chief Torres:** "Every senior engineer I've served with had their
  > own shortcuts. Patterns they typed so often they could do it
  > in their sleep. LuaSnip lets you encode those patterns. Five
  > custom macros. The ones you use every single shift."

  Install **LuaSnip**. Create 5 custom snippets for patterns you type daily
  (e.g., function templates, test boilerplate, logging statements).

  > **Chief Torres:** "Custom macros. Your workflow, encoded. That's
  > not configuration — that's engineering."

- [ ] **Quest 6.2 — Write Your Own Systems** (30 XP)

  > **Chief Torres:** "Modules are other people's solutions. Now write
  > your own. Three functions. Things only *you* need. Bind them to
  > keys. Make this terminal do something it's never done before —
  > because you told it to."

  Write 3 custom Lua functions in your config that automate something
  you do often. Bind them to keymaps.

  > **Chief Torres:** "That function exists because you needed it and
  > you built it. Nobody else on any ship has that binding. It's yours."

- [ ] **Quest 6.3 — Parallel Editing Protocols** (20 XP)

  > **Chief Torres:** "The GUI operators love their multi-cursors.
  > Flashy. Impressive looking. Slow. You have something better —
  > three techniques that are faster and more precise."

  While Neovim has no native multi-cursor, learn to replicate it:
  - Visual block mode (`<C-v>`) + `I` or `A` for columnar edits
  - `:s` substitution with ranges
  - `cgn` pattern (change next search match, then `.` to repeat)

  > **Chief Torres:** "Ten lines. Same edit. Faster than any multi-cursor.
  > And you didn't need a mouse to place a single one of them."

- [ ] **Quest 6.4 — Persistent Workspace** (20 XP)

  > **Chief Torres:** "An engineer who has to rebuild their console layout
  > every shift is wasting time. Session management. When you close your
  > terminal and reopen it, everything should be exactly where you left it."

  Configure **auto-session** or **persistence.nvim**. Now when you open
  Neovim in a project directory, it restores your last session (open files,
  splits, cursor positions).

  > **Chief Torres:** "You closed it. You reopened it. Everything's still
  > there. That's not a feature — that's respect for your time."

- [ ] **Quest 6.5 — Human-AI Console Layout** (40 XP)

  > **Chief Torres:** "The old engineers worked alone. That was their
  > limitation. You have something they never had — an AI system that
  > can write code, answer questions, and work alongside you. But only
  > if your workspace is built for it."

  Design your ideal Claude Code + Neovim tmux layout:
  - Claude Code in one pane
  - Neovim in another
  - A small pane for running tests/servers
  - Seamless navigation between all of them

  Write a tmux script that launches this layout with one command.

  > **Chief Torres:** "One command. Perfect workspace. Human and AI,
  > side by side. This is how modern engineering works."

### Final Boss: Full Shift (150 XP)

> **Chief Torres:** *sits in the command chair, then stands and gestures
> you toward it* "Last one. No timer this time. No drill. Just a full
> shift of real work. Your projects. Your problems. Your terminal.
> Nothing else. Every time something feels wrong, log it. Then fix it."

Spend an entire workday using only your terminal setup. No GUI editor.
No browser-based editor. Track every time you feel friction and note it.
At the end of the day, configure away each friction point.

> **Chief Torres:** *watches the stars from the viewport*
> "You came aboard as a new hire with a blank workstation. You're leaving
> this zone as the engineer who brought The Meridian back to life."
>
> *She pauses. Then, for the first time:*
>
> "Good work, engineer. The ship is yours."

---

## Ship's Log — Engineering Division

*Filed in the margins of your config files.*

### Systems Status
- [x] **The Bridge** — Torres cleared me for duty.
- [ ] **The Module Bay** — Ren's subsystems await installation.
- [ ] **The Analysis Deck** — SOLEN's language systems remain offline.
- [ ] **The Nav Array** — Jin's speed protocols unlearned.
- [ ] **The Engine Room** — Vasquez's diagnostics untouched.
- [ ] **The Command Chair** — The seat is empty.

### Service Record
Quests completed: 4/30 | Bosses: 0/6 | Side Quests: 0/4 | XP: 60/1280 | Level: 3

---

## Daily Drills

*Jin maintains the drill schedule. Shows up to the Nav Array at 0600 whether
anyone else does or not.*

> **Jin:** "Five drills. Every shift. No excuses. Speed is a muscle.
> If you don't use it, you lose it."

Do these regularly to build muscle memory (5 XP each):

- [ ] Open a project. Find a file with Telescope. Make an edit. Save. All under 10 seconds.
- [ ] Use `gd` → `gr` → `<leader>rn` chain on a real symbol.
- [ ] Navigate your tmux+neovim layout without thinking about the keys.
- [ ] Solve a repetitive edit with a macro instead of doing it manually.
- [ ] Use Treesitter text objects (`daf`, `cif`, `via`) in real editing.

> **Jin:** "Same drills, every shift. Until the keys disappear and
> only the intent remains."

---

*"The ship was always capable. Now the engineer sees the whole system."*
