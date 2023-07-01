defmodule TeamTodoApi.Repo.Migrations.AddTeamUsers do
  use Ecto.Migration

  def change do
    create table(:team_users, primary_key: false) do
      add :user_id, references(:users, type: :uuid)
      add :team_id, references(:teams, type: :uuid)
    end

    create unique_index(:team_users, [:user_id, :team_id])
  end
end
