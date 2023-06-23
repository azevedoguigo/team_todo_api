defmodule TeamTodoApiWeb.TodosController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApiWeb.ErrorHandler
  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Todos.Create

  def create(conn, params) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    case Create.create_todo(params, user_id) do
      {:ok, todo} ->
        conn
        |> put_status(:created)
        |> json(%{message: "ToDo Created!", todo: todo})

      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: ErrorHandler.humanize_errors(changeset)})
    end
  end
end
