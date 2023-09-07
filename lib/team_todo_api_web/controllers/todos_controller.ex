defmodule TeamTodoApiWeb.TodosController do
  use TeamTodoApiWeb, :controller

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Todos.{Create, Get}

  action_fallback TeamTodoApiWeb.FallbackController

  def get_all(conn, _) do
    %User{id: user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, todos} <- Get.get_all(user_id) do
      conn
      |> put_status(:ok)
      |> render(:get_all, todos: todos)
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
