defmodule FunEvents.Notifications do
  @moduledoc """
  The Notifications context.
  """

  import Ecto.Query, warn: false
  alias FunEvents.Repo

  alias FunEvents.Notifications.NotificationLogger

  @doc """
  Returns the list of notification.

  ## Examples

      iex> list_notification()
      [%NotificationLogger{}, ...]

  """
  def list_notification do
    Repo.all(NotificationLogger)
  end

  @doc """
  Gets a single notification_logger.

  Raises `Ecto.NoResultsError` if the Notification logger does not exist.

  ## Examples

      iex> get_notification_logger!(123)
      %NotificationLogger{}

      iex> get_notification_logger!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notification_logger!(id), do: Repo.get!(NotificationLogger, id)

  @doc """
  Creates a notification_logger.

  ## Examples

      iex> create_notification_logger(%{field: value})
      {:ok, %NotificationLogger{}}

      iex> create_notification_logger(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notification_logger(attrs \\ %{}) do
    %NotificationLogger{}
    |> NotificationLogger.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a notification_logger.

  ## Examples

      iex> update_notification_logger(notification_logger, %{field: new_value})
      {:ok, %NotificationLogger{}}

      iex> update_notification_logger(notification_logger, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notification_logger(%NotificationLogger{} = notification_logger, attrs) do
    notification_logger
    |> NotificationLogger.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a notification_logger.

  ## Examples

      iex> delete_notification_logger(notification_logger)
      {:ok, %NotificationLogger{}}

      iex> delete_notification_logger(notification_logger)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notification_logger(%NotificationLogger{} = notification_logger) do
    Repo.delete(notification_logger)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notification_logger changes.

  ## Examples

      iex> change_notification_logger(notification_logger)
      %Ecto.Changeset{data: %NotificationLogger{}}

  """
  def change_notification_logger(%NotificationLogger{} = notification_logger, attrs \\ %{}) do
    NotificationLogger.changeset(notification_logger, attrs)
  end

  alias FunEvents.Notifications.GuesNotificationConfig

  @doc """
  Returns the list of guest_notification_configs.

  ## Examples

      iex> list_guest_notification_configs()
      [%GuesNotificationConfig{}, ...]

  """
  def list_guest_notification_configs do
    Repo.all(GuesNotificationConfig)
  end

  @doc """
  Gets a single gues_notification_config.

  Raises `Ecto.NoResultsError` if the Gues notification config does not exist.

  ## Examples

      iex> get_gues_notification_config!(123)
      %GuesNotificationConfig{}

      iex> get_gues_notification_config!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gues_notification_config!(id), do: Repo.get!(GuesNotificationConfig, id)

  @doc """
  Creates a gues_notification_config.

  ## Examples

      iex> create_gues_notification_config(%{field: value})
      {:ok, %GuesNotificationConfig{}}

      iex> create_gues_notification_config(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gues_notification_config(attrs \\ %{}) do
    %GuesNotificationConfig{}
    |> GuesNotificationConfig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gues_notification_config.

  ## Examples

      iex> update_gues_notification_config(gues_notification_config, %{field: new_value})
      {:ok, %GuesNotificationConfig{}}

      iex> update_gues_notification_config(gues_notification_config, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gues_notification_config(%GuesNotificationConfig{} = gues_notification_config, attrs) do
    gues_notification_config
    |> GuesNotificationConfig.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gues_notification_config.

  ## Examples

      iex> delete_gues_notification_config(gues_notification_config)
      {:ok, %GuesNotificationConfig{}}

      iex> delete_gues_notification_config(gues_notification_config)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gues_notification_config(%GuesNotificationConfig{} = gues_notification_config) do
    Repo.delete(gues_notification_config)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gues_notification_config changes.

  ## Examples

      iex> change_gues_notification_config(gues_notification_config)
      %Ecto.Changeset{data: %GuesNotificationConfig{}}

  """
  def change_gues_notification_config(%GuesNotificationConfig{} = gues_notification_config, attrs \\ %{}) do
    GuesNotificationConfig.changeset(gues_notification_config, attrs)
  end
end
