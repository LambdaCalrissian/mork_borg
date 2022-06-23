defmodule MorkBorgWeb.LocaleLive.Show do
  use MorkBorgWeb, :live_view

  alias MorkBorg.World

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:locale, World.get_locale!(id))}
  end

  defp page_title(:show), do: "Show Locale"
  defp page_title(:edit), do: "Edit Locale"
end
