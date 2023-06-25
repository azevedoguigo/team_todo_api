defmodule TeamTodoApi.Schemas.TodoTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.{User, Todo}
  alias TeamTodoApi.Users.Create

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@gmail.com",
    password: "supersenha"
  }

  describe "changeset/2" do
    test "Returns a valid changeset if all parameters are valid." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      params = %{
        title: "My ToDo title",
        description: "My ToDo description.",
        user_id: user_id
      }

      result = Todo.changeset(%Todo{}, params)

      assert %Ecto.Changeset{valid?: true} = result
    end

    test "Returns invalid changeset with an error description if one of the required parameters is missing." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      params = %{
        title: "", # Blank title, title is required.
        description: "My ToDo description.",
        user_id: user_id
      }

      invalid_changeset = Todo.changeset(%Todo{}, params)

      assert errors_on(invalid_changeset) == %{title: ["can't be blank"]}
    end

    test "Returns an invalid changeset with an error description if the title length is greater than 40 characters." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      params = %{
        title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        description: "My ToDo description.",
        user_id: user_id
      }

      invalid_changeset = Todo.changeset(%Todo{}, params)

      assert errors_on(invalid_changeset) == %{title: ["should be at most 40 character(s)"]}
    end

    test "Returns an invalid changeset and an error description when the description is longer than 100 characters." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      params = %{
        title: "My ToDo tile",
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
        user_id: user_id
      }

      invalid_changeset = Todo.changeset(%Todo{}, params)

      assert errors_on(invalid_changeset) == %{description: ["should be at most 100 character(s)"]}
    end
  end
end
