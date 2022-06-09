defmodule MorkBorgWeb.CharacterLive.Index do
  use MorkBorgWeb, :live_view

  alias MorkBorg.Players
  alias MorkBorg.Players.Character

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :characters, list_characters())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Character")
    |> assign(:character, Players.get_character!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Character")
    |> assign(:character, %Character{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Characters")
    |> assign(:character, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    character = Players.get_character!(id)
    {:ok, _} = Players.delete_character(character)

    {:noreply, assign(socket, :characters, list_characters())}
  end

  defp list_characters do
    Players.list_characters()
  end
end
