defmodule NeovimOdysseyWeb.ZoneLive do
  use NeovimOdysseyWeb, :live_view

  alias NeovimOdyssey.{Quests, Progress}
  alias NeovimOdysseyWeb.Helpers.Images

  @zone_label_colors %{
    1 => "text-amber-400",
    2 => "text-emerald-400",
    3 => "text-sky-400",
    4 => "text-yellow-400",
    5 => "text-rose-400",
    6 => "text-violet-400"
  }

  @zone_bar_colors %{
    1 => "bg-amber-500",
    2 => "bg-emerald-500",
    3 => "bg-sky-500",
    4 => "bg-yellow-500",
    5 => "bg-rose-500",
    6 => "bg-violet-500"
  }

  @impl true
  def mount(%{"zone_number" => zone_number_str}, _session, socket) do
    zone_number = String.to_integer(zone_number_str)
    zone = Quests.get_zone(zone_number)

    if is_nil(zone) do
      {:ok, push_navigate(socket, to: "/")}
    else
      unlocked = Progress.zone_unlocked?(zone_number)

      unless unlocked do
        {:ok, push_navigate(socket, to: "/")}
      else
        completed_ids = MapSet.new(Progress.completed_quest_ids())
        label_color = Map.get(@zone_label_colors, zone_number, "text-amber-400")
        bar_color = Map.get(@zone_bar_colors, zone_number, "bg-amber-500")
        completion = Progress.zone_completion(zone.id)

        zone_image = Images.zone_image(zone_number)
        npc_portrait = if zone.npc, do: Images.npc_portrait(zone.npc), else: nil

        socket =
          socket
          |> assign(:page_title, "Zone #{zone_number}: #{zone.name}")
          |> assign(:zone, zone)
          |> assign(:completed_ids, completed_ids)
          |> assign(:label_color, label_color)
          |> assign(:bar_color, bar_color)
          |> assign(:completion, completion)
          |> assign(:zone_image, zone_image)
          |> assign(:npc_portrait, npc_portrait)

        {:ok, socket}
      end
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <%!-- Hero Banner --%>
    <div class="relative">
      <.hero_banner image={@zone_image} height={:tall}>
        <a href="/" class="absolute top-4 left-4 inline-flex items-center gap-1 text-sm text-slate-300/80 hover:text-slate-100 transition-colors bg-slate-900/40 backdrop-blur-sm px-3 py-1.5 rounded-lg">
          ← Deck Map
        </a>
        <p class={["text-xs font-bold tracking-wider uppercase", @label_color]}>Zone {@zone.number}</p>
        <h1 class="text-3xl md:text-4xl font-black text-slate-100">{@zone.name}</h1>
      </.hero_banner>
    </div>

    <div class="max-w-3xl mx-auto px-4 py-8">
      <%!-- NPC intro --%>
      <%= if @zone.npc && @npc_portrait do %>
        <div class="mb-6">
          <.npc_dialogue_card npc_name={"#{@zone.npc}, #{@zone.npc_title}"} portrait_url={@npc_portrait} zone_number={@zone.number}>
            "{@zone.tagline}"
          </.npc_dialogue_card>
        </div>
      <% end %>

      <%!-- Zone intro (environmental description) --%>
      <%= if @zone.zone_intro do %>
        <p class="text-sm text-slate-400 italic leading-relaxed mb-6">{@zone.zone_intro}</p>
      <% end %>

      <%!-- Zone progress bar --%>
      <div class="mb-8">
        <div class="flex justify-between text-xs mb-1">
          <span class="text-slate-400">{@completion.completed}/{@completion.total} quests</span>
          <span class={["font-bold", @label_color]}>{@completion.xp_earned}/{@zone.total_xp} XP</span>
        </div>
        <div class="w-full h-2 bg-slate-700 rounded-full overflow-hidden">
          <div
            class={["h-full rounded-full transition-all duration-500", @bar_color]}
            style={"width: #{trunc(@completion.progress * 100)}%"}
          />
        </div>
      </div>

      <%!-- Quest Chain --%>
      <div class="mb-8">
        <h2 class="text-sm font-bold text-slate-300 tracking-wider uppercase mb-3">Quest Chain</h2>
        <div class="space-y-2">
          <%= for quest <- @zone.quests do %>
            <.quest_list_item
              quest={quest}
              completed={MapSet.member?(@completed_ids, quest.id)}
              zone_number={@zone.number}
            />
          <% end %>
        </div>
      </div>

      <%!-- Side Quests --%>
      <%= if @zone.side_quests != [] do %>
        <div class="mb-8">
          <h2 class="text-sm font-bold text-purple-400 tracking-wider uppercase mb-3">Side Quests</h2>
          <div class="space-y-2">
            <%= for quest <- @zone.side_quests do %>
              <.quest_list_item
                quest={quest}
                completed={MapSet.member?(@completed_ids, quest.id)}
                zone_number={@zone.number}
              />
            <% end %>
          </div>
        </div>
      <% end %>

      <%!-- Boss Encounter --%>
      <%= if @zone.boss do %>
        <div class="mb-8">
          <h2 class="text-sm font-bold text-red-400 tracking-wider uppercase mb-3">Boss Encounter</h2>
          <.quest_list_item
            quest={@zone.boss}
            completed={MapSet.member?(@completed_ids, @zone.boss.id)}
            zone_number={@zone.number}
          />
        </div>
      <% end %>
    </div>
    """
  end
end
