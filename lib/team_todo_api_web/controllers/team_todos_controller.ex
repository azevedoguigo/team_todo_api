defmodule TeamTodoApiWeb.TeamTodosController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Teams.Todos

  action_fallback TeamTodoApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, todo} <- Todos.Create.create_team_todo(params) do
      conn
      |> put_status(:created)
      |> render(:create, todo: todo)
    end
  end
end
