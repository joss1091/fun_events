defmodule FunEvents.Guests do
  @moduledoc """
  The Guests context.
  """

  import Ecto.Query, warn: false
  alias FunEvents.Repo

  alias FunEvents.Guests.Guest

  @doc """
  Returns the list of guests.

  ## Examples

      iex> list_guests()
      [%Guest{}, ...]

  """
  def list_guests do
    Repo.all(Guest)
  end

  @doc """
  Gets a single guest.

  Raises `Ecto.NoResultsError` if the Guest does not exist.

  ## Examples

      iex> get_guest!(123)
      %Guest{}

      iex> get_guest!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guest!(id), do: Repo.get(Guest, id)

  @doc """
  Creates a guest.

  ## Examples

      iex> create_guest(%{field: value})
      {:ok, %Guest{}}

      iex> create_guest(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guest(attrs \\ %{}) do
    %Guest{}
    |> Guest.changeset(attrs)
    |> Repo.insert()
  end

  def create_guest(attrs , function) do
    %Guest{}
    |> Guest.changeset(attrs)
    |> Repo.insert()
    |> after_create_guest(function)
  end

  defp after_create_guest({:ok, guest},function) do
    with {:ok, token} <- {:ok, function.(guest)},
    {:ok, guest} <- Guest.changeset(guest,%{token: token} ) |> Repo.update(),
    {:ok, short_url} <- FunEvents.ShortUrl.create_short_url(guest) do
      Guest.changeset(guest,%{invite_url_short: short_url}) |> Repo.update()
    end

  end

  defp after_create_guest(error,_function) do
    error
  end

  @doc """
  Updates a guest.

  ## Examples

      iex> update_guest(guest, %{field: new_value})
      {:ok, %Guest{}}

      iex> update_guest(guest, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guest(%Guest{} = guest, attrs) do
    guest
    |> Guest.changeset(attrs)
    |> Repo.update()
  end

  def confirm_guest(%Guest{} = guest, attrs) do
    guest
    |> Guest.confirm_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guest.

  ## Examples

      iex> delete_guest(guest)
      {:ok, %Guest{}}

      iex> delete_guest(guest)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guest(%Guest{} = guest) do
    Repo.delete(guest)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guest changes.

  ## Examples

      iex> change_guest(guest)
      %Ecto.Changeset{data: %Guest{}}

  """
  def change_guest(%Guest{} = guest, attrs \\ %{}) do
    Guest.changeset(guest, attrs)
  end


  def generate_whatsapp_url(guest, message) do
    "https://api.whatsapp.com/send?phone=52#{guest.phone}&text=#{message}"
  end



end
