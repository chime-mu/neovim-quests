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
        name: "Macro Master",
        xp: 5,
        description: "Solve a repetitive edit with a macro instead of doing it manually.",
        objectives: ["Record a macro", "Apply it to solve a repetitive editing task"],
        turn_in: "Solve a repetitive edit with a macro.",
        type: :daily,
        npc_greeting: "Find something repetitive. Record once. Apply everywhere. That's efficiency.",
        npc_confirmation: "Macro warrior. Everything else is just typing."
      },
      %Quest{
        id: "daily_5",
        zone_id: nil,
        number: "D5",
        name: "Treesitter Warrior",
        xp: 5,
        description: "Use Treesitter text objects (daf, cif, via) in real editing.",
        objectives: ["Use Treesitter text objects in real editing"],
        turn_in: "Use daf, cif, or via in real editing.",
        type: :daily,
        npc_greeting: "Delete a function. Change an argument. Select a block. By meaning, not by line.",
        npc_confirmation: "Your blade cuts by structure, not by position. Sharp."
      }
    ]
  end

  defp zone_1 do
    %Zone{
      id: "zone_1",
      name: "The Crossroads",
      number: 1,
      tagline: "Everyone who comes through here thinks they know the blade. Most of them are wrong.",
      theme: "Get Neovim installed, configured, and verify your vi skills carry over.",
      xp_required: 0,
      icon: "🏕️",
      total_xp: 110,
      npc: "Kael",
      npc_title: "The Gatekeeper",
      zone_intro: "The road ends at a stone archway, half-reclaimed by moss. Beyond it, a dusty courtyard where new arrivals are tested. Weapon racks line the walls — each one holding a different version of the same blade. A fire pit crackles in the center, tended by no one. A man stands at the gate, his hands scarred from decades of terminal work.",
      quests: [
        %Quest{
          id: "quest_1_1",
          zone_id: "zone_1",
          number: "1.1",
          name: "Install the Blade",
          xp: 10,
          description: "Install Neovim (brew install neovim / apt install neovim). Run nvim --version. You need 0.9+.",
          objectives: ["Install Neovim", "Run nvim --version", "Verify version >= 0.9"],
          turn_in: "You see a version number >= 0.9",
          type: :chain,
          npc_greeting: "First things first. You can't fight with a weapon you don't have. Get Neovim on your machine — I don't care how. Brew, apt, build from source if you're the stubborn type. Just make sure it's sharp enough. Version 0.9 or better.",
          npc_confirmation: "Good steel. That'll do."
        },
        %Quest{
          id: "quest_1_2",
          zone_id: "zone_1",
          number: "1.2",
          name: "The Old Ways Still Work",
          xp: 10,
          description: "Open a file with nvim. Navigate using only hjkl. Edit, save, quit. Confirm to yourself: this is home.",
          objectives: ["Open a file with nvim", "Navigate using only hjkl", "Edit, save, and quit"],
          turn_in: "Edit and save a file using only vi motions",
          type: :chain,
          npc_greeting: "I've seen warriors come from those GUI empires. Soft hands. Can't navigate without a mouse. But you — you've got that look. Show me the old ways still live in you.",
          npc_confirmation: "You remember. Good. The old ways are the foundation. Everything else is built on top."
        },
        %Quest{
          id: "quest_1_3",
          zone_id: "zone_1",
          number: "1.3",
          name: "Forge Your Config",
          xp: 20,
          description: "Create ~/.config/nvim/init.lua with basic settings: line numbers, relative numbers, expandtab, shiftwidth, tabstop, signcolumn, clipboard.",
          objectives: ["Create ~/.config/nvim/init.lua", "Add number and relativenumber settings", "Add tab/indent settings", "Add signcolumn and clipboard settings"],
          turn_in: "Open nvim — you see relative line numbers",
          type: :chain,
          npc_greeting: "Every warrior's blade is different. In this city, your config file is your blade. Forge it wrong and it'll shatter in your hand. Forge it right and it becomes an extension of your will.",
          npc_confirmation: "Relative numbers. Smart. You'll know exactly how far to jump before you even think about it."
        },
        %Quest{
          id: "quest_1_4",
          zone_id: "zone_1",
          number: "1.4",
          name: "The Adventurer's Map",
          xp: 20,
          description: "Learn :checkhealth. Run it. Fix any warnings about missing providers. This is your diagnostic tool — you'll return to it often.",
          objectives: ["Run :checkhealth", "Fix any warnings about missing providers"],
          turn_in: ":checkhealth runs with no critical errors",
          type: :chain,
          npc_greeting: "Before you go deeper, learn to read the terrain. The city has a built-in diagnostic — :checkhealth. It'll tell you what's working and what's broken. Fix what it complains about. You don't want surprises where you're going.",
          npc_confirmation: "Clean health check. You're better prepared than most who pass through here."
        }
      ],
      side_quests: [],
      boss: %Quest{
        id: "boss_1",
        zone_id: "zone_1",
        number: "1.B",
        name: "The Config Gauntlet",
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
        npc_greeting: "All right. I've been easy on you so far. Now I want to see if you actually understand what you've done, or if you just copied what I told you. Start from nothing. Build it back.",
        npc_confirmation: "You understand now. Neovim config is just Lua. No magic. No mystery. Just code you control. The Plugin Forest is through those trees. A girl named Lyra runs things there — she's... enthusiastic. Tell her I sent you."
      }
    }
  end

  defp zone_2 do
    %Zone{
      id: "zone_2",
      name: "The Plugin Forest",
      number: 2,
      tagline: "Everything here is alive — you just need to learn how to call them.",
      theme: "Plugin management and your first essential plugins.",
      xp_required: 100,
      icon: "🌲",
      total_xp: 190,
      npc: "Lyra",
      npc_title: "The Summoner",
      zone_intro: "The trees here are strange — their bark shifts with syntax colors, and their roots tangle into .lua files that snake across the forest floor. Floating orbs drift between the branches, each one a plugin waiting to be bound. A young woman drops from a branch and lands in front of you, grinning. A shimmering creature perches on her shoulder.",
      quests: [
        %Quest{
          id: "quest_2_1",
          zone_id: "zone_2",
          number: "2.1",
          name: "The Summoner's Tome",
          xp: 20,
          description: "Install lazy.nvim (the plugin manager). Add the bootstrap code to your init.lua.",
          objectives: ["Install lazy.nvim", "Add bootstrap code to init.lua"],
          turn_in: ":Lazy opens the plugin manager UI",
          type: :chain,
          npc_greeting: "Before you can summon anything, you need the Tome. It's called lazy.nvim — the spellbook that manages all your creatures. Without it, you're just shouting into the trees.",
          npc_confirmation: "You've got the Tome! Open it with :Lazy — see? All your future allies will appear there."
        },
        %Quest{
          id: "quest_2_2",
          zone_id: "zone_2",
          number: "2.2",
          name: "First Ally: The Pathfinder",
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
          npc_greeting: "Meet Telescope — she's my fastest scout. Point her at any forest and she'll find what you're looking for in seconds. But she needs your keybindings to know where to search.",
          npc_confirmation: "There — see how she found that file? She's yours now. Treat her well."
        },
        %Quest{
          id: "quest_2_3",
          zone_id: "zone_2",
          number: "2.3",
          name: "Second Ally: The Cartographer",
          xp: 20,
          description: "Install oil.nvim or neo-tree.nvim (file explorer). Learn to navigate, create, rename, and delete files from within Neovim.",
          objectives: ["Install a file explorer plugin", "Navigate files", "Create, rename, and delete files from Neovim"],
          turn_in: "Create a new file without leaving Neovim",
          type: :chain,
          npc_greeting: "Telescope finds things, but she doesn't organize them. For that, you need a Cartographer — something that maps the territory and lets you reshape it. I like Oil, personally. Some prefer Neo-tree.",
          npc_confirmation: "You just created a file without ever leaving Neovim. Think about that. The forest answers to you now."
        },
        %Quest{
          id: "quest_2_4",
          zone_id: "zone_2",
          number: "2.4",
          name: "Third Ally: The Chronomancer",
          xp: 20,
          description: "Install gitsigns.nvim. See git diff markers in the sign column. Learn hunk navigation and operations.",
          objectives: ["Install gitsigns.nvim", "Learn ]c / [c to jump between hunks", "Learn to preview, stage, and reset hunks"],
          turn_in: "Stage a single hunk from within Neovim",
          type: :chain,
          npc_greeting: "This one's special. Gitsigns — she can see through time. Every change you make, she marks in the gutter. Green for new, blue for changed, red for deleted. She even lets you stage hunks one at a time.",
          npc_confirmation: "You staged a single hunk. Not the whole file — just the exact change you wanted. That's precision. That's control."
        },
        %Quest{
          id: "quest_2_5",
          zone_id: "zone_2",
          number: "2.5",
          name: "Vanity and Glory",
          xp: 10,
          description: "Install a colorscheme you love and a statusline (lualine.nvim).",
          objectives: ["Install a colorscheme", "Install lualine.nvim"],
          turn_in: "Your editor no longer looks like 1985",
          type: :chain,
          npc_greeting: "Okay, real talk — you can't walk around the Forest looking like that. Your editor is giving 'default terminal, circa 2003.' Let's fix that.",
          npc_confirmation: "Now THAT is a warrior's interface. Looking dangerous."
        }
      ],
      side_quests: [
        %Quest{
          id: "side_2_1",
          zone_id: "zone_2",
          number: "2.S1",
          name: "The Whisperer",
          xp: 30,
          description: "Install which-key.nvim. When you press <leader> and pause, a popup shows all available keymaps.",
          objectives: ["Install which-key.nvim", "Press <leader> and see the popup"],
          turn_in: "Press <leader> and see the popup",
          type: :side,
          npc_greeting: "Almost forgot — there's a creature hiding near the clearing called Which-Key. Press your leader and wait... she whispers every keybinding you've set. Like a tooltip system built into your muscle memory.",
          npc_confirmation: "See? She remembers everything, even when you forget."
        }
      ],
      boss: %Quest{
        id: "boss_2",
        zone_id: "zone_2",
        number: "2.B",
        name: "The Lost File",
        xp: 60,
        description: "A treasure file is hidden somewhere in a large project directory. Find it, search it, rename it, and stage changes — all without leaving Neovim.",
        objectives: [
          "Use Telescope find_files to locate treasure.txt",
          "Use Telescope live_grep to find which file contains 'gold'",
          "Use file explorer to rename it to claimed.txt",
          "Use gitsigns to stage and preview changes"
        ],
        turn_in: "You found it without touching a file manager or a GUI.",
        type: :boss,
        npc_greeting: "So... I may have lost something in the deep forest. A treasure file. I hid it for safekeeping and now I can't remember where. Use everything you've learned — all your allies working together. Find it for me?",
        npc_confirmation: "You found it! And you did the whole thing without touching a file manager or a GUI. That's the power of the Forest. The Tower of Language is that way. Archivist Solen runs it. He's... formal. Don't touch his scrolls without asking."
      }
    }
  end

  defp zone_3 do
    %Zone{
      id: "zone_3",
      name: "The Tower of Language",
      number: 3,
      tagline: "Here, we teach your blade to understand what it cuts.",
      theme: "LSP, autocompletion, and syntax-aware editing.",
      xp_required: 300,
      icon: "🏰",
      total_xp: 260,
      npc: "Archivist Solen",
      npc_title: "Keeper of the Tower",
      zone_intro: "The Tower rises above the canopy, its walls covered in flowing script that shifts between programming languages. Inside, the air smells of parchment and electricity. Shelves stretch to the ceiling, each one holding a language server — small glowing orbs that pulse with understanding. An elderly man in precise robes looks up from a massive codex.",
      quests: [
        %Quest{
          id: "quest_3_1",
          zone_id: "zone_3",
          number: "3.1",
          name: "The Interpreter's Guild",
          xp: 30,
          description: "Install nvim-lspconfig. Configure an LSP server for a language you use.",
          objectives: ["Install nvim-lspconfig", "Configure an LSP server for your language"],
          turn_in: "Open a file and see real diagnostics in the gutter",
          type: :chain,
          npc_greeting: "The Language Server Protocol. It is — and I do not use this word lightly — elegant. A single interface through which your editor speaks to any language. Install nvim-lspconfig and bind it to a server you trust.",
          npc_confirmation: "You see the diagnostics in the gutter? Those are not guesses. The server parsed your code. It knows."
        },
        %Quest{
          id: "quest_3_2",
          zone_id: "zone_3",
          number: "3.2",
          name: "The Oracle Speaks",
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
          npc_greeting: "A language server that cannot be queried is a library with no index. Set these keymaps. They are the fundamental queries every scholar must know.",
          npc_confirmation: "You jumped to a definition and returned. The code is no longer opaque to you. You can trace any thread to its origin."
        },
        %Quest{
          id: "quest_3_3",
          zone_id: "zone_3",
          number: "3.3",
          name: "The Scribe's Quill",
          xp: 30,
          description: "Install nvim-cmp (autocompletion) with LSP source. Configure completions to appear as you type.",
          objectives: ["Install nvim-cmp", "Configure LSP completion source", "Verify completions appear as you type"],
          turn_in: "Start typing a function name and see intelligent suggestions",
          type: :chain,
          npc_greeting: "Typing every function name in full is the mark of a novice. The Scribe's Quill — nvim-cmp — will suggest completions drawn directly from the language server. It does not guess. It knows.",
          npc_confirmation: "Intelligent suggestions. Not snippets from a database — completions that understand your code's type system."
        },
        %Quest{
          id: "quest_3_4",
          zone_id: "zone_3",
          number: "3.4",
          name: "The Living Syntax",
          xp: 20,
          description: "Install nvim-treesitter. Enable highlight, indent, and incremental_selection.",
          objectives: ["Install nvim-treesitter", "Enable highlight, indent, and incremental_selection"],
          turn_in: "Notice the difference in highlighting quality",
          type: :chain,
          npc_greeting: "Regex-based highlighting is... adequate. In the way that a candle is adequate when the sun exists. Treesitter builds an actual syntax tree. It understands your code's structure, not just its surface.",
          npc_confirmation: "Notice the difference. Nested strings, embedded languages, complex expressions — all correct. The candle has been replaced."
        },
        %Quest{
          id: "quest_3_5",
          zone_id: "zone_3",
          number: "3.5",
          name: "The Surgeon's Tools",
          xp: 30,
          description: "Learn Treesitter text objects with nvim-treesitter-textobjects: af/if for functions, ac/ic for classes, aa/ia for arguments.",
          objectives: [
            "Install nvim-treesitter-textobjects",
            "Practice daf to delete a function",
            "Practice cia to change an argument"
          ],
          turn_in: "Delete a function, undo, then change a single argument — all with motions",
          type: :chain,
          npc_greeting: "And now, the crown jewel. Treesitter text objects. The ability to select, delete, and manipulate code by its meaning, not its position. A function is not 'lines 42 through 58.' A function is a function.",
          npc_confirmation: "You deleted a function with three keystrokes, then changed a single argument with three more. Your blade now cuts with surgical precision."
        }
      ],
      side_quests: [
        %Quest{
          id: "side_3_1",
          zone_id: "zone_3",
          number: "3.S1",
          name: "The Formatter",
          xp: 20,
          description: "Install conform.nvim. Configure format-on-save for your language.",
          objectives: ["Install conform.nvim", "Configure format-on-save"],
          turn_in: "Save a messy file and watch it auto-format",
          type: :side,
          npc_greeting: "A scholar who leaves their manuscripts inconsistently formatted is no scholar at all. Conform.nvim will enforce discipline on every save.",
          npc_confirmation: "Automatic. Consistent. As it should be."
        },
        %Quest{
          id: "side_3_2",
          zone_id: "zone_3",
          number: "3.S2",
          name: "The Lint Hound",
          xp: 20,
          description: "Install nvim-lint. Configure a linter for your language.",
          objectives: ["Install nvim-lint", "Configure a linter"],
          turn_in: "See linting diagnostics separate from LSP warnings",
          type: :side,
          npc_greeting: "The language server catches errors. The linter catches opinions — style violations, suspicious patterns, potential bugs the server is too polite to mention.",
          npc_confirmation: "Two layers of analysis. The server and the linter. Nothing escapes the Tower's scrutiny now."
        }
      ],
      boss: %Quest{
        id: "boss_3",
        zone_id: "zone_3",
        number: "3.B",
        name: "The Refactoring Trial",
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
        turn_in: "Your editor now understands code as well as any IDE.",
        type: :boss,
        npc_greeting: "This is the Trial. A real file from one of your projects. One hundred lines or more. You will refactor it using every tool the Tower has given you. No shortcuts. No excuses.",
        npc_confirmation: "Your editor now understands code as well as any IDE. Better, perhaps — because you understand what it's doing. Dash is down on the plains. He'll teach you speed. Try to keep up."
      }
    }
  end

  defp zone_4 do
    %Zone{
      id: "zone_4",
      name: "The Speed Plains",
      number: 4,
      tagline: "You're slow. That's fine. Everyone's slow at first.",
      theme: "Advanced motions, workflow speed, and tmux integration.",
      xp_required: 550,
      icon: "⚡",
      total_xp: 220,
      npc: "Dash",
      npc_title: "The Windrunner",
      zone_intro: "The land opens into vast golden plains where the wind never stops. Paths crisscross the grass in impossible patterns — shortcuts, wormholes, routes that fold space and time. In the distance, a figure moves so fast it leaves afterimages. Then it's standing right in front of you, not even breathing hard.",
      quests: [
        %Quest{
          id: "quest_4_1",
          zone_id: "zone_4",
          number: "4.1",
          name: "The Leap",
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
          name: "The Portal Network",
          xp: 30,
          description: "Master Harpoon. Mark 4 frequently-used files and switch between them instantly.",
          objectives: ["Install Harpoon", "Mark 4 files", "Switch between them with <leader>1-4"],
          turn_in: "Bounce between 4 files in under 2 seconds",
          type: :chain,
          npc_greeting: "You have four files you touch every day. Maybe five. Why are you searching for them? Harpoon. Mark them. Switch between them like breathing.",
          npc_confirmation: "Four files. Under two seconds. That's the baseline. Get faster."
        },
        %Quest{
          id: "quest_4_3",
          zone_id: "zone_4",
          number: "4.3",
          name: "Window Mastery",
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
          npc_greeting: "One file at a time? What is this, a typewriter? Splits. Learn them. Live in them.",
          npc_confirmation: "Three splits. Three contexts. Zero friction. Now you're thinking in parallel."
        },
        %Quest{
          id: "quest_4_4",
          zone_id: "zone_4",
          number: "4.4",
          name: "The Tmux Bridge",
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
          name: "Macro Warfare",
          xp: 20,
          description: "Practice macros on real editing tasks. Record a macro that reformats a line, then apply it to 50 lines.",
          objectives: ["Record a macro that reformats a line", "Apply it to 50 lines with 50@q"],
          turn_in: "Solve a repetitive editing task with a macro in under 30 seconds",
          type: :chain,
          npc_greeting: "Fifty lines. Same edit. You could do it one at a time. Or you could do it once and let the macro do the rest. qq, record, q, 50@q. Done.",
          npc_confirmation: "Under thirty seconds. That's a macro warrior. Everything else is just typing."
        }
      ],
      side_quests: [
        %Quest{
          id: "side_4_1",
          zone_id: "zone_4",
          number: "4.S1",
          name: "The Undying",
          xp: 20,
          description: "Install undotree. Visual, branching undo history.",
          objectives: ["Install undotree", "Undo, branch, and recover a lost change"],
          turn_in: "Undo, branch, and recover a change you thought was lost",
          type: :side,
          npc_greeting: "Made a mistake? Wrong branch? Don't care. Undotree gives you a visual history of every change — including the ones you thought you lost. Time is a tree, not a line.",
          npc_confirmation: "You recovered a change from a dead branch. Time itself bends for you now."
        }
      ],
      boss: %Quest{
        id: "boss_4",
        zone_id: "zone_4",
        number: "4.B",
        name: "The Five-Minute Sprint",
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
        npc_confirmation: "You're faster in the terminal than you ever were with a GUI. Maren's down in the Depths. Bring a light."
      }
    }
  end

  defp zone_5 do
    %Zone{
      id: "zone_5",
      name: "The Debugging Depths",
      number: 5,
      tagline: "Up there, you learned to write code. Down here, you learn why it breaks.",
      theme: "Debugging, testing, and advanced LSP features.",
      xp_required: 800,
      icon: "🌋",
      total_xp: 210,
      npc: "Maren",
      npc_title: "The Spelunker",
      zone_intro: "The cave mouth exhales cold air that smells of copper and logic. Bioluminescent fungi line the walls, pulsing in patterns that look like stack traces. The deeper you go, the more the walls narrow — until you find a vast underground chamber, lit by hundreds of floating diagnostic markers. Red for errors. Yellow for warnings. Green for the rare, beautiful passing test.",
      quests: [
        %Quest{
          id: "quest_5_1",
          zone_id: "zone_5",
          number: "5.1",
          name: "The Debug Adapter",
          xp: 40,
          description: "Install nvim-dap. Configure it for your primary language. Set a breakpoint, launch a debug session, step through code.",
          objectives: ["Install nvim-dap", "Configure for your language", "Set a breakpoint", "Step through code"],
          turn_in: "Hit a breakpoint and inspect a variable value",
          type: :chain,
          npc_greeting: "The Debug Adapter Protocol. DAP. It's the bridge between your editor and your language's debugger. Set a breakpoint. Launch a session. Step through the code line by line. See what the machine actually does, not what you think it does.",
          npc_confirmation: "You hit a breakpoint. You inspected a variable. You saw the truth, not the assumption. That's the foundation of everything down here."
        },
        %Quest{
          id: "quest_5_2",
          zone_id: "zone_5",
          number: "5.2",
          name: "The Debug UI",
          xp: 20,
          description: "Install nvim-dap-ui. Watch windows, call stacks, and REPL. Learn continue, step over, step into, step out.",
          objectives: ["Install nvim-dap-ui", "Learn F5 (continue)", "Learn F10 (step over)", "Learn F11 (step into)", "Learn F12 (step out)"],
          turn_in: "Step through a bug and find the issue using the DAP UI",
          type: :chain,
          npc_greeting: "DAP alone is powerful but blind. The UI gives you eyes — watch windows, call stacks, a REPL. Now you can see the whole machine at once.",
          npc_confirmation: "You stepped through a bug and found it. Not by guessing — by watching. That's the difference between a developer and a debugger."
        },
        %Quest{
          id: "quest_5_3",
          zone_id: "zone_5",
          number: "5.3",
          name: "The Test Runner",
          xp: 30,
          description: "Install neotest with adapter for your test framework. Run single tests, files, and full suites from Neovim.",
          objectives: ["Install neotest", "Run a single test", "Run a file", "Run the whole suite"],
          turn_in: "Run a single test and see inline pass/fail results",
          type: :chain,
          npc_greeting: "Tests are your map of the Depths. Without them, you're wandering blind. Neotest lets you run them right here — one test, one file, the whole suite. Inline results. No context switching.",
          npc_confirmation: "Inline pass/fail. Right there in your code. You never have to leave to know if something works."
        },
        %Quest{
          id: "quest_5_4",
          zone_id: "zone_5",
          number: "5.4",
          name: "Diagnostics Mastery",
          xp: 20,
          description: "Navigate diagnostics efficiently with ]d/[d, diagnostic float, and Telescope diagnostics.",
          objectives: ["Learn ]d / [d to jump between diagnostics", "Learn <leader>d for diagnostic float", "Use Telescope diagnostics"],
          turn_in: "Find and fix 3 warnings using only diagnostic navigation",
          type: :chain,
          npc_greeting: "The Depths are full of warnings. Most people ignore them until they become errors. Don't be most people. Learn to navigate diagnostics like you navigate code — with precision.",
          npc_confirmation: "Three warnings found and fixed using only diagnostic navigation. You didn't grep. You didn't scroll. You navigated."
        }
      ],
      side_quests: [],
      boss: %Quest{
        id: "boss_5",
        zone_id: "zone_5",
        number: "5.B",
        name: "The Bug Hunt",
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
        npc_greeting: "Real bug. Real project. This is why you came down here. Find it, fix it, prove it's fixed. Every tool you have. No guessing.",
        npc_confirmation: "Your terminal setup now does everything a $400/year IDE does. And you understand every piece of it. The Summit is up there. You'll know what to do when you reach it."
      }
    }
  end

  defp zone_6 do
    %Zone{
      id: "zone_6",
      name: "The Summit",
      number: 6,
      tagline: "The summit is not the end. It is the place where you stop following and start building.",
      theme: "Full customization, personal workflow optimization, and mastery.",
      xp_required: 1100,
      icon: "🏔️",
      total_xp: 290,
      npc: "Kael",
      npc_title: "The Gatekeeper (returned)",
      zone_intro: "The air thins. The view is infinite. From up here, you can see every zone you've crossed — the Crossroads, the Forest, the Tower, the Plains, the Depths. There is no NPC waiting. No quest giver at the gate. Just a flat stone, a cold wind, and an inscription. Then — footsteps behind you. Kael. Older. Slower. But smiling.",
      quests: [
        %Quest{
          id: "quest_6_1",
          zone_id: "zone_6",
          number: "6.1",
          name: "The Snippet Forge",
          xp: 30,
          description: "Install LuaSnip. Create 5 custom snippets for patterns you type daily.",
          objectives: ["Install LuaSnip", "Create 5 custom snippets", "Trigger and tab through placeholders"],
          turn_in: "Trigger a custom snippet and tab through its placeholders",
          type: :chain,
          npc_greeting: "Every master I've known had their own shortcuts. Patterns they typed so often they could do it in their sleep. LuaSnip lets you bottle those patterns. Five snippets. The ones you type every single day.",
          npc_confirmation: "Custom snippets. Your workflow, encoded. That's not configuration — that's craftsmanship."
        },
        %Quest{
          id: "quest_6_2",
          zone_id: "zone_6",
          number: "6.2",
          name: "Your Own Commands",
          xp: 30,
          description: "Write 3 custom Lua functions in your config that automate something you do often. Bind them to keymaps.",
          objectives: ["Write 3 custom Lua functions", "Bind them to keymaps"],
          turn_in: "Trigger your custom function with a keymap",
          type: :chain,
          npc_greeting: "Plugins are other people's solutions. Now write your own. Three functions. Things only you need. Bind them to keys. Make Neovim do something it's never done before — because you told it to.",
          npc_confirmation: "That function exists because you needed it and you built it. Nobody else in the world has that keymap. It's yours."
        },
        %Quest{
          id: "quest_6_3",
          zone_id: "zone_6",
          number: "6.3",
          name: "The Multi-Cursor Illusion",
          xp: 20,
          description: "Learn to replicate multi-cursor: visual block mode, :s substitution, cgn pattern.",
          objectives: [
            "Visual block mode (<C-v>) + I or A for columnar edits",
            ":s substitution with ranges",
            "cgn pattern — change next match, then . to repeat"
          ],
          turn_in: "Make the same edit on 10 lines faster than a multi-cursor would",
          type: :chain,
          npc_greeting: "The GUI warriors love their multi-cursors. Flashy. Impressive looking. Slow. You have something better — three techniques that are faster and more precise.",
          npc_confirmation: "Ten lines. Same edit. Faster than any multi-cursor. And you didn't need a mouse to place a single one of them."
        },
        %Quest{
          id: "quest_6_4",
          zone_id: "zone_6",
          number: "6.4",
          name: "Session Management",
          xp: 20,
          description: "Configure auto-session or persistence.nvim. Neovim restores your last session on open.",
          objectives: ["Install session plugin", "Configure auto-restore"],
          turn_in: "Close Neovim, reopen it, and find everything exactly as you left it",
          type: :chain,
          npc_greeting: "A warrior who has to rebuild their camp every morning is wasting daylight. Session management. When you close Neovim and reopen it, everything should be exactly where you left it.",
          npc_confirmation: "You closed it. You reopened it. Everything's still there. That's not a feature — that's respect for your time."
        },
        %Quest{
          id: "quest_6_5",
          zone_id: "zone_6",
          number: "6.5",
          name: "The Claude Workflow",
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
          npc_greeting: "The old order worked alone. That was its weakness. You have something we never had — an AI companion that can write code, answer questions, and work alongside you. But only if your workspace is built for it.",
          npc_confirmation: "One command. Perfect workspace. Human and AI, side by side. This is what the future of the order looks like."
        }
      ],
      side_quests: [],
      boss: %Quest{
        id: "boss_6",
        zone_id: "zone_6",
        number: "6.B",
        name: "The Full Day",
        xp: 150,
        description: "Spend an entire workday using only your terminal setup. No GUI editor. Track friction points, then configure them away.",
        objectives: [
          "Spend a full workday in terminal only",
          "Track every friction point",
          "Configure away each friction point"
        ],
        turn_in: "You have completed the Neovim Odyssey.",
        type: :boss,
        npc_greeting: "Last one. No timer this time. No artificial challenge. Just a full day of real work. Your projects. Your problems. Your terminal. Nothing else. Every time something feels wrong, write it down. Then fix it.",
        npc_confirmation: "You came here a wanderer. You leave a master. The Neovim Odyssey is complete — but the road never really ends. Someone new will come through the Crossroads tomorrow. Maybe you'll be the one standing at the gate."
      }
    }
  end
end
