defmodule MorkBorgWeb.ItemLive.Show do
  use MorkBorgWeb, :live_view

  alias MorkBorg.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:item, Inventory.get_item!(id))}
  end

  defp page_title(:show), do: "Show Item"
  defp page_title(:edit), do: "Edit Item"
end
