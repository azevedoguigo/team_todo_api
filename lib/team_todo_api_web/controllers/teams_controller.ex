defmodule TeamTodoApiWeb.TeamsController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.{Teams}
  alias TeamTodoApi.Schemas.User

  def create(conn, params) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    case Teams.Create.create_team(params, user_id) do
      {:ok, team} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Team created!", team: team})

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: message})
    end
  end
end
