defmodule MorkBorgWeb.WeaponLive.WeaponComponent do
  use MorkBorgWeb, :component

  def display_weapon(assigns) do
    ~H"""
    <ul>

    <li>
    <strong>Name:</strong>
    <%= @weapon.name %>
    </li>

    <li>
    <strong>Description:</strong>
    <%= @weapon.description %>
    </li>

    <li>
    <strong>Damage:</strong>
    <%= @weapon.damage %>
    </li>

    </ul>
    """
  end
end
