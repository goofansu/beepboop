defmodule BeepboopWeb.SearchLive do
  use BeepboopWeb, :live_view

  alias Beepboop.Vehicles

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        search: nil,
        vehicles: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <form phx-submit="search">
      <input type="text" name="term" />
      <input type="submit" value="Search" />
    </form>

    <div :if={@loading} class="animate-pulse">
      Loading...
    </div>

    <table :if={@vehicles}>
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

  def handle_info({:run_search, term}, socket) do
    vehicles = Vehicles.search(term)

    socket =
      assign(socket,
        loading: false,
        vehicles: vehicles
      )

    {:noreply, socket}
  end
end
