defmodule TeamTodoApi.Repo.Migrations.AddTeamsTable do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :string
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
