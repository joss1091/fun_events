defmodule FunEvents.GuestsTest do
  use FunEvents.DataCase

  alias FunEvents.Guests

  describe "guests" do
    alias FunEvents.Guests.Guest

    import FunEvents.GuestsFixtures

    @invalid_attrs %{adult_confirmed: nil, adult_max: nil, date_response: nil, event_id: nil, last_name: nil, last_notification_date: nil, minor_confirmed: nil, minor_max: nil, name: nil, state: nil}

    test "list_guests/0 returns all guests" do
      guest = guest_fixture()
      assert Guests.list_guests() == [guest]
    end

    test "get_guest!/1 returns the guest with given id" do
      guest = guest_fixture()
      assert Guests.get_guest!(guest.id) == guest
    end

    test "create_guest/1 with valid data creates a guest" do
      valid_attrs = %{adult_confirmed: 42, adult_max: 42, date_response: ~U[2023-06-05 19:48:00Z], event_id: 42, last_name: "some last_name", last_notification_date: ~U[2023-06-05 19:48:00Z], minor_confirmed: 42, minor_max: 42, name: "some name", state: "some state"}

      assert {:ok, %Guest{} = guest} = Guests.create_guest(valid_attrs)
      assert guest.adult_confirmed == 42
      assert guest.adult_max == 42
      assert guest.date_response == ~U[2023-06-05 19:48:00Z]
      assert guest.event_id == 42
      assert guest.last_name == "some last_name"
      assert guest.last_notification_date == ~U[2023-06-05 19:48:00Z]
      assert guest.minor_confirmed == 42
      assert guest.minor_max == 42
      assert guest.name == "some name"
      assert guest.state == "some state"
    end

    test "create_guest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Guests.create_guest(@invalid_attrs)
    end

    test "update_guest/2 with valid data updates the guest" do
      guest = guest_fixture()
      update_attrs = %{adult_confirmed: 43, adult_max: 43, date_response: ~U[2023-06-06 19:48:00Z], event_id: 43, last_name: "some updated last_name", last_notification_date: ~U[2023-06-06 19:48:00Z], minor_confirmed: 43, minor_max: 43, name: "some updated name", state: "some updated state"}

      assert {:ok, %Guest{} = guest} = Guests.update_guest(guest, update_attrs)
      assert guest.adult_confirmed == 43
      assert guest.adult_max == 43
      assert guest.date_response == ~U[2023-06-06 19:48:00Z]
      assert guest.event_id == 43
      assert guest.last_name == "some updated last_name"
      assert guest.last_notification_date == ~U[2023-06-06 19:48:00Z]
      assert guest.minor_confirmed == 43
      assert guest.minor_max == 43
      assert guest.name == "some updated name"
      assert guest.state == "some updated state"
    end

    test "update_guest/2 with invalid data returns error changeset" do
      guest = guest_fixture()
      assert {:error, %Ecto.Changeset{}} = Guests.update_guest(guest, @invalid_attrs)
      assert guest == Guests.get_guest!(guest.id)
    end

    test "delete_guest/1 deletes the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{}} = Guests.delete_guest(guest)
      assert_raise Ecto.NoResultsError, fn -> Guests.get_guest!(guest.id) end
    end

    test "change_guest/1 returns a guest changeset" do
      guest = guest_fixture()
      assert %Ecto.Changeset{} = Guests.change_guest(guest)
    end
  end
end
