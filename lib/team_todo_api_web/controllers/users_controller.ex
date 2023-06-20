defmodule TeamTodoApiWeb.UsersController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Users.Create

  def create(conn, params) do
    case Create.create_user(params) do
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
