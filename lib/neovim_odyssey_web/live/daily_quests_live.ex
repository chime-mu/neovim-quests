defmodule NeovimOdysseyWeb.DailyQuestsLive do
  use NeovimOdysseyWeb, :live_view

  alias NeovimOdyssey.{Quests, Progress}

  @impl true
  def mount(_params, _session, socket) do
    daily_quests = Quests.list_daily_quests()

    quest_data =
      Enum.map(daily_quests, fn quest ->
        %{quest: quest, done_today: Progress.daily_quest_done_today?(quest.id)}
      end)

    socket =
      socket
      |> assign(:page_title, "Daily Quests")
      |> assign(:quest_data, quest_data)
      |> assign(:xp_flash, nil)
      |> assign(:level_up, nil)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto px-4 py-8">
      <%!-- XP flash --%>
      <%= if @xp_flash do %>
        <.xp_gain_flash xp={@xp_flash} id={"xp-flash-#{System.unique_integer([:positive])}"} />
      <% end %>

      <%!-- Level up overlay --%>
      <.level_up_overlay
        show={@level_up != nil}
        new_level={if @level_up, do: @level_up.new_level, else: 1}
        title={if @level_up, do: Progress.level_title(@level_up.new_level), else: ""}
      />

      <%!-- Back link --%>
      <a href="/" class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-300 mb-6 transition-colors">
        ← Back to Deck Map
      </a>

      <div class="mb-6">
        <h1 class="text-2xl font-black text-slate-100 flex items-center gap-2">
          📋 Daily Drills
        </h1>
        <p class="text-sm text-slate-400 mt-1">Repeatable drills to build muscle memory. Resets each shift.</p>
      </div>

      <div class="space-y-3">
        <%= for qd <- @quest_data do %>
          <div class={"rounded-lg border p-5 transition-all " <>
            if(qd.done_today,
              do: "border-teal-500/30 bg-teal-500/5",
              else: "border-slate-700 bg-slate-800/50"
            )}>
            <div class="flex items-start justify-between mb-3">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-1">
                  <h3 class={"font-bold " <> if(qd.done_today, do: "text-teal-300", else: "text-slate-200")}>
                    {qd.quest.name}
                  </h3>
                  <.quest_type_badge type={:daily} />
                </div>
                <p class="text-sm text-slate-400">{qd.quest.description}</p>
              </div>
              <span class={"text-sm font-bold ml-4 " <> if(qd.done_today, do: "text-teal-400", else: "text-amber-400")}>
                +{qd.quest.xp} XP
              </span>
            </div>

            <%!-- Turn-in --%>
            <p class="text-xs text-slate-500 mb-3 italic">{qd.quest.turn_in}</p>

            <%= if qd.done_today do %>
              <div class="text-center py-1">
                <span class="text-teal-400 font-semibold text-sm">✓ Done Today</span>
              </div>
            <% else %>
              <button
                phx-click="complete_daily"
                phx-value-quest-id={qd.quest.id}
                class="w-full py-2 px-4 rounded-lg font-semibold text-sm transition-all duration-200
                       bg-teal-500/10 border border-teal-500/30 text-teal-300
                       hover:bg-teal-500/20 hover:border-teal-400/50 active:scale-[0.98]"
              >
                Complete
              </button>
            <% end %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("complete_daily", %{"quest-id" => quest_id}, socket) do
    case Progress.complete_daily_quest(quest_id) do
      {:ok, _record, result} ->
        # Restore HP on daily quest completion
        Progress.restore_hp()

        quest_data =
          Enum.map(socket.assigns.quest_data, fn qd ->
            if qd.quest.id == quest_id do
              %{qd | done_today: true}
            else
              qd
            end
          end)

        socket =
          socket
          |> assign(:quest_data, quest_data)
          |> assign(:xp_flash, result.xp_gained)

        socket =
          if result.leveled_up do
            assign(socket, :level_up, result)
          else
            socket
          end

        {:noreply, socket}

      {:error, :already_done_today} ->
        quest_data =
          Enum.map(socket.assigns.quest_data, fn qd ->
            if qd.quest.id == quest_id, do: %{qd | done_today: true}, else: qd
          end)

        {:noreply, assign(socket, :quest_data, quest_data)}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Something went wrong.")}
    end
  end

  @impl true
  def handle_event("dismiss_level_up", _params, socket) do
    {:noreply, assign(socket, :level_up, nil)}
  end
end
