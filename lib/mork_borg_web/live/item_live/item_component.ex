defmodule MorkBorgWeb.ItemLive.ItemComponent do
  use MorkBorgWeb, :component

  def display_item(assigns) do
    ~H"""
    <div class="p-4 m-4 max-w-sm mx-auto bg-white rounded-xl shadow-lg dark:bg-slate-900">
    <div>
    <span class="font-bold">
    <%= @item.name %>
    </span>
    <span class="font-extralight">
    <%= @item.description %>
    </span>
    </div>
    <div>
    <p>
    <%= @item.count %>
    </p>
    </div>
    </div>
    """
  end
end
