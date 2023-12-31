defmodule TeamTodoApiWeb.TeamsController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Teams.{Create, Get}
  alias TeamTodoApi.Schemas.User

  action_fallback TeamTodoApiWeb.FallbackController
  def create(conn, params) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, team} <- Create.create_team(params, user_id) do
      conn
      |> put_status(:created)
      |> render(:create, team: team)
    end
  end

  def index(conn, %{"team_id" => team_id}) do
    with {:ok, team} <- Get.get_team(team_id) do
      conn
      |> put_status(:ok)
      |> render(:index, team: team)
    end
  end
end
