defmodule TeamTodoApiWeb.TeamsControllerTest do
  use TeamTodoApiWeb.ConnCase

  alias TeamTodoApiWeb.Auth.Guardian
  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Users

  @team_default_params %{
    name: "My team",
    description: "My test team"
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

  describe "create/2" do
    test "Creates and returns a team when params are valid.", %{conn: conn, user_id: user_id} do
      response =
        conn
        |> post(~p"/api/teams", Map.put(@team_default_params, :user_id, user_id))
        |> json_response(:created)


      assert %{
        "message" => "Team created!",
        "team" => %{
          "name" => "My team",
          "description" => "My test team",
          "user_id" => ^user_id
        }
      } = response
    end

    test "When any mandatory parameter is invalid, an error is returned.", %{conn: conn, user_id: user_id} do
      with_invalid_param = %{
        title: "", # Blank title!
        description: "My test team",
        user_id: user_id
      }

      response =
        conn
        |> post(~p"/api/teams", with_invalid_param)
        |> json_response(:bad_request)

      assert %{"errors" => %{"name" => ["can't be blank"]}} == response
    end
  end
end
