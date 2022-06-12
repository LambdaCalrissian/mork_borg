defmodule MorkBorgWeb.CharacterLiveTest do
  use MorkBorgWeb.ConnCase

  import Phoenix.LiveViewTest
  import MorkBorg.PlayersFixtures

  @create_attrs %{
    agility: 42,
    description: "some description",
    hit_points_current: 42,
    hit_points_max: 42,
    name: "some name",
    omens: 42,
    presence: 42,
    strength: 42,
    toughness: 42
  }
  @update_attrs %{
    agility: 43,
    description: "some updated description",
    hit_points_current: 43,
    hit_points_max: 43,
    name: "some updated name",
    omens: 43,
    presence: 43,
    strength: 43,
    toughness: 43
  }
  @invalid_attrs %{
    agility: nil,
    description: nil,
    hit_points_current: nil,
    hit_points_max: nil,
    name: nil,
    omens: nil,
    presence: nil,
    strength: nil,
    toughness: nil
  }

  defp create_character(_) do
    character = character_fixture()
    %{character: character}
  end

  describe "Index" do
    setup [:create_character]

    test "lists all characters", %{conn: conn, character: character} do
      {:ok, _index_live, html} = live(conn, Routes.character_index_path(conn, :index))

      assert html =~ "Listing Characters"
      assert html =~ character.description
    end

    test "saves new character", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.character_index_path(conn, :index))

      assert index_live |> element("a", "New Character") |> render_click() =~
               "New Character"

      assert_patch(index_live, Routes.character_index_path(conn, :new))

      assert index_live
             |> form("#character-form", character: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#character-form", character: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.character_index_path(conn, :index))

      assert html =~ "Character created successfully"
      assert html =~ "some description"
    end

    test "updates character in listing", %{conn: conn, character: character} do
      {:ok, index_live, _html} = live(conn, Routes.character_index_path(conn, :index))

      assert index_live |> element("#character-#{character.id} a", "Edit") |> render_click() =~
               "Edit Character"

      assert_patch(index_live, Routes.character_index_path(conn, :edit, character))

      assert index_live
             |> form("#character-form", character: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#character-form", character: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.character_index_path(conn, :index))

      assert html =~ "Character updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes character in listing", %{conn: conn, character: character} do
      {:ok, index_live, _html} = live(conn, Routes.character_index_path(conn, :index))

      assert index_live |> element("#character-#{character.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#character-#{character.id}")
    end
  end

  describe "Show" do
    setup [:create_character]

    test "displays character", %{conn: conn, character: character} do
      {:ok, _show_live, html} = live(conn, Routes.character_show_path(conn, :show, character))

      assert html =~ "Show Character"
      assert html =~ character.description
    end

    test "updates character within modal", %{conn: conn, character: character} do
      {:ok, show_live, _html} = live(conn, Routes.character_show_path(conn, :show, character))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Character"

      assert_patch(show_live, Routes.character_show_path(conn, :edit, character))

      assert show_live
             |> form("#character-form", character: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#character-form", character: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.character_show_path(conn, :show, character))

      assert html =~ "Character updated successfully"
      assert html =~ "some updated description"
    end
  end
end
