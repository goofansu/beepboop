defmodule BeepboopWeb.LightLive do
  use BeepboopWeb, :live_view

  @initial_brightness 50
  @initial_temp "3000"

  def mount(_params, _session, socket) do
    IO.inspect(self(), label: "mount")
    IO.inspect(connected?(socket), label: "mount")

    socket =
      assign(socket,
        brightness: @initial_brightness,
        temp: @initial_temp,
        bgcolor: temp_color(@initial_temp)
      )

    {:ok, socket}
  end

  def render(assigns) do
    IO.inspect(self(), label: "render")

    ~H"""
    <div class="w-full border">
      <div
        style={"width: #{@brightness}%; background-color: #{@bgcolor}"}
        class="w-full border transition-all duration-150 ease-in-out"
      >
        <span class="p-2">
          <%= @brightness %>%
        </span>
      </div>
    </div>

    <form phx-change="slide">
      <input type="range" min="0" max="100" name="brightness" value={@brightness} />
    </form>

    <div class="mt-4">
      <button phx-click="on" class="border px-6 py-2">ON</button>
      <button phx-click="off" class="border px-6 py-2">OFF</button>
      <button phx-click="inc" class="border px-6 py-2">+</button>
      <button phx-click="dec" class="border px-6 py-2">-</button>
      <button phx-click="rand" class="border px-6 py-2">Light me up!</button>
    </div>

    <form phx-change="select-temp">
      <div class="temps">
        <%= for temp <- ["3000", "4000", "5000"] do %>
          <div>
            <input type="radio" id={temp} name="temp" value={temp} checked={temp == @temp} />
            <label for={temp}><%= temp %></label>
          </div>
        <% end %>
      </div>
    </form>
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
    # raise "🔥"
    {:noreply, assign(socket, :brightness, Enum.random(0..100))}
  end

  def handle_event("slide", params, socket) do
    %{"brightness" => brightness} = params
    {:noreply, assign(socket, :brightness, String.to_integer(brightness))}
  end

  def handle_event("select-temp", params, socket) do
    IO.inspect(params, label: "params")
    %{"temp" => temp} = params
    bgcolor = temp_color(temp)
    socket = assign(socket, bgcolor: bgcolor, temp: temp)
    {:noreply, socket}
  end

  defp temp_color("3000"), do: "#F1C40D"
  defp temp_color("4000"), do: "#FEFF66"
  defp temp_color("5000"), do: "#99CCFF"
end
