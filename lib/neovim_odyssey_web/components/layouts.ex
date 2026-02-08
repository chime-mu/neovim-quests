defmodule NeovimOdysseyWeb.Layouts do
  use NeovimOdysseyWeb, :html

  embed_templates "layouts/*"

  alias NeovimOdyssey.Progress

  attr :flash, :map, required: true
  attr :current_scope, :map, default: nil
  slot :inner_block, required: true

  def app(assigns) do
    xp = Progress.total_xp()
    level = Progress.current_level(xp)
    level_info = Progress.xp_for_next_level(xp)
    title = Progress.level_title(level)

    assigns =
      assigns
      |> assign(:xp, xp)
      |> assign(:level, level)
      |> assign(:level_info, level_info)
      |> assign(:title, title)

    ~H"""
    <header class="sticky top-0 z-40 bg-slate-900/95 backdrop-blur border-b border-slate-800">
      <div class="max-w-5xl mx-auto px-4 py-3 flex items-center gap-4">
        <a href="/" class="flex items-center gap-2 flex-shrink-0 hover:opacity-80 transition-opacity">
          <span class="text-xl">🚀</span>
          <span class="font-black text-slate-200 tracking-tight hidden sm:inline">The Meridian</span>
        </a>

        <div class="flex-1 max-w-xs">
          <div class="flex items-center gap-2">
            <span class="text-xs text-amber-400 font-bold whitespace-nowrap">
              Lv.{@level} {@title}
            </span>
            <div class="flex-1 h-2 bg-slate-700 rounded-full overflow-hidden">
              <div
                class="h-full bg-gradient-to-r from-amber-600 to-amber-400 rounded-full transition-all duration-1000"
                style={"width: #{trunc(@level_info.progress * 100)}%"}
              />
            </div>
            <span class="text-xs text-slate-500 whitespace-nowrap">{@xp} XP</span>
          </div>
        </div>

        <nav class="flex items-center gap-2">
          <a href="/" class="text-sm text-slate-400 hover:text-slate-200 transition-colors px-2 py-1">Map</a>
          <a href="/daily" class="text-sm text-slate-400 hover:text-slate-200 transition-colors px-2 py-1">Daily</a>
        </nav>
      </div>
    </header>

    <main>
      {render_slot(@inner_block)}
    </main>

    <.flash_group flash={@flash} />
    """
  end

  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end
end
