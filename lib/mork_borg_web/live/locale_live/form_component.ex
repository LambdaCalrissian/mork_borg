defmodule MorkBorgWeb.LocaleLive.FormComponent do
  use MorkBorgWeb, :live_component

  alias MorkBorg.World

  @impl true
  def update(%{locale: locale} = assigns, socket) do
    changeset = World.change_locale(locale)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"locale" => locale_params}, socket) do
    changeset =
      socket.assigns.locale
      |> World.change_locale(locale_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"locale" => locale_params}, socket) do
    save_locale(socket, socket.assigns.action, locale_params)
  end

  defp save_locale(socket, :edit, locale_params) do
    case World.update_locale(socket.assigns.locale, locale_params) do
      {:ok, _locale} ->
        {:noreply,
         socket
         |> put_flash(:info, "Locale updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_locale(socket, :new, locale_params) do
    case World.create_locale(locale_params) do
      {:ok, _locale} ->
        {:noreply,
         socket
         |> put_flash(:info, "Locale created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
