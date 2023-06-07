defmodule FunEventsWeb.GuesNotificationConfigLiveTest do
  use FunEventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import FunEvents.NotificationsFixtures

  @create_attrs %{country: "some country", is_default: true, to: "some to", type: "some type"}
  @update_attrs %{country: "some updated country", is_default: false, to: "some updated to", type: "some updated type"}
  @invalid_attrs %{country: nil, is_default: false, to: nil, type: nil}

  defp create_gues_notification_config(_) do
    gues_notification_config = gues_notification_config_fixture()
    %{gues_notification_config: gues_notification_config}
  end

  describe "Index" do
    setup [:create_gues_notification_config]

    test "lists all guest_notification_configs", %{conn: conn, gues_notification_config: gues_notification_config} do
      {:ok, _index_live, html} = live(conn, ~p"/guest_notification_configs")

      assert html =~ "Listing Guest notification configs"
      assert html =~ gues_notification_config.country
    end

    test "saves new gues_notification_config", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/guest_notification_configs")

      assert index_live |> element("a", "New Gues notification config") |> render_click() =~
               "New Gues notification config"

      assert_patch(index_live, ~p"/guest_notification_configs/new")

      assert index_live
             |> form("#gues_notification_config-form", gues_notification_config: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#gues_notification_config-form", gues_notification_config: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/guest_notification_configs")

      html = render(index_live)
      assert html =~ "Gues notification config created successfully"
      assert html =~ "some country"
    end

    test "updates gues_notification_config in listing", %{conn: conn, gues_notification_config: gues_notification_config} do
      {:ok, index_live, _html} = live(conn, ~p"/guest_notification_configs")

      assert index_live |> element("#guest_notification_configs-#{gues_notification_config.id} a", "Edit") |> render_click() =~
               "Edit Gues notification config"

      assert_patch(index_live, ~p"/guest_notification_configs/#{gues_notification_config}/edit")

      assert index_live
             |> form("#gues_notification_config-form", gues_notification_config: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#gues_notification_config-form", gues_notification_config: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/guest_notification_configs")

      html = render(index_live)
      assert html =~ "Gues notification config updated successfully"
      assert html =~ "some updated country"
    end

    test "deletes gues_notification_config in listing", %{conn: conn, gues_notification_config: gues_notification_config} do
      {:ok, index_live, _html} = live(conn, ~p"/guest_notification_configs")

      assert index_live |> element("#guest_notification_configs-#{gues_notification_config.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#guest_notification_configs-#{gues_notification_config.id}")
    end
  end

  describe "Show" do
    setup [:create_gues_notification_config]

    test "displays gues_notification_config", %{conn: conn, gues_notification_config: gues_notification_config} do
      {:ok, _show_live, html} = live(conn, ~p"/guest_notification_configs/#{gues_notification_config}")

      assert html =~ "Show Gues notification config"
      assert html =~ gues_notification_config.country
    end

    test "updates gues_notification_config within modal", %{conn: conn, gues_notification_config: gues_notification_config} do
      {:ok, show_live, _html} = live(conn, ~p"/guest_notification_configs/#{gues_notification_config}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gues notification config"

      assert_patch(show_live, ~p"/guest_notification_configs/#{gues_notification_config}/show/edit")

      assert show_live
             |> form("#gues_notification_config-form", gues_notification_config: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#gues_notification_config-form", gues_notification_config: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/guest_notification_configs/#{gues_notification_config}")

      html = render(show_live)
      assert html =~ "Gues notification config updated successfully"
      assert html =~ "some updated country"
    end
  end
end
