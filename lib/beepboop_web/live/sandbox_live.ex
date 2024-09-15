defmodule BeepboopWeb.SandboxLive do
  use BeepboopWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        length: "0",
        width: "0",
        depth: "0",
        weight: 0.0,
        price: nil
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <form phx-change="calculate-weight" phx-submit="calculate-price">
      <div>
        Length: <input type="number" name="length" value={@length} />
      </div>

      <div>
        Width: <input type="number" name="width" value={@width} />
      </div>

      <div>
        Depth: <input type="number" name="depth" value={@depth} />
      </div>

      <div>
        Weight: <%= @weight %>
      </div>

      <input type="submit" value="Get Quota" />

      <div :if={@price}>
        Price: <%= @price %>
      </div>
    </form>
    """
  end

  @doc """
  price: %{
  "_target" => ["length"],
  "_unused_depth" => "",
  "_unused_width" => "",
  "depth" => "0",
  "length" => "1",
  "width" => "0"
  }
  """
  def handle_event("calculate-weight", params, socket) do
    IO.inspect(params, label: "params")

    %{"length" => length, "width" => width, "depth" => depth} = params
    weight = calculate_weight(width, length, depth)

    socket =
      assign(socket,
        weight: weight,
        length: length,
        width: width,
        depth: depth,
        price: nil
      )

    {:noreply, socket}
  end

  def handle_event("calculate-price", params, socket) do
    IO.inspect(params, label: "params")

    price = calculate_price(socket.assigns.weight)

    {:noreply, assign(socket, :price, price)}
  end

  def calculate_weight(length, width, depth) do
    (to_float(length) * to_float(width) * to_float(depth) * 7.1) |> Float.round(1)
  end

  def calculate_price(weight) do
    weight * 0.15
  end

  def to_float(binary) when is_binary(binary) do
    case Float.parse(binary) do
      {float, _} -> float
      :error -> 0.0
    end
  end
end
