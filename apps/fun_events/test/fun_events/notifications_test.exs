defmodule FunEvents.NotificationsTest do
  use FunEvents.DataCase

  alias FunEvents.Notifications

  describe "notification" do
    alias FunEvents.Notifications.NotificationLogger

    import FunEvents.NotificationsFixtures

    @invalid_attrs %{}

    test "list_notification/0 returns all notification" do
      notification_logger = notification_logger_fixture()
      assert Notifications.list_notification() == [notification_logger]
    end

    test "get_notification_logger!/1 returns the notification_logger with given id" do
      notification_logger = notification_logger_fixture()
      assert Notifications.get_notification_logger!(notification_logger.id) == notification_logger
    end

    test "create_notification_logger/1 with valid data creates a notification_logger" do
      valid_attrs = %{}

      assert {:ok, %NotificationLogger{} = notification_logger} = Notifications.create_notification_logger(valid_attrs)
    end

    test "create_notification_logger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_notification_logger(@invalid_attrs)
    end

    test "update_notification_logger/2 with valid data updates the notification_logger" do
      notification_logger = notification_logger_fixture()
      update_attrs = %{}

      assert {:ok, %NotificationLogger{} = notification_logger} = Notifications.update_notification_logger(notification_logger, update_attrs)
    end

    test "update_notification_logger/2 with invalid data returns error changeset" do
      notification_logger = notification_logger_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_notification_logger(notification_logger, @invalid_attrs)
      assert notification_logger == Notifications.get_notification_logger!(notification_logger.id)
    end

    test "delete_notification_logger/1 deletes the notification_logger" do
      notification_logger = notification_logger_fixture()
      assert {:ok, %NotificationLogger{}} = Notifications.delete_notification_logger(notification_logger)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_notification_logger!(notification_logger.id) end
    end

    test "change_notification_logger/1 returns a notification_logger changeset" do
      notification_logger = notification_logger_fixture()
      assert %Ecto.Changeset{} = Notifications.change_notification_logger(notification_logger)
    end
  end

  describe "guest_notification_configs" do
    alias FunEvents.Notifications.GuesNotificationConfig

    import FunEvents.NotificationsFixtures

    @invalid_attrs %{country: nil, is_default: nil, to: nil, type: nil}

    test "list_guest_notification_configs/0 returns all guest_notification_configs" do
      gues_notification_config = gues_notification_config_fixture()
      assert Notifications.list_guest_notification_configs() == [gues_notification_config]
    end

    test "get_gues_notification_config!/1 returns the gues_notification_config with given id" do
      gues_notification_config = gues_notification_config_fixture()
      assert Notifications.get_gues_notification_config!(gues_notification_config.id) == gues_notification_config
    end

    test "create_gues_notification_config/1 with valid data creates a gues_notification_config" do
      valid_attrs = %{country: "some country", is_default: true, to: "some to", type: "some type"}

      assert {:ok, %GuesNotificationConfig{} = gues_notification_config} = Notifications.create_gues_notification_config(valid_attrs)
      assert gues_notification_config.country == "some country"
      assert gues_notification_config.is_default == true
      assert gues_notification_config.to == "some to"
      assert gues_notification_config.type == "some type"
    end

    test "create_gues_notification_config/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_gues_notification_config(@invalid_attrs)
    end

    test "update_gues_notification_config/2 with valid data updates the gues_notification_config" do
      gues_notification_config = gues_notification_config_fixture()
      update_attrs = %{country: "some updated country", is_default: false, to: "some updated to", type: "some updated type"}

      assert {:ok, %GuesNotificationConfig{} = gues_notification_config} = Notifications.update_gues_notification_config(gues_notification_config, update_attrs)
      assert gues_notification_config.country == "some updated country"
      assert gues_notification_config.is_default == false
      assert gues_notification_config.to == "some updated to"
      assert gues_notification_config.type == "some updated type"
    end

    test "update_gues_notification_config/2 with invalid data returns error changeset" do
      gues_notification_config = gues_notification_config_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_gues_notification_config(gues_notification_config, @invalid_attrs)
      assert gues_notification_config == Notifications.get_gues_notification_config!(gues_notification_config.id)
    end

    test "delete_gues_notification_config/1 deletes the gues_notification_config" do
      gues_notification_config = gues_notification_config_fixture()
      assert {:ok, %GuesNotificationConfig{}} = Notifications.delete_gues_notification_config(gues_notification_config)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_gues_notification_config!(gues_notification_config.id) end
    end

    test "change_gues_notification_config/1 returns a gues_notification_config changeset" do
      gues_notification_config = gues_notification_config_fixture()
      assert %Ecto.Changeset{} = Notifications.change_gues_notification_config(gues_notification_config)
    end
  end
end
