defmodule FunEventsWeb.NotificationLoggerLiveTest do
  use FunEventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import FunEvents.NotificationsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_notification_logger(_) do
    notification_logger = notification_logger_fixture()
    %{notification_logger: notification_logger}
  end

  describe "Index" do
    setup [:create_notification_logger]

    test "lists all notification", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/notification")

      assert html =~ "Listing Notification"
    end

    test "saves new notification_logger", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/notification")

      assert index_live |> element("a", "New Notification logger") |> render_click() =~
               "New Notification logger"

      assert_patch(index_live, ~p"/notification/new")

      assert index_live
             |> form("#notification_logger-form", notification_logger: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#notification_logger-form", notification_logger: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/notification")

      html = render(index_live)
      assert html =~ "Notification logger created successfully"
    end

    test "updates notification_logger in listing", %{conn: conn, notification_logger: notification_logger} do
      {:ok, index_live, _html} = live(conn, ~p"/notification")

      assert index_live |> element("#notification-#{notification_logger.id} a", "Edit") |> render_click() =~
               "Edit Notification logger"

      assert_patch(index_live, ~p"/notification/#{notification_logger}/edit")

      assert index_live
             |> form("#notification_logger-form", notification_logger: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#notification_logger-form", notification_logger: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/notification")

      html = render(index_live)
      assert html =~ "Notification logger updated successfully"
    end

    test "deletes notification_logger in listing", %{conn: conn, notification_logger: notification_logger} do
      {:ok, index_live, _html} = live(conn, ~p"/notification")

      assert index_live |> element("#notification-#{notification_logger.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#notification-#{notification_logger.id}")
    end
  end

  describe "Show" do
    setup [:create_notification_logger]

    test "displays notification_logger", %{conn: conn, notification_logger: notification_logger} do
      {:ok, _show_live, html} = live(conn, ~p"/notification/#{notification_logger}")

      assert html =~ "Show Notification logger"
    end

    test "updates notification_logger within modal", %{conn: conn, notification_logger: notification_logger} do
      {:ok, show_live, _html} = live(conn, ~p"/notification/#{notification_logger}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Notification logger"

      assert_patch(show_live, ~p"/notification/#{notification_logger}/show/edit")

      assert show_live
             |> form("#notification_logger-form", notification_logger: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#notification_logger-form", notification_logger: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/notification/#{notification_logger}")

      html = render(show_live)
      assert html =~ "Notification logger updated successfully"
    end
  end
end
