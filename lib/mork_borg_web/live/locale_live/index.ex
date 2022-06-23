defmodule MorkBorgWeb.LocaleLive.Index do
  use MorkBorgWeb, :live_view

  alias MorkBorg.World
  alias MorkBorg.World.Locale

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :locales, list_locales())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Locale")
    |> assign(:locale, World.get_locale!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Locale")
    |> assign(:locale, %Locale{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Locales")
    |> assign(:locale, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    locale = World.get_locale!(id)
    {:ok, _} = World.delete_locale(locale)

    {:noreply, assign(socket, :locales, list_locales())}
  end

  defp list_locales do
    World.list_locales()
  end
end
