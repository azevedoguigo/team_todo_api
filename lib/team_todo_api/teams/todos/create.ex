defmodule TeamTodoApi.Teams.Todos.Create do
  @moduledoc """
  Module with the necessary function to perform team todos.
  """

  alias TeamTodoApi.Repo
  alias TeamTodoApi.Teams
  alias TeamTodoApi.Schemas.TeamTodo

  def create_team_todo(%{"team_id" => team_id} = params) do
    with {:ok, _team} <- Teams.Get.get_team(team_id) do
      handle_create_team_todo(params)
    end
  end

  defp handle_create_team_todo(params) do
    %TeamTodo{}
    |> TeamTodo.changeset(params)
    |> Repo.insert()
  end
end
