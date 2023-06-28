defmodule TeamTodoApi.Schemas.Team do
  @moduledoc """
  This module provides the team schema and changeset.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias TeamTodoApi.Schemas.User

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  @required_fields [:name, :user_id]

  @derive {Jason.Encoder, only: [:id, :name, :description, :user_id, :inserted_at, :updated_at]}
  schema "teams" do
    field :name, :string
    field :description, :string
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(team, params) do
    team
    |> cast(params, [:description | @required_fields])
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
    |> validate_length(:name, min: 2, max: 20)
    |> validate_length(:description, min: 2, max: 100)
  end
end
