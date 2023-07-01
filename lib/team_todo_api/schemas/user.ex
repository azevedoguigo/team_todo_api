defmodule TeamTodoApi.Schemas.User do
  @moduledoc """
  This module provides the schema and user changeset.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias TeamTodoApi.Schemas.{Todo, Team}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @required_fields [:name, :email, :password]

  @derive {Jason.Encoder, only: [:id, :name, :email, :inserted_at, :updated_at]}
  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash
    has_many :todos, Todo
    has_many :team, Team
    many_to_many :teams, Team, join_through: "team_users"

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 2, max: 40)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, min: 11, max: 40)
    |> unique_constraint(:email, name: :users_email_index)
    |> validate_length(:password, min: 6, max: 30)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = chageset) do
    change(chageset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
