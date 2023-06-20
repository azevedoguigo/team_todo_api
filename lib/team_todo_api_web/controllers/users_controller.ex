defmodule TeamTodoApiWeb.UsersController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApiWeb.ErrorHandler
  alias TeamTodoApi.Users.Create

  def create(conn, params) do
    case Create.create_user(params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User created!", user: user})

      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: ErrorHandler.humanize_errors(changeset)})
    end
  end
end
