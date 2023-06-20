defmodule TeamTodoApiWeb.AuthController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Users.Auth

  def login(conn, credentials) do
    case Auth.authenticate(credentials) do
      {:ok, token} ->
        conn
        |> put_status(:ok)
        |> json(%{token: token})

      {:error, error_message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: error_message})
    end
  end
end
