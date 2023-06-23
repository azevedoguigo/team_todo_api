defmodule TeamTodoApi.Schemas.Todo do
  @moduledoc """
  This module provides the todo schema and changeset.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias TeamTodoApi.Schemas.User

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  @required_fields [:title, :user_id]

  @derive {Jason.Encoder, only: [:id, :title, :description, :completed, :user_id, :inserted_at, :updated_at]}
  schema "todos" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(todo, params)  do
    todo
    |> cast(params, [:description | @required_fields])
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
    |> validate_length(:title, min: 1, max: 20)
    |> validate_required(:description, min: 1, max: 60)
  end
end
