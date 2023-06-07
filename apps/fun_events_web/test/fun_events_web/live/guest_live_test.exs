defmodule FunEventsWeb.GuestLiveTest do
  use FunEventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import FunEvents.GuestsFixtures

  @create_attrs %{adult_confirmed: 42, adult_max: 42, date_response: "2023-06-05T19:48:00Z", event_id: 42, last_name: "some last_name", last_notification_date: "2023-06-05T19:48:00Z", minor_confirmed: 42, minor_max: 42, name: "some name", state: "some state"}
  @update_attrs %{adult_confirmed: 43, adult_max: 43, date_response: "2023-06-06T19:48:00Z", event_id: 43, last_name: "some updated last_name", last_notification_date: "2023-06-06T19:48:00Z", minor_confirmed: 43, minor_max: 43, name: "some updated name", state: "some updated state"}
  @invalid_attrs %{adult_confirmed: nil, adult_max: nil, date_response: nil, event_id: nil, last_name: nil, last_notification_date: nil, minor_confirmed: nil, minor_max: nil, name: nil, state: nil}

  defp create_guest(_) do
    guest = guest_fixture()
    %{guest: guest}
  end

  describe "Index" do
    setup [:create_guest]

    test "lists all guests", %{conn: conn, guest: guest} do
      {:ok, _index_live, html} = live(conn, ~p"/guests")

      assert html =~ "Listing Guests"
      assert html =~ guest.last_name
    end

    test "saves new guest", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/guests")

      assert index_live |> element("a", "New Guest") |> render_click() =~
               "New Guest"

      assert_patch(index_live, ~p"/guests/new")

      assert index_live
             |> form("#guest-form", guest: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#guest-form", guest: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/guests")

      html = render(index_live)
      assert html =~ "Guest created successfully"
      assert html =~ "some last_name"
    end

    test "updates guest in listing", %{conn: conn, guest: guest} do
      {:ok, index_live, _html} = live(conn, ~p"/guests")

      assert index_live |> element("#guests-#{guest.id} a", "Edit") |> render_click() =~
               "Edit Guest"

      assert_patch(index_live, ~p"/guests/#{guest}/edit")

      assert index_live
             |> form("#guest-form", guest: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#guest-form", guest: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/guests")

      html = render(index_live)
      assert html =~ "Guest updated successfully"
      assert html =~ "some updated last_name"
    end

    test "deletes guest in listing", %{conn: conn, guest: guest} do
      {:ok, index_live, _html} = live(conn, ~p"/guests")

      assert index_live |> element("#guests-#{guest.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#guests-#{guest.id}")
    end
  end

  describe "Show" do
    setup [:create_guest]

    test "displays guest", %{conn: conn, guest: guest} do
      {:ok, _show_live, html} = live(conn, ~p"/guests/#{guest}")

      assert html =~ "Show Guest"
      assert html =~ guest.last_name
    end

    test "updates guest within modal", %{conn: conn, guest: guest} do
      {:ok, show_live, _html} = live(conn, ~p"/guests/#{guest}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Guest"

      assert_patch(show_live, ~p"/guests/#{guest}/show/edit")

      assert show_live
             |> form("#guest-form", guest: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#guest-form", guest: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/guests/#{guest}")

      html = render(show_live)
      assert html =~ "Guest updated successfully"
      assert html =~ "some updated last_name"
    end
  end
end
