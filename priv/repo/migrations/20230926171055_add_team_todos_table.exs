defmodule TeamTodoApi.Repo.Migrations.AddTeamTodosTable do
  use Ecto.Migration

  def change do
    create table(:team_todos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :description, :string
      add :completed, :boolean, default: false
      add :team_id, references(:teams, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
