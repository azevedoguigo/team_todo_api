defmodule TeamTodoApi.Teams.CreateTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Users

  alias TeamTodoApi.Schemas.Team
  alias TeamTodoApi.Teams

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@gmail.com",
    password: "supersenha"
  }

  describe "create/2" do
    test "Create and return the team when all params are valid." do
      {:ok, %User{id: user_id}} = Users.Create.create_user(@user_default_params)

      create_team_params = %{
        "name" => "My Team",
        "description" => "Testing team creation."
      }

      response = Teams.Create.create_team(create_team_params, user_id)

      assert {
        :ok,
        %Team{
          name: "My Team",
          description: "Testing team creation.",
          user_id: ^user_id
        }
      } = response
    end

    test "Returns a tuple with an :error and an invalid changeset when the name is not provided." do
      {:ok, %User{id: user_id}} = Users.Create.create_user(@user_default_params)

      create_team_params = %{
        "name" => "",
        "description" => "Testing team creation."
      }

      {:error, response} = Teams.Create.create_team(create_team_params, user_id)

      assert errors_on(response) == %{name: ["can't be blank"]}
    end

    test "Returns a tuple with :error and a message when the id is invalid." do
      create_team_params = %{
        "name" => "",
        "description" => "Testing team creation."
      }

      response = Teams.Create.create_team(create_team_params, "invalid_id")

      assert {:error, "Invalid user ID!"} == response
    end

    test "Returns a tuple with :error and a message when the id is not that of any user." do
      create_team_params = %{
        "name" => "",
        "description" => "Testing team creation."
      }

      response = Teams.Create.create_team(create_team_params, "ca66349a-5006-4ecf-bf67-63d923122f34")

      assert {:error, "This user does not exist!"} == response
    end
  end
end
