defmodule TeamTodoApi.Repo.Migrations.AddTeamTodos do
  use Ecto.Migration

  def change do
    create table(:team_todos, primary_key: false) do
      add :user_id, references(:users, type: :uuid)
      add :team_id, references(:teams, type: :uuid)
      add :todo_id, references(:todos, type: :uuid)
    end

    create unique_index(:team_todos, [:user_id, :team_id, :todo_id])
  end
end
