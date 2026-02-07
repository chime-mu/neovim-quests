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
        type: :daily
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
        type: :daily
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
        type: :daily
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
        type: :daily
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
        type: :daily
      }
    ]
  end

  defp zone_1 do
    %Zone{
      id: "zone_1",
      name: "The Crossroads",
      number: 1,
      tagline: "Your vi instincts are strong, warrior. But first, let us see if this new land recognizes your blade.",
      theme: "Get Neovim installed, configured, and verify your vi skills carry over.",
      xp_required: 0,
      icon: "🏕️",
      total_xp: 110,
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
        type: :boss
      }
    }
  end

  defp zone_2 do
    %Zone{
      id: "zone_2",
      name: "The Plugin Forest",
      number: 2,
      tagline: "Alone, a warrior is strong. With allies, unstoppable.",
      theme: "Plugin management and your first essential plugins.",
      xp_required: 100,
      icon: "🌲",
      total_xp: 190,
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
          type: :chain
        },
        %Quest{
          id: "quest_2_2",
          zone_id: "zone_2",
          number: "2.2",
          name: "First Ally: The Pathfinder",
          xp: 30,
          description: "Install telescope.nvim (fuzzy finder). Add keymaps for find files, live grep, and list buffers.",
          objectives: [
            "Install telescope.nvim",
            "Map <leader>ff to find files",
            "Map <leader>fg to live grep",
            "Map <leader>fb to list buffers"
          ],
          turn_in: "<leader>ff opens a fuzzy file picker",
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
        }
      ],
      side_quests: [
        %Quest{
          id: "side_2_1",
          zone_id: "zone_2",
          number: "2.S1",
          name: "The Whisperer",
          xp: 30,
          description: "Install which-key.nvim. Now when you press <leader> and pause, a popup shows all available keymaps.",
          objectives: ["Install which-key.nvim", "Press <leader> and see the popup"],
          turn_in: "Press <leader> and see the popup",
          type: :side
        }
      ],
      boss: %Quest{
        id: "boss_2",
        zone_id: "zone_2",
        number: "2.B",
        name: "The Lost File",
        xp: 60,
        description: "Your quest giver hid a file somewhere in a large project directory. Find it, search it, rename it, and stage changes — all without leaving Neovim.",
        objectives: [
          "Use Telescope find_files to locate treasure.txt",
          "Use Telescope live_grep to find which file contains 'gold'",
          "Use file explorer to rename it to claimed.txt",
          "Use gitsigns to stage and preview changes"
        ],
        turn_in: "You now understand that Neovim can replace most of what you used the GUI for.",
        type: :boss
      }
    }
  end

  defp zone_3 do
    %Zone{
      id: "zone_3",
      name: "The Tower of Language",
      number: 3,
      tagline: "The scribes in this tower speak every language. They will teach your blade to understand code itself.",
      theme: "LSP, autocompletion, and syntax-aware editing.",
      xp_required: 300,
      icon: "🏰",
      total_xp: 260,
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :side
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
          type: :side
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
        type: :boss
      }
    }
  end

  defp zone_4 do
    %Zone{
      id: "zone_4",
      name: "The Speed Plains",
      number: 4,
      tagline: "Knowledge is nothing without speed. Here, we forge reflexes.",
      theme: "Advanced motions, workflow speed, and tmux integration.",
      xp_required: 550,
      icon: "⚡",
      total_xp: 220,
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :side
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
        type: :boss
      }
    }
  end

  defp zone_5 do
    %Zone{
      id: "zone_5",
      name: "The Debugging Depths",
      number: 5,
      tagline: "Even the greatest warriors must sometimes descend into darkness to find the truth.",
      theme: "Debugging, testing, and advanced LSP features.",
      xp_required: 800,
      icon: "🌋",
      total_xp: 210,
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
        type: :boss
      }
    }
  end

  defp zone_6 do
    %Zone{
      id: "zone_6",
      name: "The Summit",
      number: 6,
      tagline: "Few reach the summit. Those who do reshape the world to their will.",
      theme: "Full customization, personal workflow optimization, and mastery.",
      xp_required: 1100,
      icon: "🏔️",
      total_xp: 290,
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
          type: :chain
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
        type: :boss
      }
    }
  end
end
