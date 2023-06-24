defmodule TeamTodoApiWeb.TodosControllerTest do
  use TeamTodoApiWeb.ConnCase

  alias TeamTodoApiWeb.Auth.Guardian
  alias TeamTodoApi.Users.Create

  setup %{conn: conn} do
    user_create_params = %{
      name: "azevedoguigo",
      email: "test@gmail.com",
      password: "supersenha"
    }

    {:ok, user} = Create.create_user(user_create_params)
    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    conn = put_req_header(conn, "authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  describe "create/2" do
    test "Creates and returns a new ToDo if the parameters are valid.", %{conn: conn} do
      todo_params = %{
        title: "My ToDo title",
        desciption: "My ToDo description."
      }

      response =
        conn
        |> post(~p"/api/todos", todo_params)
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
