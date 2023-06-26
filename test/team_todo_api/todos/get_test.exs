defmodule TeamTodoApi.Todos.GetTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.{User, Todo}
  alias TeamTodoApi.{Users, Todos}

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@example.com",
    password: "supersenha"
  }

  describe "get_all/1" do
    test "Returns a tuple with :ok and a list of all if the user has todos." do
      {:ok, %User{id: user_id}} = Users.Create.create_user(@user_default_params)

      todo_params = %{
        "title" => "Todo title",
        "description" => "Todo description."
      }

      Todos.Create.create_todo(todo_params, user_id)

      result = Todos.Get.get_all(user_id)

      assert {
        :ok,
        [
          %Todo{
            title: "Todo title",
            description: "Todo description."
          }
        ]
      } = result
    end

    test "Returns a tuple with :error and a message if the user doesn't have todos." do
      {:ok, %User{id: user_id}} = Users.Create.create_user(@user_default_params)

      assert {:error, "You don't have todos!"} == Todos.Get.get_all(user_id)
    end
  end
end
