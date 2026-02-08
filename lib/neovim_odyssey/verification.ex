defmodule NeovimOdyssey.Verification do
  @moduledoc false

  alias NeovimOdyssey.Quests

  @doc """
  Verify a quest by running all associated checks.
  Returns `{:pass | :fail | :self_attest, results}`.
  """
  def verify(quest_id) do
    checks = checks_for(quest_id)
    results = Enum.map(checks, &evaluate/1)

    status =
      cond do
        Enum.empty?(checks) -> :self_attest
        Enum.all?(checks, &match?(:self_attestation, &1)) -> :self_attest
        Enum.all?(results, & &1.passed) -> :pass
        true -> :fail
      end

    {status, results}
  end

  def nvim_config_dir, do: Path.expand("~/.config/nvim")
  def lazy_plugins_dir, do: Path.expand("~/.local/share/nvim/lazy")

  # --- Check evaluation ---

  defp evaluate({:file_exists, path}) do
    expanded = Path.expand(path)
    passed = File.exists?(expanded)
    display = display_path(path)

    %{
      check: {:file_exists, path},
      passed: passed,
      message: if(passed, do: "Found #{display}", else: "Missing #{display}")
    }
  end

  defp evaluate({:dir_exists, path}) do
    expanded = Path.expand(path)
    passed = File.dir?(expanded)
    display = display_path(path)

    %{
      check: {:dir_exists, path},
      passed: passed,
      message: if(passed, do: "Found directory #{display}", else: "Missing directory #{display}")
    }
  end

  defp evaluate({:any_dir_exists, paths}) do
    results = Enum.map(paths, fn path -> {path, File.dir?(Path.expand(path))} end)
    passed = Enum.any?(results, fn {_p, exists?} -> exists? end)
    names = Enum.map(paths, &display_path/1) |> Enum.join(" or ")

    found =
      results
      |> Enum.filter(fn {_p, exists?} -> exists? end)
      |> Enum.map(fn {p, _} -> display_path(p) end)

    %{
      check: {:any_dir_exists, paths},
      passed: passed,
      message:
        if(passed,
          do: "Found #{Enum.join(found, ", ")}",
          else: "None found: #{names}"
        )
    }
  end

  defp evaluate({:config_contains, regex}) do
    {passed, message} = search_config(regex)
    %{check: {:config_contains, regex}, passed: passed, message: message}
  end

  defp evaluate({:plugin_installed, name}) do
    path = Path.join(lazy_plugins_dir(), name)
    passed = File.dir?(path)

    %{
      check: {:plugin_installed, name},
      passed: passed,
      message:
        if(passed,
          do: "Plugin #{name} is installed",
          else: "Plugin #{name} not found in lazy.nvim"
        )
    }
  end

  defp evaluate({:command_output, cmd, regex}) do
    {passed, message} = run_command(cmd, regex)
    %{check: {:command_output, cmd, regex}, passed: passed, message: message}
  end

  defp evaluate(:self_attestation) do
    %{check: :self_attestation, passed: true, message: "Self-attestation required"}
  end

  # --- Implementation helpers ---

  defp search_config(regex) do
    config_dir = nvim_config_dir()
    pattern = Path.join([config_dir, "**", "*.lua"])

    try do
      files = Path.wildcard(pattern)

      if Enum.empty?(files) do
        {false, "No .lua files found in #{display_path(config_dir)}"}
      else
        found =
          Enum.any?(files, fn file ->
            try do
              content = File.read!(file)
              Regex.match?(regex, content)
            rescue
              _ -> false
            end
          end)

        label = regex.source

        if found do
          {true, "Config contains #{label}"}
        else
          {false, "Could not find #{label} in Neovim config"}
        end
      end
    rescue
      _ -> {false, "Error reading Neovim config directory"}
    end
  end

  defp run_command(cmd, regex) do
    try do
      [program | args] = String.split(cmd)

      case System.cmd(program, args, stderr_to_stdout: true) do
        {output, 0} ->
          if Regex.match?(regex, output) do
            case Regex.run(regex, output) do
              [match | _] -> {true, "#{String.trim(match)} detected"}
              _ -> {true, "Command check passed"}
            end
          else
            {false, "Command '#{cmd}' output did not match expected pattern"}
          end

        {_output, _code} ->
          {false, "Command '#{cmd}' failed"}
      end
    rescue
      e -> {false, "Command '#{cmd}' error: #{Exception.message(e)}"}
    end
  end

  defp display_path(path) do
    home = Path.expand("~")
    expanded = Path.expand(path)

    if String.starts_with?(expanded, home) do
      String.replace(expanded, home, "~")
    else
      path
    end
  end

  # --- Quest check registry ---

  defp checks_for(quest_id) do
    case Quests.get_quest(quest_id) do
      %{verification_checks: checks} when is_list(checks) and checks != [] -> checks
      _ -> default_checks(quest_id)
    end
  end

  # Zone 1: The Bridge
  defp default_checks("quest_1_1"), do: [{:command_output, "nvim --version", ~r/NVIM v0\.(9|[1-9]\d)\.\d/}]
  defp default_checks("quest_1_2"), do: [:self_attestation]
  defp default_checks("quest_1_3") do
    [
      {:file_exists, "~/.config/nvim/init.lua"},
      {:config_contains, ~r/vim\.opt\.number\s*=\s*true/},
      {:config_contains, ~r/vim\.opt\.relativenumber\s*=\s*true/},
      {:config_contains, ~r/vim\.opt\.(expandtab|shiftwidth|tabstop)/}
    ]
  end
  defp default_checks("quest_1_4"), do: [:self_attestation]
  defp default_checks("boss_1") do
    [
      {:config_contains, ~r/vim\.opt\.number\s*=\s*true/},
      {:config_contains, ~r/vim\.g\.mapleader\s*=\s*" "/},
      {:config_contains, ~r/vim\.keymap\.set/}
    ]
  end

  # Zone 2: The Module Bay
  defp default_checks("quest_2_1"), do: [{:dir_exists, "~/.local/share/nvim/lazy"}, {:config_contains, ~r/lazy/}]
  defp default_checks("quest_2_2"), do: [{:plugin_installed, "telescope.nvim"}, {:config_contains, ~r/telescope/}]
  defp default_checks("quest_2_3"), do: [{:any_dir_exists, ["~/.local/share/nvim/lazy/oil.nvim", "~/.local/share/nvim/lazy/neo-tree.nvim"]}]
  defp default_checks("quest_2_4"), do: [{:plugin_installed, "gitsigns.nvim"}]
  defp default_checks("quest_2_5"), do: [{:plugin_installed, "lualine.nvim"}]
  defp default_checks("side_2_1"), do: [{:plugin_installed, "which-key.nvim"}]
  defp default_checks("boss_2"), do: [:self_attestation]

  # Zone 3: The Analysis Deck
  defp default_checks("quest_3_1"), do: [{:plugin_installed, "nvim-lspconfig"}, {:config_contains, ~r/lspconfig/}]
  defp default_checks("quest_3_2"), do: [{:config_contains, ~r/gd/}, {:config_contains, ~r/gr/}]
  defp default_checks("quest_3_3"), do: [{:plugin_installed, "nvim-cmp"}]
  defp default_checks("quest_3_4"), do: [{:plugin_installed, "nvim-treesitter"}]
  defp default_checks("quest_3_5"), do: [{:plugin_installed, "nvim-treesitter-textobjects"}]
  defp default_checks("side_3_1"), do: [{:plugin_installed, "conform.nvim"}]
  defp default_checks("side_3_2"), do: [{:plugin_installed, "nvim-lint"}]
  defp default_checks("boss_3"), do: [:self_attestation]

  # Zone 4: The Nav Array
  defp default_checks("quest_4_1"), do: [{:any_dir_exists, ["~/.local/share/nvim/lazy/flash.nvim", "~/.local/share/nvim/lazy/leap.nvim"]}]
  defp default_checks("quest_4_2"), do: [{:plugin_installed, "harpoon"}]
  defp default_checks("quest_4_3"), do: [:self_attestation]
  defp default_checks("quest_4_4"), do: [{:plugin_installed, "vim-tmux-navigator"}]
  defp default_checks("quest_4_5"), do: [:self_attestation]
  defp default_checks("side_4_1"), do: [{:plugin_installed, "undotree"}]
  defp default_checks("boss_4"), do: [:self_attestation]

  # Zone 5: The Engine Room
  defp default_checks("quest_5_1"), do: [{:plugin_installed, "nvim-dap"}]
  defp default_checks("quest_5_2"), do: [{:plugin_installed, "nvim-dap-ui"}]
  defp default_checks("quest_5_3"), do: [{:plugin_installed, "neotest"}]
  defp default_checks("quest_5_4"), do: [:self_attestation]
  defp default_checks("boss_5"), do: [:self_attestation]

  # Zone 6: The Command Chair
  defp default_checks("quest_6_1"), do: [{:plugin_installed, "LuaSnip"}]
  defp default_checks("quest_6_2"), do: [{:config_contains, ~r/vim\.keymap\.set/}]
  defp default_checks("quest_6_3"), do: [:self_attestation]
  defp default_checks("quest_6_4"), do: [{:any_dir_exists, ["~/.local/share/nvim/lazy/auto-session", "~/.local/share/nvim/lazy/persistence.nvim"]}]
  defp default_checks("quest_6_5"), do: [:self_attestation]
  defp default_checks("boss_6"), do: [:self_attestation]

  # Dailies + fallback
  defp default_checks("daily_" <> _), do: [:self_attestation]
  defp default_checks(_quest_id), do: [:self_attestation]
end
