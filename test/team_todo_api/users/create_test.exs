defmodule TeamTodoApi.Users.CreateTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Users.Create
  alias TeamTodoApi.Repo

  describe "create/1" do
    test "When all parameters are valid, it registers the user." do
      params = %{
        name: "azevedoguigo",
        email: "azevedoguigo.test@example.com",
        password: "supersenha"
      }

      count_before = Repo.aggregate(User, :count)

      response = Create.create_user(params)

      count_after = Repo.aggregate(User, :count)

      assert {
        :ok,
        %User{
          name: "azevedoguigo",
          email: "azevedoguigo.test@example.com",
          password: "supersenha"
        }
      } = response

      assert count_after > count_before
    end

    test "When any of the parameters are valid, it returns an error message." do
      params = %{
        name: "",
        email: "azevedoguigo.testexample.com", # Invalid email format.
        password: "supersenha"
      }

      {:error, changeset} = Create.create_user(params)

      assert errors_on(changeset) == %{name: ["can't be blank"], email: ["has invalid format"]}
    end
  end
end
