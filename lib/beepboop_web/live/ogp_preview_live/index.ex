defmodule BeepboopWeb.OgpPreviewLive.Index do
  use BeepboopWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <.button
        class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        phx-click="preview"
      >
        Preview
      </.button>
    </div>
    <div class="sm:flex">
      <%= if @image do %>
        <div class="mb-4 flex-shrink-0 sm:mb-0 sm:mr-4">
          <img
            src={"#{@image}"}
            class="h-32 w-full border border-gray-300 bg-white text-gray-300 object-cover object-left-top"
          />
        </div>
      <% end %>
      <div>
        <h4 class="text-lg font-bold"><%= @title %></h4>
        <p class="mt-1">
          <%= @description %>
        </p>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, title: nil, description: nil, image: nil)}
  end

  def handle_event("preview", _params, socket) do
    urls = [
      "https://github.com",
      "https://producthunt.com",
      "https://elixirforum.com"
    ]

    {:ok, result} = urls |> Enum.random() |> OpenGraph.fetch()
    {:noreply, assign(socket, Map.from_struct(result))}
  end
end
