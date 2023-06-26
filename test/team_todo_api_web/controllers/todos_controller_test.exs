defmodule TeamTodoApiWeb.TodosControllerTest do
  use TeamTodoApiWeb.ConnCase

  alias TeamTodoApiWeb.Auth.Guardian
  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.{Users, Todos}

  @todo_default_params %{
    "title" => "My ToDo title",
    "description" => "My ToDo description."
  }

  setup %{conn: conn} do
    user_create_params = %{
      name: "azevedoguigo",
      email: "test@gmail.com",
      password: "supersenha"
    }

    {:ok, %User{id: user_id} = user} = Users.Create.create_user(user_create_params)
    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    conn = put_req_header(conn, "authorization", "Bearer #{token}")

    {:ok, conn: conn, user_id: user_id}
  end

  describe "get_all/1" do
    test "Returns the list of todos if the user has todos.", %{conn: conn, user_id: user_id} do
      Todos.Create.create_todo(@todo_default_params, user_id)

      response =
        conn
        |> get(~p"/api/todos")
        |> json_response(:ok)

      assert %{
        "todos" => [
          %{
            "title" => "My ToDo title",
            "description" => "My ToDo description."
          }
        ]
      } = response
    end

    test "Returns a message when the user does not have todos.", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/todos")
        |> json_response(:not_found)

      assert %{"error" => "You don't have todos!"} == response
    end
  end

  describe "create/2" do
    test "Creates and returns a new ToDo if the parameters are valid.", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/todos", @todo_default_params)
        |> json_response(:created)

      assert %{"message" => "ToDo Created!"} = response
    end

    test "Return an error message when one of the creation parameters is missing.", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/todos", %{title: "", description: "MyTodo description"})
        |> json_response(:bad_request)

      assert %{"error" => %{"title" => ["can't be blank"]}} == response
    end
  end
end
