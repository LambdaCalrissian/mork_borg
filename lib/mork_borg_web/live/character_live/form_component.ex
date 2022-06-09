defmodule MorkBorgWeb.CharacterLive.FormComponent do
  use MorkBorgWeb, :live_component

  alias MorkBorg.Players

  @impl true
  def update(%{character: character} = assigns, socket) do
    changeset = Players.change_character(character)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"character" => character_params}, socket) do
    changeset =
      socket.assigns.character
      |> Players.change_character(character_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"character" => character_params}, socket) do
    save_character(socket, socket.assigns.action, character_params)
  end

  defp save_character(socket, :edit, character_params) do
    case Players.update_character(socket.assigns.character, character_params) do
      {:ok, _character} ->
        {:noreply,
         socket
         |> put_flash(:info, "Character updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_character(socket, :new, character_params) do
    case Players.create_character(character_params) do
      {:ok, _character} ->
        {:noreply,
         socket
         |> put_flash(:info, "Character created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
