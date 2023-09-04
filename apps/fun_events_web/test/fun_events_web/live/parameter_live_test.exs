defmodule FunEventsWeb.ParameterLiveTest do
  use FunEventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import FunEvents.ParametersFixtures

  @create_attrs %{name: "some name", resource_id: "some resource_id", resource_type: "some resource_type", value: %{}}
  @update_attrs %{name: "some updated name", resource_id: "some updated resource_id", resource_type: "some updated resource_type", value: %{}}
  @invalid_attrs %{name: nil, resource_id: nil, resource_type: nil, value: nil}

  defp create_parameter(_) do
    parameter = parameter_fixture()
    %{parameter: parameter}
  end

  describe "Index" do
    setup [:create_parameter]

    test "lists all parameters", %{conn: conn, parameter: parameter} do
      {:ok, _index_live, html} = live(conn, ~p"/parameters")

      assert html =~ "Listing Parameters"
      assert html =~ parameter.name
    end

    test "saves new parameter", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/parameters")

      assert index_live |> element("a", "New Parameter") |> render_click() =~
               "New Parameter"

      assert_patch(index_live, ~p"/parameters/new")

      assert index_live
             |> form("#parameter-form", parameter: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#parameter-form", parameter: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/parameters")

      html = render(index_live)
      assert html =~ "Parameter created successfully"
      assert html =~ "some name"
    end

    test "updates parameter in listing", %{conn: conn, parameter: parameter} do
      {:ok, index_live, _html} = live(conn, ~p"/parameters")

      assert index_live |> element("#parameters-#{parameter.id} a", "Edit") |> render_click() =~
               "Edit Parameter"

      assert_patch(index_live, ~p"/parameters/#{parameter}/edit")

      assert index_live
             |> form("#parameter-form", parameter: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#parameter-form", parameter: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/parameters")

      html = render(index_live)
      assert html =~ "Parameter updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes parameter in listing", %{conn: conn, parameter: parameter} do
      {:ok, index_live, _html} = live(conn, ~p"/parameters")

      assert index_live |> element("#parameters-#{parameter.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#parameters-#{parameter.id}")
    end
  end

  describe "Show" do
    setup [:create_parameter]

    test "displays parameter", %{conn: conn, parameter: parameter} do
      {:ok, _show_live, html} = live(conn, ~p"/parameters/#{parameter}")

      assert html =~ "Show Parameter"
      assert html =~ parameter.name
    end

    test "updates parameter within modal", %{conn: conn, parameter: parameter} do
      {:ok, show_live, _html} = live(conn, ~p"/parameters/#{parameter}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Parameter"

      assert_patch(show_live, ~p"/parameters/#{parameter}/show/edit")

      assert show_live
             |> form("#parameter-form", parameter: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#parameter-form", parameter: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/parameters/#{parameter}")

      html = render(show_live)
      assert html =~ "Parameter updated successfully"
      assert html =~ "some updated name"
    end
  end
end
