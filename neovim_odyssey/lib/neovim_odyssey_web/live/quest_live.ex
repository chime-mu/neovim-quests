defmodule NeovimOdysseyWeb.QuestLive do
  use NeovimOdysseyWeb, :live_view

  alias NeovimOdyssey.{Quests, Progress}

  @zone_button_styles %{
    1 => "bg-amber-500/20 border-amber-500/40 text-amber-300 hover:bg-amber-500/30 hover:border-amber-400/60 hover:shadow-amber-500/10",
    2 => "bg-emerald-500/20 border-emerald-500/40 text-emerald-300 hover:bg-emerald-500/30 hover:border-emerald-400/60 hover:shadow-emerald-500/10",
    3 => "bg-sky-500/20 border-sky-500/40 text-sky-300 hover:bg-sky-500/30 hover:border-sky-400/60 hover:shadow-sky-500/10",
    4 => "bg-yellow-500/20 border-yellow-500/40 text-yellow-300 hover:bg-yellow-500/30 hover:border-yellow-400/60 hover:shadow-yellow-500/10",
    5 => "bg-rose-500/20 border-rose-500/40 text-rose-300 hover:bg-rose-500/30 hover:border-rose-400/60 hover:shadow-rose-500/10",
    6 => "bg-violet-500/20 border-violet-500/40 text-violet-300 hover:bg-violet-500/30 hover:border-violet-400/60 hover:shadow-violet-500/10"
  }

  @zone_card_borders %{
    1 => "border-amber-500/20",
    2 => "border-emerald-500/20",
    3 => "border-sky-500/20",
    4 => "border-yellow-500/20",
    5 => "border-rose-500/20",
    6 => "border-violet-500/20"
  }

  @impl true
  def mount(%{"quest_id" => quest_id}, _session, socket) do
    quest = Quests.get_quest(quest_id)

    if is_nil(quest) do
      {:ok, push_navigate(socket, to: "/")}
    else
      zone = Quests.get_zone(quest.zone_id)
      completed = Progress.quest_completed?(quest_id)
      zone_number = if zone, do: zone.number, else: 1
      btn_style = Map.get(@zone_button_styles, zone_number, @zone_button_styles[1])
      card_border = Map.get(@zone_card_borders, zone_number, @zone_card_borders[1])

      socket =
        socket
        |> assign(:page_title, quest.name)
        |> assign(:quest, quest)
        |> assign(:zone, zone)
        |> assign(:completed, completed)
        |> assign(:zone_number, zone_number)
        |> assign(:btn_style, btn_style)
        |> assign(:card_border, card_border)
        |> assign(:xp_flash, nil)
        |> assign(:level_up, nil)

      {:ok, socket}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto px-4 py-8">
      <%!-- XP flash animation --%>
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
      <a
        href={if @zone, do: "/zones/#{@zone.number}", else: "/"}
        class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-300 mb-6 transition-colors"
      >
        ← Back to {if @zone, do: @zone.name, else: "Map"}
      </a>

      <%!-- Quest Card --%>
      <div class={[
        "rounded-xl border-2 p-6",
        if(@completed, do: "border-emerald-500/30 bg-emerald-500/5", else: [@card_border, "bg-slate-800/80"])
      ]}>

        <%!-- Header --%>
        <div class="flex items-start justify-between mb-4">
          <div>
            <div class="flex items-center gap-2 mb-1">
              <.quest_type_badge type={@quest.type} />
              <span class="text-xs text-slate-500">Quest {@quest.number}</span>
            </div>
            <h1 class="text-2xl font-black text-slate-100">{@quest.name}</h1>
          </div>
          <div class={[
            "text-xl font-black",
            if(@completed, do: "text-emerald-400", else: "text-amber-400")
          ]}>
            +{@quest.xp} XP
          </div>
        </div>

        <%!-- NPC Greeting --%>
        <%= if @quest.npc_greeting do %>
          <div class="border-l-2 border-amber-500/30 bg-amber-500/5 rounded-r-lg pl-4 pr-4 py-3 mb-6">
            <%= if @zone && @zone.npc do %>
              <p class="text-xs font-bold text-amber-400/70 mb-1">{@zone.npc}</p>
            <% end %>
            <p class="text-sm text-slate-300 italic">"{@quest.npc_greeting}"</p>
          </div>
        <% end %>

        <%!-- Description --%>
        <p class="text-slate-300 mb-6">{@quest.description}</p>

        <%!-- Objectives --%>
        <div class="mb-6">
          <h3 class="text-xs font-bold text-slate-400 tracking-wider uppercase mb-2">Objectives</h3>
          <ul class="space-y-1.5">
            <%= for objective <- @quest.objectives do %>
              <li class="flex items-start gap-2 text-sm">
                <span class={if @completed, do: "text-emerald-400", else: "text-slate-600"}>
                  {if @completed, do: "✓", else: "○"}
                </span>
                <span class={if @completed, do: "text-emerald-300", else: "text-slate-300"}>
                  {objective}
                </span>
              </li>
            <% end %>
          </ul>
        </div>

        <%!-- Turn-in / NPC Confirmation --%>
        <div class={[
          "rounded-lg p-4 mb-6",
          if(@completed,
            do: "bg-emerald-500/10 border border-emerald-500/20",
            else: "bg-slate-700/50 border border-slate-600/50"
          )
        ]}>
          <%= if @completed && @quest.npc_confirmation do %>
            <%!-- Show NPC confirmation when complete --%>
            <%= if @zone && @zone.npc do %>
              <p class="text-xs font-bold text-emerald-400/70 mb-1">{@zone.npc}</p>
            <% end %>
            <p class="text-sm text-emerald-300 italic">"{@quest.npc_confirmation}"</p>
          <% else %>
            <h3 class="text-xs font-bold text-slate-400 tracking-wider uppercase mb-1">Turn-in</h3>
            <p class={["text-sm", if(@completed, do: "text-emerald-300", else: "text-slate-300")]}>
              {@quest.turn_in}
            </p>
          <% end %>
        </div>

        <%!-- Complete button --%>
        <%= if @completed do %>
          <div class="text-center py-3">
            <span class="text-emerald-400 font-bold text-lg">✓ Quest Complete</span>
          </div>
        <% else %>
          <button
            phx-click="complete_quest"
            class={[
              "w-full py-3 px-6 rounded-lg font-bold text-lg transition-all duration-200 border-2 hover:shadow-lg active:scale-[0.98]",
              @btn_style
            ]}
          >
            Complete Quest
          </button>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("complete_quest", _params, socket) do
    case Progress.complete_quest(socket.assigns.quest.id) do
      {:ok, _record, result} ->
        socket =
          socket
          |> assign(:completed, true)
          |> assign(:xp_flash, result.xp_gained)

        socket =
          if result.leveled_up do
            assign(socket, :level_up, result)
          else
            socket
          end

        {:noreply, socket}

      {:error, :already_completed} ->
        {:noreply, assign(socket, :completed, true)}

      {:error, :zone_locked} ->
        {:noreply, put_flash(socket, :error, "This zone is locked!")}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Something went wrong.")}
    end
  end

  @impl true
  def handle_event("dismiss_level_up", _params, socket) do
    {:noreply, assign(socket, :level_up, nil)}
  end
end
