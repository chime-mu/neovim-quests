defmodule NeovimOdysseyWeb.ZoneLive do
  use NeovimOdysseyWeb, :live_view

  alias NeovimOdyssey.{Quests, Progress}

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

        socket =
          socket
          |> assign(:page_title, "Zone #{zone_number}: #{zone.name}")
          |> assign(:zone, zone)
          |> assign(:completed_ids, completed_ids)
          |> assign(:label_color, label_color)
          |> assign(:bar_color, bar_color)
          |> assign(:completion, completion)

        {:ok, socket}
      end
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-3xl mx-auto px-4 py-8">
      <%!-- Back link --%>
      <a href="/" class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-300 mb-6 transition-colors">
        ← Back to Map
      </a>

      <%!-- Zone Header --%>
      <div class="mb-8">
        <div class="flex items-center gap-3 mb-2">
          <span class="text-3xl">{@zone.icon}</span>
          <div>
            <p class={["text-xs font-bold tracking-wider uppercase", @label_color]}>Zone {@zone.number}</p>
            <h1 class="text-2xl font-black text-slate-100">{@zone.name}</h1>
          </div>
        </div>
        <p class="text-slate-400 italic mb-3">"{@zone.tagline}"</p>
        <p class="text-sm text-slate-500">{@zone.theme}</p>

        <%!-- Zone progress bar --%>
        <div class="mt-4">
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
          <h2 class="text-sm font-bold text-red-400 tracking-wider uppercase mb-3">🗡️ Boss Encounter</h2>
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
