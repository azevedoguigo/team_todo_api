defmodule TeamTodoApi.Todos.GetTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.{User, Todo}
  alias TeamTodoApi.{Users, Todos}

  setup do
    user_params = %{
      name: "azevedoguigo",
      email: "test@gmail.com",
      password: "supersenha"
    }

    {:ok, %User{id: user_id}} = Users.Create.create_user(user_params)

    {:ok, user_id: user_id}
  end

  describe "get_all/1" do
    test "Returns a tuple with :ok and a list of all if the user has todos.", %{user_id: user_id} do
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

    test "Returns a tuple with :error and a message if the user doesn't have todos.", %{user_id: user_id} do
      expected_response = {
        :error,
        %{
          message: "You don't have todos!",
          status: :not_found
        }
      }

      assert expected_response == Todos.Get.get_all(user_id)
    end
  end
end
