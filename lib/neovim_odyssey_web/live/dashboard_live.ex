defmodule NeovimOdysseyWeb.DashboardLive do
  use NeovimOdysseyWeb, :live_view

  alias NeovimOdyssey.{Quests, Progress}
  alias NeovimOdysseyWeb.Helpers.Images

  @impl true
  def mount(_params, _session, socket) do
    xp = Progress.total_xp()
    level = Progress.current_level(xp)
    level_info = Progress.xp_for_next_level(xp)
    title = Progress.level_title(level)
    zones = Quests.list_zones()

    zone_data =
      Enum.map(zones, fn zone ->
        %{
          zone: zone,
          unlocked: Progress.zone_unlocked?(zone.number),
          completion: Progress.zone_completion(zone.id)
        }
      end)

    total_quests = zones |> Enum.flat_map(fn z -> z.quests ++ z.side_quests ++ [z.boss] end) |> Enum.reject(&is_nil/1) |> length()
    completed_count = length(Progress.completed_quest_ids())
    bosses_cleared = Progress.completed_quest_ids() |> Enum.count(&String.starts_with?(&1, "boss_"))

    socket =
      socket
      |> assign(:page_title, "Dashboard")
      |> assign(:xp, xp)
      |> assign(:level, level)
      |> assign(:level_info, level_info)
      |> assign(:title, title)
      |> assign(:zone_data, zone_data)
      |> assign(:total_quests, total_quests)
      |> assign(:completed_count, completed_count)
      |> assign(:bosses_cleared, bosses_cleared)
      |> assign(:ship_image, Images.ship_exterior())

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <%!-- Hero Banner --%>
    <.hero_banner image={@ship_image} height={:tall}>
      <h1 class="text-4xl md:text-5xl font-black text-slate-100 tracking-tight mb-1">The Meridian</h1>
      <p class="text-amber-400 font-bold text-lg tracking-wider uppercase">{@title}</p>
      <div class="mt-3 max-w-md">
        <.xp_bar level_info={@level_info} />
      </div>
    </.hero_banner>

    <div class="max-w-5xl mx-auto px-4 py-8">
      <%!-- Stats Summary --%>
      <div class="grid grid-cols-3 gap-4 mb-10 max-w-lg mx-auto">
        <div class="text-center p-3 rounded-lg bg-slate-800/50 border border-slate-700">
          <div class="text-2xl font-black text-amber-400">{@level}</div>
          <div class="text-xs text-slate-500 uppercase tracking-wider">Level</div>
        </div>
        <div class="text-center p-3 rounded-lg bg-slate-800/50 border border-slate-700">
          <div class="text-2xl font-black text-emerald-400">{@completed_count}/{@total_quests}</div>
          <div class="text-xs text-slate-500 uppercase tracking-wider">Quests</div>
        </div>
        <div class="text-center p-3 rounded-lg bg-slate-800/50 border border-slate-700">
          <div class="text-2xl font-black text-red-400">{@bosses_cleared}/6</div>
          <div class="text-xs text-slate-500 uppercase tracking-wider">Bosses</div>
        </div>
      </div>

      <%!-- Zone Map --%>
      <h2 class="text-xl font-bold text-slate-200 mb-4 tracking-wider uppercase">Deck Map</h2>
      <div class="relative">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <%= for zd <- @zone_data do %>
            <.zone_card zone={zd.zone} unlocked={zd.unlocked} completion={zd.completion} />
          <% end %>
        </div>
      </div>

      <%!-- Daily Quests Link --%>
      <div class="mt-10 text-center">
        <a href="/daily" class="inline-flex items-center gap-2 px-6 py-3 rounded-lg bg-teal-500/10 border border-teal-500/30 text-teal-300 font-semibold hover:bg-teal-500/20 transition-colors">
          Daily Drills
          <span class="text-xs text-teal-400/70">+5 XP each</span>
        </a>
      </div>

      <%!-- Reset button --%>
      <div class="mt-16 text-center">
        <button
          phx-click="reset_progress"
          data-confirm="Are you sure? This will erase ALL quest progress."
          class="text-xs text-slate-600 hover:text-red-400 transition-colors"
        >
          Reset Progress
        </button>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("reset_progress", _params, socket) do
    Progress.reset_progress!()
    {:noreply, push_navigate(socket, to: "/")}
  end
end
