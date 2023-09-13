defmodule TeamTodoApi.Teams.GetTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.{User, Team}
  alias TeamTodoApi.{Users, Teams}

  setup do
    user_params = %{
      name: "azevedoguigo",
      email: "azevedoguigo.test@example.com",
      password: "supersenha"
    }
    {:ok, %User{id: user_id}} = Users.Create.create_user(user_params)

    {:ok, user_id: user_id}
  end

  describe "get/1" do
    test "Returns the team when the id is valid and belongs to a team.", %{user_id: user_id} do
      {:ok, %Team{id: team_id}} = Teams.Create.create_team(%{"name" => "My Team", "description" => "Test"}, user_id)

      response = Teams.Get.get_team(team_id)

      assert {
        :ok,
        %Team{
          name: "My Team",
          description: "Test",
          user_id: ^user_id
        }
      } = response
    end

    test "Returns an tuple with :error and error data when the team does not exist." do
      response = Teams.Get.get_team("fe9d6a40-631c-4e19-84f4-197ef55deb0e")

      expected_response = {:error, %{message: "This team does not exist!", status: :not_found}}

      assert expected_response == response
    end

    test "Returns an tuple with :error and error data when the team id is invalid." do
      response = Teams.Get.get_team("invalid_id")

      expected_response = {
        :error,
        %{
          message: "Invalid team ID!",
          status: :bad_request
        }
      }

      assert expected_response == response
    end
  end
end
