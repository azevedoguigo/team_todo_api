defmodule TeamTodoApi.UsersTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.{Schemas, Accounts}
  alias TeamTodoApi.Repo

  describe "create/1" do
    test "When all parameters are valid, it registers the user." do
      params = %{
        name: "azevedoguigo",
        email: "azevedoguigo.test@example.com",
        password: "supersenha"
      }

      count_before = Repo.aggregate(Schemas.User, :count)

      response = Accounts.Create.create_user(params)

      count_after = Repo.aggregate(Schemas.User, :count)

      assert {
        :ok,
        %Schemas.User{
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

      {:error, changeset} = Accounts.Create.create_user(params)

      assert errors_on(changeset) == %{name: ["can't be blank"], email: ["has invalid format"]}
    end
  end
end
