defmodule TeamTodoApiWeb.TodosController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Todos.{Create, Get}

  action_fallback TeamTodoApiWeb.FallbackController

  def get_all(conn, _) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    case Get.get_all(user_id) do
      {:ok, todos} ->
        conn
        |> put_status(:ok)
        |> json(%{todos: todos})

      {:error, message} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: message})
    end
  end

  def create(conn, params) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, todo} <- Create.create_todo(params, user_id) do
      conn
      |> put_status(:created)
      |> render(:create, todo: todo)
    end
  end
end
