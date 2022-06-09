defmodule MorkBorgWeb.CharacterLive.Show do
  use MorkBorgWeb, :live_view

  alias MorkBorg.Players

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:character, Players.get_character!(id))}
  end

  defp page_title(:show), do: "Show Character"
  defp page_title(:edit), do: "Edit Character"
end
