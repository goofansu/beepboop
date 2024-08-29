defmodule BeepboopWeb.OgpLive do
  use BeepboopWeb, :live_view

  alias Phoenix.LiveView.AsyncResult

  def render(assigns) do
    ~H"""
    <form phx-submit="submit_url">
      <div class="flex-grow flex items-center border rounded-l overflow-hidden">
        <span class="bg-gray-100 text-gray-500 px-3 py-2 h-full flex items-center">https://</span>
        <input
          type="text"
          name="url"
          value={@url}
          placeholder="github.com"
          phx-debounce="300"
          class="flex-grow px-3 py-2 focus:outline-none"
          disabled={@loading}
        />
      </div>
    </form>

    <div class="mt-10 sm:flex">
      <.async_result :let={result} assign={@result}>
        <:loading>Fetching...</:loading>
        <:failed :let={failure}><%= failure %></:failed>

        <%= if result != nil do %>
          <%= if result.image do %>
            <div class="mb-4 flex-shrink-0 sm:mb-0 sm:mr-4">
              <img
                src={result.image}
                class="h-32 w-full border border-gray-300 bg-white text-gray-300 object-cover object-left-top"
              />
            </div>
          <% end %>
          <div>
            <h4 class="text-lg font-bold"><%= result.title %></h4>
            <p class="mt-1"><%= result.description %></p>
          </div>
        <% end %>
      </.async_result>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:url, nil)
     |> assign(:loading, false)
     |> assign(:result, AsyncResult.ok(nil))}
  end

  def handle_event("submit_url", %{"url" => url}, socket) do
    case URI.new(url) do
      {:ok, _} ->
        {:noreply,
         socket
         |> assign(:url, url)
         |> assign(:loading, true)
         |> assign(:result, AsyncResult.loading())
         |> start_async(:fetch_url, fn -> OpenGraph.fetch!("https://" <> url) end)}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Please enter a valid URL.")}
    end
  end

  def handle_async(:fetch_url, {:ok, %{title: nil}}, socket) do
    {:noreply,
     socket
     |> assign(:loading, false)
     |> assign(:result, AsyncResult.ok(nil))
     |> put_flash(:error, "Open Graph information not found.")}
  end

  def handle_async(:fetch_url, {:ok, result}, socket) do
    {:noreply,
     socket
     |> assign(:loading, false)
     |> assign(:result, AsyncResult.ok(result))}
  end

  def handle_async(:fetch_url, {:exit, error}, socket) do
    {%OpenGraph.Error{reason: {_, reason}}, _} = error

    {:noreply,
     socket
     |> assign(:loading, false)
     |> assign(:result, AsyncResult.ok(nil))
     |> put_flash(:error, reason)}
  end
end
