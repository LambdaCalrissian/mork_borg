defmodule MorkBorgWeb.ItemLive.Index do
  use MorkBorgWeb, :live_view

  alias MorkBorg.Inventory
  alias MorkBorg.Inventory.Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :item_collection, list_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item")
    |> assign(:item, Inventory.get_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Item")
    |> assign(:item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Inventory.get_item!(id)
    {:ok, _} = Inventory.delete_item(item)

    {:noreply, assign(socket, :item_collection, list_items())}
  end

  defp list_items do
    Inventory.list_items()
  end
end
