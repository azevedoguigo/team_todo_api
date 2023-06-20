defmodule TeamTodoApiWeb.UsersController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Accounts

  def create(conn, params) do
    case Accounts.Users.create(params) do
      {:ok, _user} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User created!"})

      {:error, _changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "Error to create user!"})
    end
  end
end
