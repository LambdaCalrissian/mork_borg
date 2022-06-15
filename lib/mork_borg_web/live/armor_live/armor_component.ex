defmodule MorkBorgWeb.ArmorLive.ArmorComponent do

  use MorkBorgWeb, :component

  def display_armor(assigns) do
    ~H"""
    <div class="p-6 max-w-sm mx-auto bg-white rounded-xl shadow-lg flex items-center space-x-4 justify-between dark:bg-slate-900">
    <h1 class="font-bold">
    <%= @armor.name %>
    </h1>
    <p class="font-light">
    <%= @armor.description %>
    </p>
    <div class="flex flex-col h-16 w-8 content-center text-center justify-center border rounded-md">
    <p class="border-b"> <%= @armor.current_tier %> </p>
    <p> <%= @armor.max_tier %> </p>
    </div>
    </div>
    """
  end
end
