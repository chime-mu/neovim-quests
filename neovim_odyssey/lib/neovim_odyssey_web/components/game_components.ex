defmodule NeovimOdysseyWeb.GameComponents do
  use Phoenix.Component

  # Zone color classes — all complete strings so Tailwind can scan them
  @zone_styles %{
    1 => %{
      label: "text-amber-400",
      border: "border-amber-500/30",
      border_hover: "hover:border-amber-400/50",
      shadow: "hover:shadow-amber-500/10",
      bar: "bg-amber-500",
      quest_hover: "hover:border-amber-500/40"
    },
    2 => %{
      label: "text-emerald-400",
      border: "border-emerald-500/30",
      border_hover: "hover:border-emerald-400/50",
      shadow: "hover:shadow-emerald-500/10",
      bar: "bg-emerald-500",
      quest_hover: "hover:border-emerald-500/40"
    },
    3 => %{
      label: "text-sky-400",
      border: "border-sky-500/30",
      border_hover: "hover:border-sky-400/50",
      shadow: "hover:shadow-sky-500/10",
      bar: "bg-sky-500",
      quest_hover: "hover:border-sky-500/40"
    },
    4 => %{
      label: "text-yellow-400",
      border: "border-yellow-500/30",
      border_hover: "hover:border-yellow-400/50",
      shadow: "hover:shadow-yellow-500/10",
      bar: "bg-yellow-500",
      quest_hover: "hover:border-yellow-500/40"
    },
    5 => %{
      label: "text-rose-400",
      border: "border-rose-500/30",
      border_hover: "hover:border-rose-400/50",
      shadow: "hover:shadow-rose-500/10",
      bar: "bg-rose-500",
      quest_hover: "hover:border-rose-500/40"
    },
    6 => %{
      label: "text-violet-400",
      border: "border-violet-500/30",
      border_hover: "hover:border-violet-400/50",
      shadow: "hover:shadow-violet-500/10",
      bar: "bg-violet-500",
      quest_hover: "hover:border-violet-500/40"
    }
  }

  defp zone_style(zone_number), do: Map.get(@zone_styles, zone_number, @zone_styles[1])

  # --- XP Bar ---

  attr :level_info, :map, required: true

  def xp_bar(assigns) do
    ~H"""
    <div class="w-full">
      <div class="flex justify-between items-center mb-1">
        <span class="text-xs text-amber-400 font-bold tracking-wider">
          LEVEL {@level_info.current_level}
        </span>
        <span class="text-xs text-slate-400">
          {@level_info.current_xp} XP
          <%= if @level_info.xp_needed > 0 do %>
            <span class="text-slate-500">/ {@level_info.xp_needed} to next</span>
          <% end %>
        </span>
      </div>
      <div class="w-full h-3 bg-slate-700 rounded-full overflow-hidden border border-slate-600">
        <div
          class="h-full bg-gradient-to-r from-amber-600 to-amber-400 rounded-full transition-all duration-1000 ease-out"
          style={"width: #{trunc(@level_info.progress * 100)}%"}
        >
        </div>
      </div>
    </div>
    """
  end

  # --- Zone Card ---

  attr :zone, :map, required: true
  attr :unlocked, :boolean, default: false
  attr :completion, :map, default: %{completed: 0, total: 0, xp_earned: 0, progress: 0.0}

  def zone_card(assigns) do
    style = zone_style(assigns.zone.number)
    assigns = assign(assigns, :zs, style)

    ~H"""
    <div class={[
      "relative group rounded-xl border-2 transition-all duration-300",
      if(@unlocked,
        do: [@zs.border, "bg-slate-800/80", @zs.border_hover, "hover:shadow-lg", @zs.shadow, "cursor-pointer"],
        else: "border-slate-700/50 bg-slate-800/40 opacity-60"
      )
    ]}>
      <%= if not @unlocked do %>
        <div class="absolute inset-0 flex items-center justify-center z-10 rounded-xl bg-slate-900/60">
          <div class="text-center">
            <div class="text-3xl mb-1">🔒</div>
            <p class="text-xs text-slate-400">{@zone.xp_required} XP to unlock</p>
          </div>
        </div>
      <% end %>

      <a href={if @unlocked, do: "/zones/#{@zone.number}", else: "#"} class="block p-5">
        <div class="flex items-start gap-3 mb-3">
          <span class="text-2xl">{@zone.icon}</span>
          <div>
            <p class={["text-xs font-bold tracking-wider uppercase", @zs.label]}>
              Zone {@zone.number}
            </p>
            <h3 class="text-lg font-bold text-slate-100">{@zone.name}</h3>
          </div>
        </div>

        <p class="text-sm text-slate-400 mb-3 italic">"{@zone.tagline}"</p>

        <div class="flex items-center justify-between text-xs">
          <span class="text-slate-500">{@completion.completed}/{@completion.total} quests</span>
          <span class={["font-bold", @zs.label]}>{@completion.xp_earned}/{@zone.total_xp} XP</span>
        </div>

        <%= if @unlocked and @completion.total > 0 do %>
          <div class="mt-2 w-full h-1.5 bg-slate-700 rounded-full overflow-hidden">
            <div
              class={["h-full rounded-full transition-all duration-500", @zs.bar]}
              style={"width: #{trunc(@completion.progress * 100)}%"}
            />
          </div>
        <% end %>
      </a>
    </div>
    """
  end

  # --- Quest List Item ---

  attr :quest, :map, required: true
  attr :completed, :boolean, default: false
  attr :zone_number, :integer, default: 1

  def quest_list_item(assigns) do
    style = zone_style(assigns.zone_number)
    assigns = assign(assigns, :zs, style)

    ~H"""
    <a
      href={"/quests/#{@quest.id}"}
      class={[
        "block rounded-lg border p-4 transition-all duration-200",
        if(@completed,
          do: "border-emerald-500/30 bg-emerald-500/5",
          else: ["border-slate-700 bg-slate-800/50", @zs.quest_hover, "hover:bg-slate-800"]
        )
      ]}
    >
      <div class="flex items-center gap-3">
        <div class={[
          "flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold",
          if(@completed, do: "bg-emerald-500/20 text-emerald-400", else: "bg-slate-700 text-slate-400")
        ]}>
          <%= if @completed do %>
            ✓
          <% else %>
            {@quest.number}
          <% end %>
        </div>
        <div class="flex-1 min-w-0">
          <div class="flex items-center gap-2">
            <h4 class={[
              "font-semibold text-sm",
              if(@completed, do: "text-emerald-300", else: "text-slate-200")
            ]}>
              {@quest.name}
            </h4>
            <.quest_type_badge type={@quest.type} />
          </div>
          <p class="text-xs text-slate-500 truncate">{@quest.turn_in}</p>
        </div>
        <div class={[
          "text-sm font-bold",
          if(@completed, do: "text-emerald-400", else: "text-amber-400")
        ]}>
          +{@quest.xp} XP
        </div>
      </div>
    </a>
    """
  end

  # --- Quest Type Badge ---

  attr :type, :atom, required: true

  def quest_type_badge(assigns) do
    {label, classes} =
      case assigns.type do
        :chain -> {"Chain", "bg-blue-500/20 text-blue-300 border-blue-500/30"}
        :side -> {"Side", "bg-purple-500/20 text-purple-300 border-purple-500/30"}
        :boss -> {"Boss", "bg-red-500/20 text-red-300 border-red-500/30"}
        :daily -> {"Daily", "bg-teal-500/20 text-teal-300 border-teal-500/30"}
      end

    assigns = assign(assigns, label: label, classes: classes)

    ~H"""
    <span class={["text-[10px] px-1.5 py-0.5 rounded border font-semibold uppercase tracking-wider", @classes]}>
      {@label}
    </span>
    """
  end

  # --- XP Gain Flash ---

  attr :xp, :integer, required: true
  attr :id, :string, default: "xp-flash"

  def xp_gain_flash(assigns) do
    ~H"""
    <div
      id={@id}
      class="xp-float-up fixed top-20 left-1/2 -translate-x-1/2 z-50 pointer-events-none"
    >
      <span class="text-3xl font-black text-amber-400 drop-shadow-[0_0_12px_rgba(251,191,36,0.5)]">
        +{@xp} XP
      </span>
    </div>
    """
  end

  # --- Level Up Overlay ---

  attr :show, :boolean, default: false
  attr :new_level, :integer, default: 1
  attr :title, :string, default: ""

  def level_up_overlay(assigns) do
    ~H"""
    <%= if @show do %>
      <div
        id="level-up-overlay"
        class="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm"
        phx-click="dismiss_level_up"
      >
        <div class="text-center level-up-pulse">
          <div class="text-6xl mb-4">⚔️</div>
          <h2 class="text-4xl font-black text-amber-400 mb-2 tracking-wider">LEVEL UP!</h2>
          <p class="text-2xl text-amber-300 font-bold">Level {@new_level}</p>
          <p class="text-lg text-amber-200/70 mt-1">{@title}</p>
          <p class="text-sm text-slate-500 mt-4">Click to dismiss</p>
        </div>
      </div>
    <% end %>
    """
  end
end
