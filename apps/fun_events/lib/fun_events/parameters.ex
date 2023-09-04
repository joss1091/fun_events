defmodule FunEvents.Parameters do
  @moduledoc """
  The Parameters context.
  """

  import Ecto.Query, warn: false
  alias FunEvents.Repo

  alias FunEvents.Parameters.Parameter

  @doc """
  Returns the list of parameters.

  ## Examples

      iex> list_parameters()
      [%Parameter{}, ...]

  """
  def list_parameters do
    Repo.all(Parameter)
  end

  @doc """
  Gets a single parameter.

  Raises `Ecto.NoResultsError` if the Parameter does not exist.

  ## Examples

      iex> get_parameter!(123)
      %Parameter{}

      iex> get_parameter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_parameter!(id), do: Repo.get!(Parameter, id)

  def get_parameter_by_type(name, resource_id, resource_type) do
    Repo.get_by(Parameter,[name: name, resource_id: resource_id, resource_type: resource_type])
  end

  @doc """
  Creates a parameter.

  ## Examples

      iex> create_parameter(%{field: value})
      {:ok, %Parameter{}}

      iex> create_parameter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_parameter(attrs \\ %{}) do
    %Parameter{}
    |> Parameter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a parameter.

  ## Examples

      iex> update_parameter(parameter, %{field: new_value})
      {:ok, %Parameter{}}

      iex> update_parameter(parameter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_parameter(%Parameter{} = parameter, attrs) do
    parameter
    |> Parameter.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a parameter.

  ## Examples

      iex> delete_parameter(parameter)
      {:ok, %Parameter{}}

      iex> delete_parameter(parameter)
      {:error, %Ecto.Changeset{}}

  """
  def delete_parameter(%Parameter{} = parameter) do
    Repo.delete(parameter)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking parameter changes.

  ## Examples

      iex> change_parameter(parameter)
      %Ecto.Changeset{data: %Parameter{}}

  """
  def change_parameter(%Parameter{} = parameter, attrs \\ %{}) do
    Parameter.changeset(parameter, attrs)
  end
end
