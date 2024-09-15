defmodule BeepboopWeb.SearchLive do
  use BeepboopWeb, :live_view

  alias Beepboop.Vehicles

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        search: nil,
        vehicles: [],
        loading: false,
        suggestions: []
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <form phx-submit="search" phx-change="suggest">
      <input type="text" name="term" list="suggestions" phx-debounce="1000" />
      <input type="submit" value="Search" />
    </form>

    <datalist id="suggestions">
      <option :for={suggestion <- @suggestions} value={suggestion}>
        <%= suggestion %>
      </option>
    </datalist>

    <div :if={@loading} class="animate-pulse">
      Loading...
    </div>

    <table :if={@vehicles} class="border-1">
      <tr :for={v <- @vehicles}>
        <td>
          <%= v.make_model %>
        </td>
        <td>
          <%= v.color %>
        </td>
        <td>
          <%= v.status %>
        </td>
      </tr>
    </table>
    """
  end

  def handle_event("search", %{"term" => term}, socket) do
    Process.send_after(self(), {:run_search, term}, 3000)

    socket =
      assign(socket,
        term: term,
        loading: true
      )

    {:noreply, socket}
  end

  def handle_event("suggest", %{"term" => term}, socket) do
    suggestions = Vehicles.suggest(term) |> IO.inspect(label: "suggestions")

    socket =
      assign(socket,
        term: term,
        suggestions: suggestions
      )

    {:noreply, socket}
  end

  def handle_info({:run_search, term}, socket) do
    vehicles = Vehicles.search(term) |> IO.inspect(label: "vehicles")

    socket =
      assign(socket,
        loading: false,
        vehicles: vehicles
      )

    {:noreply, socket}
  end
end
