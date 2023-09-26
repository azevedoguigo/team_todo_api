defmodule TeamTodoApi.Schemas.TeamTodo do
  @moduledoc """
  This module provides the team todo schema and changeset.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias TeamTodoApi.Schemas.{Team}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  @required_fields [:title, :team_id]

  schema "team_todos" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false
    belongs_to :team, Team

    timestamps()
  end

  def changeset(todo, params)  do
    todo
    |> cast(params, [:description | @required_fields])
    |> validate_required(@required_fields)
    |> assoc_constraint(:team)
    |> validate_length(:title, min: 1, max: 40)
    |> validate_length(:description, min: 1, max: 100)
  end
end
