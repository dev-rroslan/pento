defmodule PentoWeb.LightLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>

      <button phx-click="off">
      <img src={Routes.static_path(@socket, "/images/light-off.svg")} />
        <span class="sr-only">Off</span>
      </button>

      <button phx-click="down">
        <img src={Routes.static_path(@socket, "/images/down.svg")} />
        <span class="sr-only">Down</span>
      </button>

      <button phx-click="up">
        <img src={Routes.static_path(@socket, "/images/up.svg")} />
        <span class="sr-only">Up</span>
      </button>

      <button phx-click="on">
        <img src={Routes.static_path(@socket, "/images/light-on.svg")} />
        <span class="sr-only">On</span>
      </button>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _,%{assigns: %{brightness: brightness}}=socket) when brightness >= 100 do
    {:noreply, socket}
  end

  def handle_event("down", _, %{assigns: %{brightness: brightness}}=socket) when brightness <= 0 do
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end
end
