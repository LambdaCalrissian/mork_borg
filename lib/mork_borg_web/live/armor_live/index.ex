defmodule MorkBorgWeb.ArmorLive.Index do
  use MorkBorgWeb, :live_view

  alias MorkBorg.Inventory
  alias MorkBorg.Inventory.Armor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :armor_collection, list_armor())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Armor")
    |> assign(:armor, Inventory.get_armor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Armor")
    |> assign(:armor, %Armor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Armor")
    |> assign(:armor, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    armor = Inventory.get_armor!(id)
    {:ok, _} = Inventory.delete_armor(armor)

    {:noreply, assign(socket, :armor_collection, list_armor())}
  end

  defp list_armor do
    Inventory.list_armor()
  end
end
