defmodule NeovimOdyssey.Quests.Data do
  @moduledoc false

  alias NeovimOdyssey.Quests.{Quest, Zone}

  def zones do
    [zone_1(), zone_2(), zone_3(), zone_4(), zone_5(), zone_6()]
  end

  def daily_quests do
    [
      %Quest{
        id: "daily_1",
        zone_id: nil,
        number: "D1",
        name: "Speed Opener",
        xp: 5,
        description: "Open a project. Find a file with Telescope. Make an edit. Save.",
        objectives: ["Open a project", "Find a file with Telescope", "Make an edit", "Save"],
        turn_in: "All under 10 seconds.",
        type: :daily,
        npc_greeting: "Ten seconds. Open, find, edit, save. That's the drill. Go.",
        npc_confirmation: "Clean run. Do it again tomorrow."
      },
      %Quest{
        id: "daily_2",
        zone_id: nil,
        number: "D2",
        name: "Symbol Chaser",
        xp: 5,
        description: "Use gd → gr → <leader>rn chain on a real symbol.",
        objectives: ["Go to definition with gd", "Find references with gr", "Rename with <leader>rn"],
        turn_in: "Complete the gd → gr → <leader>rn chain on a real symbol.",
        type: :daily,
        npc_greeting: "Definition, references, rename. Three moves, one flow. Practice it.",
        npc_confirmation: "The chain is becoming instinct. Good."
      },
      %Quest{
        id: "daily_3",
        zone_id: nil,
        number: "D3",
        name: "Seamless Navigator",
        xp: 5,
        description: "Navigate your tmux+neovim layout without thinking about the keys.",
        objectives: ["Navigate between tmux panes and Neovim splits fluidly"],
        turn_in: "Navigate without thinking about the keys.",
        type: :daily,
        npc_greeting: "Pane to split. Split to pane. No pausing. No looking at your hands.",
        npc_confirmation: "You didn't even think about the boundary. That's the point."
      },
      %Quest{
        id: "daily_4",
        zone_id: nil,
        number: "D4",
        name: "Batch Processor",
        xp: 5,
        description: "Solve a repetitive edit with a macro instead of doing it manually.",
        objectives: ["Record a macro", "Apply it to solve a repetitive editing task"],
        turn_in: "Solve a repetitive edit with a macro.",
        type: :daily,
        npc_greeting: "Find something repetitive. Record once. Apply everywhere. That's efficiency.",
        npc_confirmation: "Batch processing. Everything else is just typing."
      },
      %Quest{
        id: "daily_5",
        zone_id: nil,
        number: "D5",
        name: "Structural Editor",
        xp: 5,
        description: "Use Treesitter text objects (daf, cif, via) in real editing.",
        objectives: ["Use Treesitter text objects in real editing"],
        turn_in: "Use daf, cif, or via in real editing.",
        type: :daily,
        npc_greeting: "Delete a function. Change an argument. Select a block. By meaning, not by line.",
        npc_confirmation: "Your edits cut by structure, not by position. Precise."
      }
    ]
  end

  defp zone_1 do
    %Zone{
      id: "zone_1",
      name: "The Bridge",
      number: 1,
      tagline: "Your workstation is cold — hasn't been powered on since Kovacs left. Get it running.",
      theme: "Get Neovim installed, configured, and verify your vi skills carry over.",
      xp_required: 0,
      icon: "🖥️",
      total_xp: 110,
      npc: "Chief Torres",
      npc_title: "Bridge Commander",
      zone_intro: "The bridge is quiet. Half the overhead lights are off — power conservation during drydock. Your workstation is the third console from the left, still showing the previous engineer's login screen. The chair is worn but comfortable. Someone left a coffee mug in the cupholder. It's been here a while. You're not alone — someone at the command console has already noticed you.",
      quests: [
        %Quest{
          id: "quest_1_1",
          zone_id: "zone_1",
          number: "1.1",
          name: "Bootstrap the Terminal",
          xp: 10,
          description: "Install Neovim (brew install neovim / apt install neovim). Run nvim --version. You need 0.9+.",
          objectives: ["Install Neovim", "Run nvim --version", "Verify version >= 0.9"],
          turn_in: "You see a version number >= 0.9",
          type: :chain,
          npc_greeting: "Ship runs Neovim on every terminal. If yours doesn't have it, install it. I need version 0.9 or better — anything older and you'll be fighting compatibility issues all mission.",
          npc_confirmation: "Good. That's current."
        },
        %Quest{
          id: "quest_1_2",
          zone_id: "zone_1",
          number: "1.2",
          name: "Systems Check: Manual Navigation",
          xp: 10,
          description: "Open a file with nvim. Navigate using only hjkl. Edit, save, quit. Confirm to yourself: this is home.",
          objectives: ["Open a file with nvim", "Navigate using only hjkl", "Edit, save, and quit"],
          turn_in: "Edit and save a file using only vi motions",
          type: :chain,
          npc_greeting: "The previous engineer relied on GUI overlays for everything. When those crashed — and they did — he couldn't navigate bare terminal. Don't be like Kovacs. Show me you can work raw.",
          npc_confirmation: "You know your way around a terminal. That's the baseline. Everything else builds on this."
        },
        %Quest{
          id: "quest_1_3",
          zone_id: "zone_1",
          number: "1.3",
          name: "Write the Ship Profile",
          xp: 20,
          description: "Create ~/.config/nvim/init.lua with basic settings: line numbers, relative numbers, expandtab, shiftwidth, tabstop, signcolumn, clipboard.",
          objectives: ["Create ~/.config/nvim/init.lua", "Add number and relativenumber settings", "Add tab/indent settings", "Add signcolumn and clipboard settings"],
          turn_in: "Open nvim — you see relative line numbers",
          type: :chain,
          npc_greeting: "Every workstation on the ship reads from a personal config. Yours is blank. Write it. Line numbers, tab behavior, clipboard integration — the basics. Get your profile right now and everything downstream gets easier.",
          npc_confirmation: "Relative line numbers. Smart. Makes jump commands precise without counting."
        },
        %Quest{
          id: "quest_1_4",
          zone_id: "zone_1",
          number: "1.4",
          name: "Run Diagnostics",
          xp: 20,
          description: "Learn :checkhealth. Run it. Fix any warnings about missing providers. This is your diagnostic tool — you'll return to it often.",
          objectives: ["Run :checkhealth", "Fix any warnings about missing providers"],
          turn_in: ":checkhealth runs with no critical errors",
          type: :chain,
          npc_greeting: "Before you touch anything else, run a full diagnostic. :checkhealth. It'll flag missing dependencies, broken providers, anything that'll cause problems later. Fix what it finds. I don't want surprises once we're underway.",
          npc_confirmation: "Clean diagnostic. You're ahead of most new engineers who come through here."
        }
      ],
      side_quests: [],
      boss: %Quest{
        id: "boss_1",
        zone_id: "zone_1",
        number: "1.B",
        name: "Cold Restart Drill",
        xp: 50,
        description: "Without looking anything up, from a blank init.lua: set line numbers, set leader key to space, create a save keymap, reload config.",
        objectives: [
          "Set line numbers on",
          "Set the leader key to space",
          "Create a keymap that saves with <leader>w",
          "Reload config with :source %"
        ],
        turn_in: "You now understand that Neovim config is just Lua. No magic.",
        type: :boss,
        npc_greeting: "All right. Pop quiz. I'm going to wipe your profile and you're going to rebuild it from memory. No reference material. If you can't configure your own workstation cold, you're not ready for deep space.",
        npc_confirmation: "You understand what you built. That's what matters. Neovim config is Lua — no magic, no abstraction layers. Just code you control. Module Bay is down on Deck 3. Ren handles subsystem installations. She's... energetic. You'll manage."
      }
    }
  end

  defp zone_2 do
    %Zone{
      id: "zone_2",
      name: "The Module Bay",
      number: 2,
      tagline: "This is where the ship gets interesting. Everything up on the bridge is manual. Down here, we install the systems that make manual obsolete.",
      theme: "Plugin management and your first essential plugins.",
      xp_required: 100,
      icon: "📦",
      total_xp: 190,
      npc: "Ren",
      npc_title: "Comms Operator",
      zone_intro: "Deck 3 is warmer than the bridge — the module bay runs hot from integration testing. Racks of subsystem modules line both walls, each one a self-contained unit waiting to be loaded into the ship's software stack. Status lights blink amber: installed but unconfigured. The air hums with potential.",
      quests: [
        %Quest{
          id: "quest_2_1",
          zone_id: "zone_2",
          number: "2.1",
          name: "Initialize the Module Loader",
          xp: 20,
          description: "Install lazy.nvim (the plugin manager). Add the bootstrap code to your init.lua.",
          objectives: ["Install lazy.nvim", "Add bootstrap code to init.lua"],
          turn_in: ":Lazy opens the plugin manager UI",
          type: :chain,
          npc_greeting: "First thing — you need a module loader. It's called lazy.nvim. Without it, you're installing subsystems by hand, which... I mean, you could, but why would you? It handles dependencies, load order, updates — everything.",
          npc_confirmation: "You've got the loader! Open it with :Lazy — see? Every module you install from now on shows up right there."
        },
        %Quest{
          id: "quest_2_2",
          zone_id: "zone_2",
          number: "2.2",
          name: "Sensor Array: Telescope",
          xp: 30,
          description: "Install telescope.nvim (fuzzy finder). Configure keymaps for find files, live grep, and list buffers.",
          objectives: [
            "Install telescope.nvim",
            "Map <leader>ff to find files",
            "Map <leader>fg to live grep",
            "Map <leader>fb to list buffers"
          ],
          turn_in: "<leader>ff opens a fuzzy file picker",
          type: :chain,
          npc_greeting: "This is my favorite subsystem on the whole ship. Telescope. It's a fuzzy-search sensor array — point it at any dataset and it finds what you need in seconds. But you need to bind it to your console keys.",
          npc_confirmation: "There — see how fast it found that file? This thing is going to save you hours. Trust me."
        },
        %Quest{
          id: "quest_2_3",
          zone_id: "zone_2",
          number: "2.3",
          name: "File Navigation System",
          xp: 20,
          description: "Install oil.nvim or neo-tree.nvim (file explorer). Learn to navigate, create, rename, and delete files from within Neovim.",
          objectives: ["Install a file explorer plugin", "Navigate files", "Create, rename, and delete files from Neovim"],
          turn_in: "Create a new file without leaving Neovim",
          type: :chain,
          npc_greeting: "Telescope finds things, but it doesn't organize them. For that you need a proper file navigator — something that maps the directory structure and lets you manipulate it. I use Oil. Some people prefer Neo-tree. Both work.",
          npc_confirmation: "You just created a file without leaving the terminal. Think about that. Full filesystem control, right from your workstation."
        },
        %Quest{
          id: "quest_2_4",
          zone_id: "zone_2",
          number: "2.4",
          name: "Version Tracking Module",
          xp: 20,
          description: "Install gitsigns.nvim. See git diff markers in the sign column. Learn hunk navigation and operations.",
          objectives: ["Install gitsigns.nvim", "Learn ]c / [c to jump between hunks", "Learn to preview, stage, and reset hunks"],
          turn_in: "Stage a single hunk from within Neovim",
          type: :chain,
          npc_greeting: "Okay, this one's important. Gitsigns — it hooks into the version control system and shows you exactly what's changed. Green for new lines, blue for modified, red for deleted. You can even stage individual hunks — just the lines you want, not the whole file.",
          npc_confirmation: "You staged a single hunk. Not the whole file — just the exact change you wanted. That's precision version control."
        },
        %Quest{
          id: "quest_2_5",
          zone_id: "zone_2",
          number: "2.5",
          name: "Interface Calibration",
          xp: 10,
          description: "Install a colorscheme you love and a statusline (lualine.nvim).",
          objectives: ["Install a colorscheme", "Install lualine.nvim"],
          turn_in: "Your editor no longer looks like 1985",
          type: :chain,
          npc_greeting: "Okay, real talk — your terminal looks like it's still running the factory default theme from nine years ago. The ship's not glamorous, but your workstation should at least look like someone's home. Pick a color scheme. Get a status bar.",
          npc_confirmation: "Now THAT looks like a proper engineering console. Professional."
        }
      ],
      side_quests: [
        %Quest{
          id: "side_2_1",
          zone_id: "zone_2",
          number: "2.S1",
          name: "Command Reference Overlay",
          xp: 30,
          description: "Install which-key.nvim. When you press <leader> and pause, a popup shows all available keymaps.",
          objectives: ["Install which-key.nvim", "Press <leader> and see the popup"],
          turn_in: "Press <leader> and see the popup",
          type: :side,
          npc_greeting: "Almost forgot — there's a module called Which-Key. Press your leader key and wait... it shows every binding you've configured. Like having a reference manual built into your muscle memory.",
          npc_confirmation: "See? It remembers everything, even when you forget."
        }
      ],
      boss: %Quest{
        id: "boss_2",
        zone_id: "zone_2",
        number: "2.B",
        name: "Retrieval Operation",
        xp: 60,
        description: "A critical system config was misfiled during drydock. Find it, search it, rename it, and stage changes — all without leaving Neovim.",
        objectives: [
          "Use Telescope find_files to locate treasure.txt",
          "Use Telescope live_grep to find which file contains 'gold'",
          "Use file explorer to rename it to claimed.txt",
          "Use gitsigns to stage and preview changes"
        ],
        turn_in: "You found it without touching a file manager or a GUI.",
        type: :boss,
        npc_greeting: "So... during drydock, someone misfiled a critical system config. I've been looking for it for a week. It's somewhere in the data archives. Use every tool we just installed — search, navigate, track the changes. Find it for me?",
        npc_confirmation: "You found it! And you did the whole thing without switching to a file manager or a GUI. That's what a properly configured workstation can do. Analysis Deck is two floors up. SOLEN runs it. Fair warning — SOLEN is the ship's AI. It's... precise."
      }
    }
  end

  defp zone_3 do
    %Zone{
      id: "zone_3",
      name: "The Analysis Deck",
      number: 3,
      tagline: "I observe that you will be configuring the subsystems that govern my own language comprehension. I find this arrangement... appropriately recursive.",
      theme: "LSP, autocompletion, and syntax-aware editing.",
      xp_required: 300,
      icon: "🔬",
      total_xp: 260,
      npc: "SOLEN",
      npc_title: "Ship's AI",
      zone_intro: "The Analysis Deck is the quietest part of the ship. Temperature-controlled, vibration-dampened, the hum of processors barely audible behind the wall panels. Displays show streaming code analysis — syntax trees, type hierarchies, symbol maps. This is where the ship's intelligence systems live. The main display flickers to life as you enter. A calm, precise voice fills the room.",
      quests: [
        %Quest{
          id: "quest_3_1",
          zone_id: "zone_3",
          number: "3.1",
          name: "Bring the Language Daemon Online",
          xp: 30,
          description: "Install nvim-lspconfig. Configure an LSP server for a language you use.",
          objectives: ["Install nvim-lspconfig", "Configure an LSP server for your language"],
          turn_in: "Open a file and see real diagnostics in the gutter",
          type: :chain,
          npc_greeting: "The Language Server Protocol. A standardized interface through which your terminal communicates with any language's analysis engine. Install nvim-lspconfig and connect it to a language server. I will observe the results with considerable interest.",
          npc_confirmation: "Diagnostics are appearing in your gutter. Those are not heuristics. The language server parsed your code structurally. It knows."
        },
        %Quest{
          id: "quest_3_2",
          zone_id: "zone_3",
          number: "3.2",
          name: "Query Protocols",
          xp: 30,
          description: "Set up LSP keymaps for go-to-definition, find references, hover docs, rename, and code actions.",
          objectives: [
            "Map gd to go to definition",
            "Map gr to find references",
            "Map K to hover documentation",
            "Map <leader>rn to rename symbol",
            "Map <leader>ca to code actions"
          ],
          turn_in: "Jump to a function's definition with gd, then back with Ctrl-o",
          type: :chain,
          npc_greeting: "A language server that cannot be queried is a database with no interface. Configure these keybindings. They represent the fundamental queries any systems engineer must have at hand.",
          npc_confirmation: "You navigated to a definition and returned. The codebase is no longer opaque to you. You can trace any call to its origin."
        },
        %Quest{
          id: "quest_3_3",
          zone_id: "zone_3",
          number: "3.3",
          name: "Predictive Input System",
          xp: 30,
          description: "Install nvim-cmp (autocompletion) with LSP source. Configure completions to appear as you type.",
          objectives: ["Install nvim-cmp", "Configure LSP completion source", "Verify completions appear as you type"],
          turn_in: "Start typing a function name and see intelligent suggestions",
          type: :chain,
          npc_greeting: "Typing every function name in full is inefficient by a factor I find uncomfortable to calculate. nvim-cmp provides completions drawn directly from the language server. It does not guess. It queries the type system.",
          npc_confirmation: "Intelligent suggestions. Derived from structural analysis, not pattern matching. This is... satisfactory."
        },
        %Quest{
          id: "quest_3_4",
          zone_id: "zone_3",
          number: "3.4",
          name: "Structural Parser",
          xp: 20,
          description: "Install nvim-treesitter. Enable highlight, indent, and incremental_selection.",
          objectives: ["Install nvim-treesitter", "Enable highlight, indent, and incremental_selection"],
          turn_in: "Notice the difference in highlighting quality",
          type: :chain,
          npc_greeting: "Regex-based syntax highlighting is adequate in the way that a flashlight is adequate when a floodlight exists. Treesitter constructs an actual syntax tree. It understands your code's structure, not merely its surface patterns.",
          npc_confirmation: "Observe the difference. Nested strings, embedded languages, complex expressions — all parsed correctly. The flashlight has been replaced."
        },
        %Quest{
          id: "quest_3_5",
          zone_id: "zone_3",
          number: "3.5",
          name: "Precision Selectors",
          xp: 30,
          description: "Learn Treesitter text objects with nvim-treesitter-textobjects: af/if for functions, ac/ic for classes, aa/ia for arguments.",
          objectives: [
            "Install nvim-treesitter-textobjects",
            "Practice daf to delete a function",
            "Practice cia to change an argument"
          ],
          turn_in: "Delete a function, undo, then change a single argument — all with motions",
          type: :chain,
          npc_greeting: "And now, what I consider the most significant capability. Treesitter text objects. The ability to select, delete, and manipulate code by its semantic meaning, not its line position. A function is not 'lines 42 through 58.' A function is a function.",
          npc_confirmation: "You deleted a function with three keystrokes, then changed a single argument with three more. Your terminal now operates with surgical precision."
        }
      ],
      side_quests: [
        %Quest{
          id: "side_3_1",
          zone_id: "zone_3",
          number: "3.S1",
          name: "Auto-Formatting Protocol",
          xp: 20,
          description: "Install conform.nvim. Configure format-on-save for your language.",
          objectives: ["Install conform.nvim", "Configure format-on-save"],
          turn_in: "Save a messy file and watch it auto-format",
          type: :side,
          npc_greeting: "An engineer who leaves inconsistently formatted code in the ship's systems is introducing unnecessary entropy. Conform.nvim will enforce formatting standards on every save.",
          npc_confirmation: "Automatic. Consistent. Entropy reduced."
        },
        %Quest{
          id: "side_3_2",
          zone_id: "zone_3",
          number: "3.S2",
          name: "Code Audit Daemon",
          xp: 20,
          description: "Install nvim-lint. Configure a linter for your language.",
          objectives: ["Install nvim-lint", "Configure a linter"],
          turn_in: "See linting diagnostics separate from LSP warnings",
          type: :side,
          npc_greeting: "The language server identifies errors. The linter identifies opinions — style violations, suspicious patterns, potential issues the server is too conservative to flag.",
          npc_confirmation: "Two layers of analysis. The server and the linter. My diagnostic coverage is now comprehensive."
        }
      ],
      boss: %Quest{
        id: "boss_3",
        zone_id: "zone_3",
        number: "3.B",
        name: "System Refactor: Live",
        xp: 80,
        description: "Take a real file (100+ lines). Trace a function call, rename a symbol, verify references, delete and move a function, format on save.",
        objectives: [
          "Use gd to trace a function call to its definition",
          "Rename a symbol with <leader>rn across the project",
          "Use gr to verify all references updated",
          "Delete an entire function using daf",
          "Move it to another file using Treesitter selection",
          "Format both files on save"
        ],
        turn_in: "Your workstation now provides code intelligence equivalent to any IDE.",
        type: :boss,
        npc_greeting: "This is the trial. A real file from one of your projects. One hundred lines or more. You will refactor it using every analysis tool available to you. I will be monitoring the results.",
        npc_confirmation: "Your workstation now provides code intelligence equivalent to any integrated development environment. Superior, perhaps — because you understand every component. The Nav Array is on Deck 7. Jin operates it. I recommend... patience."
      }
    }
  end

  defp zone_4 do
    %Zone{
      id: "zone_4",
      name: "The Nav Array",
      number: 4,
      tagline: "You're slow. That's fine. Everybody's slow when they get up here. Speed isn't about moving fast — it's about never stopping.",
      theme: "Advanced motions, workflow speed, and tmux integration.",
      xp_required: 550,
      icon: "🧭",
      total_xp: 220,
      npc: "Jin",
      npc_title: "Pilot-Navigator",
      zone_intro: "Deck 7 is all open space and holographic navigation charts. Star maps drift across the ceiling, routes plotted and replotted in real time. The consoles here are standing-height — nobody sits in the Nav Array. Everything is built for speed. A figure is running navigation drills at the far console, fingers moving so fast the keystrokes blur together. They finish, check a timer, mutter something dissatisfied, and reset. Then they notice you.",
      quests: [
        %Quest{
          id: "quest_4_1",
          zone_id: "zone_4",
          number: "4.1",
          name: "Jump Navigation",
          xp: 20,
          description: "Install flash.nvim or leap.nvim. Jump to any visible word in 2-3 keystrokes.",
          objectives: ["Install flash.nvim or leap.nvim", "Jump across a file without hjkl or searching"],
          turn_in: "Jump across a long file without hjkl or searching",
          type: :chain,
          npc_greeting: "hjkl. Line by line. Word by word. Slow. Flash lets you jump to any visible word in two keystrokes. Two. Not twenty. Two.",
          npc_confirmation: "Better. Still slow. But better."
        },
        %Quest{
          id: "quest_4_2",
          zone_id: "zone_4",
          number: "4.2",
          name: "Quick-Access Markers",
          xp: 30,
          description: "Master Harpoon. Mark 4 frequently-used files and switch between them instantly.",
          objectives: ["Install Harpoon", "Mark 4 files", "Switch between them with <leader>1-4"],
          turn_in: "Bounce between 4 files in under 2 seconds",
          type: :chain,
          npc_greeting: "You have four files you touch every shift. Maybe five. Why are you searching for them? Harpoon. Mark them. Switch between them like breathing.",
          npc_confirmation: "Four files. Under two seconds. That's the baseline. Get faster."
        },
        %Quest{
          id: "quest_4_3",
          zone_id: "zone_4",
          number: "4.3",
          name: "Split-Screen Operations",
          xp: 20,
          description: "Learn split management: create, navigate, resize splits. Remap to faster keybindings.",
          objectives: [
            "Learn <C-w>v and <C-w>s for splits",
            "Learn <C-w>h/j/k/l to navigate",
            "Learn <C-w>= to equalize",
            "Remap to <C-h/j/k/l>"
          ],
          turn_in: "Work with 3 splits open comfortably",
          type: :chain,
          npc_greeting: "One file at a time? What is this, a single-display terminal from the 2040s? Splits. Learn them. Live in them.",
          npc_confirmation: "Three splits. Three contexts. Zero friction. Now you're thinking in parallel."
        },
        %Quest{
          id: "quest_4_4",
          zone_id: "zone_4",
          number: "4.4",
          name: "Unified Console Bridge",
          xp: 30,
          description: "Install vim-tmux-navigator. Move seamlessly between Neovim splits and tmux panes.",
          objectives: ["Install vim-tmux-navigator", "Navigate from Neovim split to tmux pane seamlessly"],
          turn_in: "Navigate from a Neovim split to a tmux pane without thinking",
          type: :chain,
          npc_greeting: "Your terminal has walls. Tmux panes on one side, Neovim splits on the other. vim-tmux-navigator tears those walls down. One set of keys. Seamless.",
          npc_confirmation: "You didn't even think about the boundary, did you? That's the point."
        },
        %Quest{
          id: "quest_4_5",
          zone_id: "zone_4",
          number: "4.5",
          name: "Batch Operations",
          xp: 20,
          description: "Practice macros on real editing tasks. Record a macro that reformats a line, then apply it to 50 lines.",
          objectives: ["Record a macro that reformats a line", "Apply it to 50 lines with 50@q"],
          turn_in: "Solve a repetitive editing task with a macro in under 30 seconds",
          type: :chain,
          npc_greeting: "Fifty lines. Same edit. You could do it one at a time. Or you could do it once and let the macro do the rest. qq, record, q, 50@q. Done.",
          npc_confirmation: "Under thirty seconds. That's batch processing. Everything else is just typing."
        }
      ],
      side_quests: [
        %Quest{
          id: "side_4_1",
          zone_id: "zone_4",
          number: "4.S1",
          name: "Branch Recovery Protocol",
          xp: 20,
          description: "Install undotree. Visual, branching undo history.",
          objectives: ["Install undotree", "Undo, branch, and recover a lost change"],
          turn_in: "Undo, branch, and recover a change you thought was lost",
          type: :side,
          npc_greeting: "Made a mistake? Wrong branch? Don't care. Undotree gives you a visual history of every change — including the ones you thought you lost. Time is a tree, not a line.",
          npc_confirmation: "You recovered a change from a dead branch. Version history bends for you now."
        }
      ],
      boss: %Quest{
        id: "boss_4",
        zone_id: "zone_4",
        number: "4.B",
        name: "Emergency Response Drill",
        xp: 80,
        description: "Set a 5-minute timer. In a real project: find a file, jump to a function, rename a variable, switch to tests, run them, fix an issue, format, stage changes.",
        objectives: [
          "Use Telescope to find a file",
          "Jump to a function with Treesitter motion",
          "Rename a variable across the project",
          "Harpoon-switch to test file",
          "Use tmux pane to run tests",
          "Fix an issue, format on save",
          "Stage changes with gitsigns"
        ],
        turn_in: "You are faster in the terminal than you ever were with a GUI.",
        type: :boss,
        npc_greeting: "Five minutes. Real project. Everything you've learned, all at once. If you stop to think about which key to press, you've already lost. Go.",
        npc_confirmation: "Faster in the terminal than any GUI jockey on the fleet. Engine Room is below us. Vasquez runs it. Bring your focus."
      }
    }
  end

  defp zone_5 do
    %Zone{
      id: "zone_5",
      name: "The Engine Room",
      number: 5,
      tagline: "Up there, you learned to write systems. Down here, you learn why they break.",
      theme: "Debugging, testing, and advanced LSP features.",
      xp_required: 800,
      icon: "🔧",
      total_xp: 210,
      npc: "Vasquez",
      npc_title: "Chief Engineer",
      zone_intro: "The Engine Room is deep in the ship — low ceilings, exposed conduit, the constant thrum of the reactor behind the bulkhead. Status displays line every surface, most of them showing nominal readings in green. A few pulse yellow. One, in the corner, blinks red. Nobody seems alarmed.",
      quests: [
        %Quest{
          id: "quest_5_1",
          zone_id: "zone_5",
          number: "5.1",
          name: "Diagnostic Bridge Protocol",
          xp: 40,
          description: "Install nvim-dap. Configure it for your primary language. Set a breakpoint, launch a debug session, step through code.",
          objectives: ["Install nvim-dap", "Configure for your language", "Set a breakpoint", "Step through code"],
          turn_in: "Hit a breakpoint and inspect a variable value",
          type: :chain,
          npc_greeting: "The Debug Adapter Protocol. DAP. It's the bridge between your terminal and your language's debugger. Set a breakpoint. Launch a session. Step through the code line by line. See what the machine actually does, not what you think it does.",
          npc_confirmation: "You hit a breakpoint. You inspected a variable. You saw the truth, not the assumption. That's the foundation of everything down here."
        },
        %Quest{
          id: "quest_5_2",
          zone_id: "zone_5",
          number: "5.2",
          name: "Diagnostic Interface",
          xp: 20,
          description: "Install nvim-dap-ui. Watch windows, call stacks, and REPL. Learn continue, step over, step into, step out.",
          objectives: ["Install nvim-dap-ui", "Learn F5 (continue)", "Learn F10 (step over)", "Learn F11 (step into)", "Learn F12 (step out)"],
          turn_in: "Step through a bug and find the issue using the DAP UI",
          type: :chain,
          npc_greeting: "DAP alone is powerful but blind. The UI gives you eyes — watch windows, call stacks, a REPL. Now you can see the whole system at once.",
          npc_confirmation: "You stepped through a fault and found it. Not by guessing — by watching. That's the difference between patching and engineering."
        },
        %Quest{
          id: "quest_5_3",
          zone_id: "zone_5",
          number: "5.3",
          name: "Automated Test Harness",
          xp: 30,
          description: "Install neotest with adapter for your test framework. Run single tests, files, and full suites from Neovim.",
          objectives: ["Install neotest", "Run a single test", "Run a file", "Run the whole suite"],
          turn_in: "Run a single test and see inline pass/fail results",
          type: :chain,
          npc_greeting: "Tests are your early warning system. Without them, you're flying blind. Neotest lets you run them right here — one test, one file, the whole suite. Inline results. No context switching.",
          npc_confirmation: "Inline pass/fail. Right there in your code. You never have to leave your workstation to know if something works."
        },
        %Quest{
          id: "quest_5_4",
          zone_id: "zone_5",
          number: "5.4",
          name: "Error Navigation",
          xp: 20,
          description: "Navigate diagnostics efficiently with ]d/[d, diagnostic float, and Telescope diagnostics.",
          objectives: ["Learn ]d / [d to jump between diagnostics", "Learn <leader>d for diagnostic float", "Use Telescope diagnostics"],
          turn_in: "Find and fix 3 warnings using only diagnostic navigation",
          type: :chain,
          npc_greeting: "The Engine Room is full of warnings. Most engineers ignore them until they become failures. Don't be most engineers. Learn to navigate diagnostics like you navigate code — with precision.",
          npc_confirmation: "Three warnings found and fixed using only diagnostic navigation. You didn't grep. You didn't scroll. You navigated."
        }
      ],
      side_quests: [],
      boss: %Quest{
        id: "boss_5",
        zone_id: "zone_5",
        number: "5.B",
        name: "Engine Fault: Trace and Repair",
        xp: 100,
        description: "Take a real bug: write a failing test, set breakpoints, step through, fix it, run test green, stage and commit.",
        objectives: [
          "Write a failing test with neotest",
          "Set breakpoints with nvim-dap",
          "Step through to identify root cause",
          "Fix using LSP rename/refactor",
          "Run test again — green",
          "Stage and commit without leaving Neovim"
        ],
        turn_in: "Your terminal setup now does everything a $400/year IDE does.",
        type: :boss,
        npc_greeting: "Real fault. Real system. This is why you're down here. Find it, fix it, prove it's fixed. Every tool you have. No guessing.",
        npc_confirmation: "Your workstation now does everything a $400/year IDE does. And you understand every piece of it. Bridge is up top. Torres is waiting."
      }
    }
  end

  defp zone_6 do
    %Zone{
      id: "zone_6",
      name: "The Command Chair",
      number: 6,
      tagline: "This zone is different. No more instruction. You know enough to build your own systems.",
      theme: "Full customization, personal workflow optimization, and mastery.",
      xp_required: 1100,
      icon: "🪑",
      total_xp: 290,
      npc: "Chief Torres",
      npc_title: "Bridge Commander (returned)",
      zone_intro: "The bridge looks different now. When you first came aboard, half the lights were off and the displays were dark. Now every console is live. Systems you configured are running across every screen — the sensor array, the analysis systems, the navigation charts, the diagnostic feeds. The ship is alive. Your workstation isn't the third console from the left anymore. It's the central one. The ship launched weeks ago — drydock is a memory. You're in deep space now.",
      quests: [
        %Quest{
          id: "quest_6_1",
          zone_id: "zone_6",
          number: "6.1",
          name: "Custom Macros Library",
          xp: 30,
          description: "Install LuaSnip. Create 5 custom snippets for patterns you type daily.",
          objectives: ["Install LuaSnip", "Create 5 custom snippets", "Trigger and tab through placeholders"],
          turn_in: "Trigger a custom snippet and tab through its placeholders",
          type: :chain,
          npc_greeting: "Every senior engineer I've served with had their own shortcuts. Patterns they typed so often they could do it in their sleep. LuaSnip lets you encode those patterns. Five custom macros. The ones you use every single shift.",
          npc_confirmation: "Custom macros. Your workflow, encoded. That's not configuration — that's engineering."
        },
        %Quest{
          id: "quest_6_2",
          zone_id: "zone_6",
          number: "6.2",
          name: "Write Your Own Systems",
          xp: 30,
          description: "Write 3 custom Lua functions in your config that automate something you do often. Bind them to keymaps.",
          objectives: ["Write 3 custom Lua functions", "Bind them to keymaps"],
          turn_in: "Trigger your custom function with a keymap",
          type: :chain,
          npc_greeting: "Modules are other people's solutions. Now write your own. Three functions. Things only you need. Bind them to keys. Make this terminal do something it's never done before — because you told it to.",
          npc_confirmation: "That function exists because you needed it and you built it. Nobody else on any ship has that binding. It's yours."
        },
        %Quest{
          id: "quest_6_3",
          zone_id: "zone_6",
          number: "6.3",
          name: "Parallel Editing Protocols",
          xp: 20,
          description: "Learn to replicate multi-cursor: visual block mode, :s substitution, cgn pattern.",
          objectives: [
            "Visual block mode (<C-v>) + I or A for columnar edits",
            ":s substitution with ranges",
            "cgn pattern — change next match, then . to repeat"
          ],
          turn_in: "Make the same edit on 10 lines faster than a multi-cursor would",
          type: :chain,
          npc_greeting: "The GUI operators love their multi-cursors. Flashy. Impressive looking. Slow. You have something better — three techniques that are faster and more precise.",
          npc_confirmation: "Ten lines. Same edit. Faster than any multi-cursor. And you didn't need a mouse to place a single one of them."
        },
        %Quest{
          id: "quest_6_4",
          zone_id: "zone_6",
          number: "6.4",
          name: "Persistent Workspace",
          xp: 20,
          description: "Configure auto-session or persistence.nvim. Neovim restores your last session on open.",
          objectives: ["Install session plugin", "Configure auto-restore"],
          turn_in: "Close Neovim, reopen it, and find everything exactly as you left it",
          type: :chain,
          npc_greeting: "An engineer who has to rebuild their console layout every shift is wasting time. Session management. When you close your terminal and reopen it, everything should be exactly where you left it.",
          npc_confirmation: "You closed it. You reopened it. Everything's still there. That's not a feature — that's respect for your time."
        },
        %Quest{
          id: "quest_6_5",
          zone_id: "zone_6",
          number: "6.5",
          name: "Human-AI Console Layout",
          xp: 40,
          description: "Design your ideal Claude Code + Neovim tmux layout. Write a tmux script that launches it.",
          objectives: [
            "Claude Code in one pane",
            "Neovim in another",
            "Small pane for tests/servers",
            "Seamless navigation between all",
            "Write a tmux launch script"
          ],
          turn_in: "Run your script and land in your perfect workspace",
          type: :chain,
          npc_greeting: "The old engineers worked alone. That was their limitation. You have something they never had — an AI system that can write code, answer questions, and work alongside you. But only if your workspace is built for it.",
          npc_confirmation: "One command. Perfect workspace. Human and AI, side by side. This is how modern engineering works."
        }
      ],
      side_quests: [],
      boss: %Quest{
        id: "boss_6",
        zone_id: "zone_6",
        number: "6.B",
        name: "Full Shift",
        xp: 150,
        description: "Spend an entire workday using only your terminal setup. No GUI editor. Track friction points, then configure them away.",
        objectives: [
          "Spend a full workday in terminal only",
          "Track every friction point",
          "Configure away each friction point"
        ],
        turn_in: "You have brought The Meridian back to life.",
        type: :boss,
        npc_greeting: "Last one. No timer this time. No drill. Just a full shift of real work. Your projects. Your problems. Your terminal. Nothing else. Every time something feels wrong, log it. Then fix it.",
        npc_confirmation: "You came aboard as a new hire with a blank workstation. You're leaving this zone as the engineer who brought The Meridian back to life. Good work, engineer. The ship is yours."
      }
    }
  end
end
