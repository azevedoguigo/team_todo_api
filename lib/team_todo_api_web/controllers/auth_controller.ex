defmodule TeamTodoApiWeb.AuthController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Users.Auth

  action_fallback TeamTodoApiWeb.FallbackController

  def login(conn, credentials) do
    with {:ok, token} <- Auth.authenticate(credentials) do
      conn
      |> put_status(:ok)
      |> render(:auth, token: token)
    end
  end
end
