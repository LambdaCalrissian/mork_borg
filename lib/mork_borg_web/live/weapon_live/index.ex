defmodule MorkBorgWeb.WeaponLive.Index do
  use MorkBorgWeb, :live_view

  alias MorkBorg.Inventory
  alias MorkBorg.Inventory.Weapon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :weapons, list_weapons())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Weapon")
    |> assign(:weapon, Inventory.get_weapon!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Weapon")
    |> assign(:weapon, %Weapon{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Inventory")
    |> assign(:weapon, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    weapon = Inventory.get_weapon!(id)
    {:ok, _} = Inventory.delete_weapon(weapon)

    {:noreply, assign(socket, :weapons, list_weapons())}
  end

  defp list_weapons do
    Inventory.list_weapons()
  end
end
