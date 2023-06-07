defmodule FunEvents.EventsTest do
  use FunEvents.DataCase

  alias FunEvents.Events

  describe "events" do
    alias FunEvents.Events.Event

    import FunEvents.EventsFixtures

    @invalid_attrs %{date: nil, name: nil, status: nil, time_zone: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{date: ~D[2023-06-05], name: "some name", status: "some status", time_zone: "some time_zone"}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.date == ~D[2023-06-05]
      assert event.name == "some name"
      assert event.status == "some status"
      assert event.time_zone == "some time_zone"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{date: ~D[2023-06-06], name: "some updated name", status: "some updated status", time_zone: "some updated time_zone"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.date == ~D[2023-06-06]
      assert event.name == "some updated name"
      assert event.status == "some updated status"
      assert event.time_zone == "some updated time_zone"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
