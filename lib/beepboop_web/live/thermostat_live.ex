defmodule BeepboopWeb.ThermostatLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use BeepboopWeb, :live_view

  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>°F <button phx-click="inc_temperature">+</button>
    """
  end

  def mount(%{"house" => house}, _session, socket) do
    # Let's assume a fixed temperature for now
    temperature = get_house_reading(house)
    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end

  defp get_house_reading("dad") do
    99
  end

  defp get_house_reading("sugar") do
    100
  end

  defp get_house_reading(_), do: 101
end
