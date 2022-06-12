defmodule MorkBorgWeb.WeaponLive.WeaponComponent do
  use MorkBorgWeb, :component

  def display_weapon(assigns) do
    ~H"""
    <div class="p-6 max-w-sm mx-auto bg-white rounded-xl shadow-lg flex items-center space-x-4 justify-between">
    <h1 class="text-xl text-black text-semibold">
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
