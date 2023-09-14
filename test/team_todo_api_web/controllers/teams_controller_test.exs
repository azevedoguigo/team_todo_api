defmodule TeamTodoApiWeb.TeamsControllerTest do
  use TeamTodoApiWeb.ConnCase

  alias TeamTodoApiWeb.Auth.Guardian
  alias TeamTodoApi.Schemas.{User, Team}
  alias TeamTodoApi.{Users, Teams}

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

  describe "get/2" do
    test "Returns the team as long as the id is valid and corresponds to a team.", %{conn: conn, user_id: user_id} do
      create_team_params = %{
        "name" => "My Team",
        "description" => "Testing team creation."
      }

      {:ok, %Team{id: team_id}} = Teams.Create.create_team(create_team_params, user_id)

      response =
        conn
        |> get(~p"/api/teams?team_id=#{team_id}")
        |> json_response(:ok)

        assert %{
          "name" => "My Team",
          "description" => "Testing team creation.",
          "user_id" => ^user_id
        } = response
    end

    test "Returns an error message when the team is not found.", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/teams?team_id=fe9d6a40-631c-4e19-84f4-197ef55deb0e")
        |> json_response(:not_found)

        assert %{"error" => "This team does not exist!"} == response
    end

    test "Returns an error message when the team is invalid.", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/teams?team_id=invalid_id")
        |> json_response(:bad_request)

        assert %{"error" => "Invalid team ID!"} == response
    end
  end
end
