defmodule TeamTodoApi.Teams.Todos.Create do
  @moduledoc """
  This module provides the function for creating team todo.
  """

  alias TeamTodoApi.Repo
  alias Ecto.Changeset
  alias TeamTodoApi.Teams
  alias TeamTodoApi.Todos

  def create_team_todo(team_id, user_id, todo_params) do
    with {:ok, team} <- Teams.Get.get_team(team_id),
         {:ok, todo} <- Todos.Create.create_todo(todo_params, user_id) do

      team_preload = Repo.preload(team, [:user, :users, :todos])
      todo_preload = Repo.preload(todo, [:user])

      team_changeset = Changeset.change(team_preload)
      team_with_todo = Changeset.put_assoc(team_changeset, :todos, [todo_preload])

      team = Repo.update!(team_with_todo)

      {:ok, team}
    end
  end
end
