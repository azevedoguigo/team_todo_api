defmodule TeamTodoApiWeb.UsersController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Users.Create

  action_fallback TeamTodoApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Create.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
