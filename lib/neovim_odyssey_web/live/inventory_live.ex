defmodule NeovimOdysseyWeb.InventoryLive do
  use NeovimOdysseyWeb, :live_view

  alias NeovimOdyssey.{Quests, Progress}

  @impl true
  def mount(_params, _session, socket) do
    zones = Quests.list_zones()
    completed_ids = Progress.completed_quest_ids() |> MapSet.new()

    # Collect loot from all quests, grouped by zone
    inventory =
      zones
      |> Enum.map(fn zone ->
        all_quests = zone.quests ++ zone.side_quests ++ if(zone.boss, do: [zone.boss], else: [])

        items =
          all_quests
          |> Enum.filter(fn q -> q.loot != nil end)
          |> Enum.map(fn q ->
            %{
              quest: q,
              unlocked: MapSet.member?(completed_ids, q.id),
              loot: q.loot
            }
          end)

        %{zone: zone, items: items}
      end)
      |> Enum.filter(fn %{items: items} -> items != [] end)

    socket =
      socket
      |> assign(:page_title, "Inventory")
      |> assign(:inventory, inventory)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-3xl mx-auto px-4 py-8">
      <div class="mb-6">
        <a href="/" class="text-sm text-slate-400 hover:text-slate-200 transition-colors">
          ← Back to Deck Map
        </a>
      </div>

      <h1 class="text-3xl font-black text-slate-100 mb-2">Spellbook</h1>
      <p class="text-slate-400 mb-8">Config snippets earned from completed quests. Click to copy.</p>

      <%= for %{zone: zone, items: items} <- @inventory do %>
        <div class="mb-8">
          <h2 class="text-lg font-bold text-slate-200 mb-4 flex items-center gap-2">
            <span>{zone.icon}</span>
            <span>{zone.name}</span>
          </h2>

          <div class="space-y-3">
            <%= for item <- items do %>
              <%= if item.unlocked do %>
                <div class="rounded-lg border border-slate-700/50 bg-slate-800/80 p-4">
                  <div class="flex items-center justify-between mb-2">
                    <div>
                      <span class="text-sm font-bold text-amber-400">{item.loot.name}</span>
                      <span class="text-xs text-slate-500 ml-2">from {item.quest.name}</span>
                    </div>
                    <button
                      phx-hook="CopyToClipboard"
                      id={"copy-#{item.quest.id}"}
                      data-snippet={item.loot.snippet}
                      class="text-xs text-slate-400 hover:text-slate-200 transition-colors px-2 py-1 rounded border border-slate-700 hover:border-slate-500"
                    >
                      Copy
                    </button>
                  </div>
                  <p class="text-xs text-slate-500 mb-2">{item.loot.description}</p>
                  <pre class="text-xs text-emerald-300 bg-slate-900/80 rounded p-3 overflow-x-auto"><code>{item.loot.snippet}</code></pre>
                </div>
              <% else %>
                <div class="rounded-lg border border-slate-700/30 bg-slate-800/40 p-4 opacity-50">
                  <div class="flex items-center gap-2">
                    <span class="text-slate-600">🔒</span>
                    <span class="text-sm text-slate-600">Complete "{item.quest.name}" to unlock</span>
                  </div>
                </div>
              <% end %>
            <% end %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
