defmodule MorkBorgWeb.WeaponLive.WeaponComponent do
  use MorkBorgWeb, :component

  def display_weapon(assigns) do
    ~H"""
    <div class="p-6 max-w-sm mx-auto bg-white rounded-xl shadow-lg flex items-center space-x-4 justify-between dark:bg-slate-900">
    <h1 class="font-bold">
    <%= @weapon.name %>
    </h1>
    <p>
    <%= @weapon.description %>
    </p>
    <p>
    <%= @weapon.damage %>
    </p>
    </div>
    """
  end
end
