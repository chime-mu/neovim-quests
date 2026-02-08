defmodule NeovimOdysseyWeb.GameComponents do
  use Phoenix.Component

  alias NeovimOdysseyWeb.Helpers.Images
  alias NeovimOdyssey.{Quests, Progress}

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

  # --- Hero Banner ---

  attr :image, :string, required: true
  attr :height, :atom, default: :tall
  slot :inner_block, required: true

  def hero_banner(assigns) do
    height_class =
      case assigns.height do
        :tall -> "h-[350px] md:h-[420px]"
        :short -> "h-[250px] md:h-[300px]"
      end

    overlay_class =
      case assigns.height do
        :tall -> "hero-overlay"
        :short -> "hero-overlay-dark"
      end

    assigns = assign(assigns, height_class: height_class, overlay_class: overlay_class)

    ~H"""
    <div class={["relative w-full overflow-hidden", @height_class]}>
      <img
        src={@image}
        alt=""
        class="absolute inset-0 w-full h-full object-cover"
        loading="eager"
      />
      <div class={["absolute inset-0", @overlay_class]} />
      <div class="relative h-full flex flex-col justify-end pb-6 px-4 max-w-5xl mx-auto">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # --- NPC Dialogue Card ---

  attr :npc_name, :string, required: true
  attr :portrait_url, :string, required: true
  attr :zone_number, :integer, default: 1
  slot :inner_block, required: true

  def npc_dialogue_card(assigns) do
    style = zone_style(assigns.zone_number)
    assigns = assign(assigns, :zs, style)

    ~H"""
    <div class={[
      "bg-slate-800/80 border border-slate-700/50 rounded-lg p-4",
      "border-l-2",
      @zs.border
    ]}>
      <div class="flex items-start gap-3">
        <img
          src={@portrait_url}
          alt={@npc_name}
          class="w-16 h-16 rounded-full object-cover flex-shrink-0 border-2 border-slate-600/50"
          loading="lazy"
        />
        <div class="flex-1 min-w-0">
          <p class={["text-xs font-bold mb-1", @zs.label]}>{@npc_name}</p>
          <div class="text-sm text-slate-300 italic">
            {render_slot(@inner_block)}
          </div>
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
    image = Images.zone_thumbnail(assigns.zone.number)
    assigns = assign(assigns, zs: style, image: image)

    ~H"""
    <div class={[
      "relative group rounded-xl border-2 transition-all duration-300 overflow-hidden",
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

      <a href={if @unlocked, do: "/zones/#{@zone.number}", else: "#"} class="block">
        <div class="aspect-video overflow-hidden">
          <img
            src={@image}
            alt={@zone.name}
            class={[
              "w-full h-full object-cover transition-transform duration-300 group-hover:scale-105",
              if(not @unlocked, do: "grayscale opacity-40")
            ]}
            loading="lazy"
          />
        </div>

        <div class="p-5">
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
        </div>
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

  # --- Stats Overlay ---

  attr :level, :integer, required: true
  attr :title, :string, required: true
  attr :level_info, :map, required: true
  attr :hp, :integer, required: true
  attr :max_hp, :integer, required: true
  attr :bosses_cleared, :integer, default: 0

  def stats_overlay(assigns) do
    hp_percent = if assigns.max_hp > 0, do: trunc(assigns.hp / assigns.max_hp * 100), else: 0
    xp_percent = trunc(assigns.level_info.progress * 100)
    assigns = assign(assigns, :hp_percent, hp_percent)
    assigns = assign(assigns, :xp_percent, xp_percent)

    ~H"""
    <div class="absolute top-4 right-4 z-10 bg-slate-900/80 backdrop-blur-sm rounded-lg border border-slate-700/50 p-3 min-w-[180px]">
      <%!-- Level badge --%>
      <div class="flex items-center gap-2 mb-2">
        <div class="w-8 h-8 rounded-full bg-amber-500/20 border border-amber-500/40 flex items-center justify-center">
          <span class="text-xs font-black text-amber-400">{@level}</span>
        </div>
        <div>
          <div class="text-xs font-bold text-slate-200">{@title}</div>
          <div class="text-[10px] text-slate-500">{@level_info.current_xp} XP</div>
        </div>
      </div>

      <%!-- XP bar --%>
      <div class="mb-2">
        <div class="flex justify-between text-[10px] text-slate-500 mb-0.5">
          <span>XP</span>
          <span>{@xp_percent}%</span>
        </div>
        <div class="h-1.5 bg-slate-700 rounded-full overflow-hidden">
          <div
            class="h-full bg-gradient-to-r from-amber-600 to-amber-400 rounded-full transition-all duration-1000"
            style={"width: #{@xp_percent}%"}
          />
        </div>
      </div>

      <%!-- HP bar --%>
      <div class="mb-2">
        <div class="flex justify-between text-[10px] text-slate-500 mb-0.5">
          <span>HP</span>
          <span>{@hp}/{@max_hp}</span>
        </div>
        <div class="h-1.5 bg-slate-700 rounded-full overflow-hidden">
          <div
            class={[
              "h-full rounded-full transition-all duration-1000",
              if(@hp_percent > 50, do: "bg-gradient-to-r from-red-600 to-rose-400", else: if(@hp_percent > 25, do: "bg-gradient-to-r from-red-700 to-red-500", else: "bg-red-600 animate-pulse"))
            ]}
            style={"width: #{@hp_percent}%"}
          />
        </div>
      </div>

      <%!-- Boss kills --%>
      <div class="flex items-center gap-1 text-[10px] text-slate-500">
        <span>⚔</span>
        <span>{@bosses_cleared} bosses cleared</span>
      </div>
    </div>
    """
  end

  # --- Verification Panel ---

  attr :results, :list, required: true
  attr :status, :atom, required: true

  def verification_panel(assigns) do
    ~H"""
    <div class="rounded-lg border border-slate-700/50 bg-slate-800/60 p-4 mb-4">
      <h3 class="text-xs font-bold text-slate-400 tracking-wider uppercase mb-3">Verification Results</h3>
      <ul class="space-y-2">
        <%= for result <- @results do %>
          <li class="flex items-start gap-2 text-sm">
            <span class={if result.passed, do: "text-emerald-400 mt-0.5", else: "text-red-400 mt-0.5"}>
              {if result.passed, do: "✓", else: "✗"}
            </span>
            <span class={if result.passed, do: "text-emerald-300", else: "text-red-300"}>
              {result.message}
            </span>
          </li>
        <% end %>
      </ul>
      <%= if @status == :fail do %>
        <p class="text-xs text-slate-500 mt-3">Fix the failing checks and try again.</p>
      <% end %>
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
          <div class="text-6xl mb-4">🚀</div>
          <h2 class="text-4xl font-black text-amber-400 mb-2 tracking-wider">LEVEL UP!</h2>
          <p class="text-2xl text-amber-300 font-bold">Level {@new_level}</p>
          <p class="text-lg text-amber-200/70 mt-1">{@title}</p>
          <p class="text-sm text-slate-500 mt-4">Click to dismiss</p>
        </div>
      </div>
    <% end %>
    """
  end

  # --- Quest Tracker Sidebar ---

  def quest_tracker(assigns) do
    zones = Quests.list_zones()
    completed_ids = Progress.completed_quest_ids() |> MapSet.new()

    current_zone =
      zones
      |> Enum.filter(fn z -> Progress.zone_unlocked?(z.number) end)
      |> Enum.reverse()
      |> Enum.find(fn z ->
        all = z.quests ++ z.side_quests ++ if(z.boss, do: [z.boss], else: [])
        Enum.any?(all, fn q -> not MapSet.member?(completed_ids, q.id) end)
      end)

    next_quest =
      if current_zone do
        Enum.find(current_zone.quests, fn q -> not MapSet.member?(completed_ids, q.id) end)
      end

    side_quests =
      if current_zone do
        Enum.filter(current_zone.side_quests, fn q -> not MapSet.member?(completed_ids, q.id) end)
      else
        []
      end

    boss_status =
      if current_zone && current_zone.boss do
        if MapSet.member?(completed_ids, current_zone.boss.id), do: :cleared, else: :available
      end

    assigns =
      assigns
      |> assign(:current_zone, current_zone)
      |> assign(:next_quest, next_quest)
      |> assign(:side_quests, side_quests)
      |> assign(:boss_status, boss_status)

    ~H"""
    <div
      id="quest-tracker"
      class="fixed top-16 right-0 w-72 h-[calc(100vh-4rem)] bg-slate-900/95 backdrop-blur border-l border-slate-800 z-30 transform translate-x-full transition-transform duration-300 overflow-y-auto"
      phx-hook="QuestTracker"
    >
      <div class="p-4">
        <h2 class="text-xs font-bold text-slate-400 tracking-wider uppercase mb-4">Quest Tracker</h2>

        <%= if @current_zone do %>
          <div class="mb-4">
            <div class="text-sm font-bold text-slate-200 mb-1 flex items-center gap-2">
              <span>{@current_zone.icon}</span>
              <span>{@current_zone.name}</span>
            </div>
          </div>

          <%= if @next_quest do %>
            <div class="mb-4">
              <div class="text-xs text-amber-400 font-bold mb-1">CURRENT QUEST</div>
              <a href={"/quests/#{@next_quest.id}"} class="block rounded-lg border border-amber-500/20 bg-amber-500/5 p-3 hover:bg-amber-500/10 transition-colors">
                <div class="text-sm font-bold text-slate-200 mb-1">{@next_quest.name}</div>
                <ul class="space-y-1">
                  <%= for obj <- @next_quest.objectives do %>
                    <li class="text-xs text-slate-400 flex items-start gap-1.5">
                      <span class="text-slate-600 mt-0.5">○</span>
                      <span>{obj}</span>
                    </li>
                  <% end %>
                </ul>
                <div class="text-xs text-amber-400/70 mt-2">+{@next_quest.xp} XP</div>
              </a>
            </div>
          <% end %>

          <%= if @side_quests != [] do %>
            <div class="mb-4">
              <div class="text-xs text-purple-400 font-bold mb-1">SIDE QUESTS</div>
              <%= for quest <- @side_quests do %>
                <a href={"/quests/#{quest.id}"} class="block rounded-lg border border-purple-500/20 bg-purple-500/5 p-2 mb-1 hover:bg-purple-500/10 transition-colors">
                  <div class="text-xs font-bold text-slate-300">{quest.name}</div>
                  <div class="text-[10px] text-purple-400/70">+{quest.xp} XP</div>
                </a>
              <% end %>
            </div>
          <% end %>

          <%= if @boss_status do %>
            <div class="mb-4">
              <div class="text-xs text-red-400 font-bold mb-1">BOSS</div>
              <div class={[
                "rounded-lg border p-2",
                if(@boss_status == :cleared, do: "border-emerald-500/20 bg-emerald-500/5", else: "border-red-500/20 bg-red-500/5")
              ]}>
                <div class="text-xs font-bold text-slate-300">
                  {if @boss_status == :cleared, do: "✓ ", else: "⚔ "}{@current_zone.boss.name}
                </div>
              </div>
            </div>
          <% end %>
        <% else %>
          <p class="text-sm text-slate-500">All quests completed!</p>
        <% end %>
      </div>
    </div>
    """
  end
end
