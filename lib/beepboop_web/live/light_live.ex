defmodule BeepboopWeb.LightLive do
  use BeepboopWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full border">
      <div
        style={"width: #{@brightness}%"}
        class="bg-yellow-300 transition-all duration-150 ease-in-out"
      >
        <span class="p-2">
          <%= @brightness %>%
        </span>
      </div>
    </div>

    <div class="mt-4">
      <button phx-click="on" class="border px-6 py-2">ON</button>
      <button phx-click="off" class="border px-6 py-2">OFF</button>
      <button phx-click="inc" class="border px-6 py-2">+</button>
      <button phx-click="dec" class="border px-6 py-2">-</button>
      <button phx-click="rand" class="border px-6 py-2">Light me up!</button>
    </div>
    """
  end

  def handle_event("on", _payload, socket) do
    {:noreply, assign(socket, brightness: 100)}
  end

  def handle_event("off", _payload, socket) do
    {:noreply, assign(socket, brightness: 0)}
  end

  def handle_event("inc", _payload, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}
  end

  def handle_event("dec", _payload, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}
  end

  def handle_event("rand", _payload, socket) do
    {:noreply, assign(socket, :brightness, Enum.random(0..100))}
  end
end
