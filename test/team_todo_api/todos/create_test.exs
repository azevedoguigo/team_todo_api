defmodule TeamTodoApi.Todos.CreateTest do
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

  describe "create_todo/2" do
    test "When the parameters are valid, returns the new todo.", %{user_id: user_id} do
      params = %{
        "title" => "My ToDo title",
        "description" => "My ToDo description."
      }

      result = Todos.Create.create_todo(params, user_id)

      assert{:ok, %Todo{title: "My ToDo title", description: "My ToDo description."}} = result
    end

    test "When one or more parameters are invalid, returns an invalid changeset.", %{user_id: user_id} do
      params = %{
        "title" => "", # The title cannot be blank.
        "description" => "My ToDo description."
      }

      {:error, invalid_changeset} = Todos.Create.create_todo(params, user_id)

      assert errors_on(invalid_changeset) == %{title: ["can't be blank"]}
    end
  end
end
