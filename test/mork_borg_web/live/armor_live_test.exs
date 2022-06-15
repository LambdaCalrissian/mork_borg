defmodule MorkBorgWeb.ArmorLiveTest do
  use MorkBorgWeb.ConnCase

  import Phoenix.LiveViewTest
  import MorkBorg.InventoryFixtures

  @create_attrs %{description: "some description", name: "some name", current_tier: 42, max_tier: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", current_tier: 43, max_tier: 43}
  @invalid_attrs %{description: nil, name: nil, max_tier: nil, current_tier: nil}

  defp create_armor(_) do
    armor = armor_fixture()
    %{armor: armor}
  end

  describe "Index" do
    setup [:create_armor]

    test "lists all armor", %{conn: conn, armor: armor} do
      {:ok, _index_live, html} = live(conn, Routes.armor_index_path(conn, :index))

      assert html =~ "Listing Armor"
      assert html =~ armor.description
    end

    test "saves new armor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.armor_index_path(conn, :index))

      assert index_live |> element("a", "New Armor") |> render_click() =~
               "New Armor"

      assert_patch(index_live, Routes.armor_index_path(conn, :new))

      assert index_live
             |> form("#armor-form", armor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#armor-form", armor: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.armor_index_path(conn, :index))

      assert html =~ "Armor created successfully"
      assert html =~ "some description"
    end

    test "updates armor in listing", %{conn: conn, armor: armor} do
      {:ok, index_live, _html} = live(conn, Routes.armor_index_path(conn, :index))

      assert index_live |> element("#armor-#{armor.id} a", "Edit") |> render_click() =~
               "Edit Armor"

      assert_patch(index_live, Routes.armor_index_path(conn, :edit, armor))

      assert index_live
             |> form("#armor-form", armor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#armor-form", armor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.armor_index_path(conn, :index))

      assert html =~ "Armor updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes armor in listing", %{conn: conn, armor: armor} do
      {:ok, index_live, _html} = live(conn, Routes.armor_index_path(conn, :index))

      assert index_live |> element("#armor-#{armor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#armor-#{armor.id}")
    end
  end

  describe "Show" do
    setup [:create_armor]

    test "displays armor", %{conn: conn, armor: armor} do
      {:ok, _show_live, html} = live(conn, Routes.armor_show_path(conn, :show, armor))

      assert html =~ "Show Armor"
      assert html =~ armor.description
    end

    test "updates armor within modal", %{conn: conn, armor: armor} do
      {:ok, show_live, _html} = live(conn, Routes.armor_show_path(conn, :show, armor))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Armor"

      assert_patch(show_live, Routes.armor_show_path(conn, :edit, armor))

      assert show_live
             |> form("#armor-form", armor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#armor-form", armor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.armor_show_path(conn, :show, armor))

      assert html =~ "Armor updated successfully"
      assert html =~ "some updated description"
    end
  end
end
