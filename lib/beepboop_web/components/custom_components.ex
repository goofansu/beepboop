defmodule BeepboopWeb.CustomComponents do
  use Phoenix.Component

  attr :loading, :boolean, required: true

  def loading_indicator(assigns) do
    ~H"""
    <div :if={@loading} class="animate-pulse">
      Loading...
    </div>
    """
  end
end
