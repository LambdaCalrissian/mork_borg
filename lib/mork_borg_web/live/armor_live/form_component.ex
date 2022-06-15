defmodule MorkBorgWeb.ArmorLive.FormComponent do
  use MorkBorgWeb, :live_component

  alias MorkBorg.Inventory

  @impl true
  def update(%{armor: armor} = assigns, socket) do
    changeset = Inventory.change_armor(armor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"armor" => armor_params}, socket) do
    changeset =
      socket.assigns.armor
      |> Inventory.change_armor(armor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"armor" => armor_params}, socket) do
    save_armor(socket, socket.assigns.action, armor_params)
  end

  defp save_armor(socket, :edit, armor_params) do
    case Inventory.update_armor(socket.assigns.armor, armor_params) do
      {:ok, _armor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Armor updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_armor(socket, :new, armor_params) do
    case Inventory.create_armor(armor_params) do
      {:ok, _armor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Armor created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
