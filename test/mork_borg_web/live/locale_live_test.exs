defmodule MorkBorgWeb.LocaleLiveTest do
  use MorkBorgWeb.ConnCase

  import Phoenix.LiveViewTest
  import MorkBorg.WorldFixtures

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp create_locale(_) do
    locale = locale_fixture()
    %{locale: locale}
  end

  describe "Index" do
    setup [:create_locale]

    test "lists all locales", %{conn: conn, locale: locale} do
      {:ok, _index_live, html} = live(conn, Routes.locale_index_path(conn, :index))

      assert html =~ "Listing Locales"
      assert html =~ locale.description
    end

    test "saves new locale", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.locale_index_path(conn, :index))

      assert index_live |> element("a", "New Locale") |> render_click() =~
               "New Locale"

      assert_patch(index_live, Routes.locale_index_path(conn, :new))

      assert index_live
             |> form("#locale-form", locale: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#locale-form", locale: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.locale_index_path(conn, :index))

      assert html =~ "Locale created successfully"
      assert html =~ "some description"
    end

    test "updates locale in listing", %{conn: conn, locale: locale} do
      {:ok, index_live, _html} = live(conn, Routes.locale_index_path(conn, :index))

      assert index_live |> element("#locale-#{locale.id} a", "Edit") |> render_click() =~
               "Edit Locale"

      assert_patch(index_live, Routes.locale_index_path(conn, :edit, locale))

      assert index_live
             |> form("#locale-form", locale: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#locale-form", locale: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.locale_index_path(conn, :index))

      assert html =~ "Locale updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes locale in listing", %{conn: conn, locale: locale} do
      {:ok, index_live, _html} = live(conn, Routes.locale_index_path(conn, :index))

      assert index_live |> element("#locale-#{locale.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#locale-#{locale.id}")
    end
  end

  describe "Show" do
    setup [:create_locale]

    test "displays locale", %{conn: conn, locale: locale} do
      {:ok, _show_live, html} = live(conn, Routes.locale_show_path(conn, :show, locale))

      assert html =~ "Show Locale"
      assert html =~ locale.description
    end

    test "updates locale within modal", %{conn: conn, locale: locale} do
      {:ok, show_live, _html} = live(conn, Routes.locale_show_path(conn, :show, locale))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Locale"

      assert_patch(show_live, Routes.locale_show_path(conn, :edit, locale))

      assert show_live
             |> form("#locale-form", locale: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#locale-form", locale: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.locale_show_path(conn, :show, locale))

      assert html =~ "Locale updated successfully"
      assert html =~ "some updated description"
    end
  end
end
