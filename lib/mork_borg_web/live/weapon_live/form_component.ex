defmodule MorkBorgWeb.WeaponLive.FormComponent do
  use MorkBorgWeb, :live_component

  alias MorkBorg.Inventory

  @impl true
  def update(%{weapon: weapon} = assigns, socket) do
    changeset = Inventory.change_weapon(weapon)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"weapon" => weapon_params}, socket) do
    changeset =
      socket.assigns.weapon
      |> Inventory.change_weapon(weapon_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"weapon" => weapon_params}, socket) do
    save_weapon(socket, socket.assigns.action, weapon_params)
  end

  defp save_weapon(socket, :edit, weapon_params) do
    case Inventory.update_weapon(socket.assigns.weapon, weapon_params) do
      {:ok, _weapon} ->
        {:noreply,
         socket
         |> put_flash(:info, "Weapon updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_weapon(socket, :new, weapon_params) do
    case Inventory.create_weapon(weapon_params) do
      {:ok, _weapon} ->
        {:noreply,
         socket
         |> put_flash(:info, "Weapon created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
