defmodule TeamTodoApiWeb.UsersControllerTest do
  use TeamTodoApiWeb.ConnCase

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@example.com",
    password: "supersenha"
  }

  describe "create/2" do
    test "Creates the user if all parameters for creation are valid.", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/users", @user_default_params)
        |> json_response(:created)

      assert %{"message" => "User created!"} = response
    end

    test "When any of the parameters is invalid, it returns an error.", %{conn: conn} do
      params = %{
        name: "azevedoguigo",
        email: "invalidexample.com", # Invalid email because the "@" is missing.
        password: "supersenha"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{"error" => %{"email" => ["has invalid format"]}} == response
    end
  end
end
