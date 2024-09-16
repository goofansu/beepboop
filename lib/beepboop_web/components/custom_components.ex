defmodule BeepboopWeb.CustomComponents do
  use Phoenix.Component

  attr :visible, :boolean, required: true

  def loading_indicator(assigns) do
    ~H"""
    <div :if={@visible} class="animate-pulse">
      <div class="w-12 h-12 rounded-full absolute border-8 border-gray-300"></div>
      <div class="w-12 h-12 rounded-full absolute border-8 border-indigo-400 border-t-transparent animate-spin">
      </div>
    </div>
    """
  end
end
