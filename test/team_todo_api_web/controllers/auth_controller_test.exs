defmodule TeamTodoApiWeb.AuthControllerTest do

  use TeamTodoApiWeb.ConnCase

  alias TeamTodoApi.Users.Create
  alias TeamTodoApi.Schemas.User

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@example.com",
    password: "supersenha"
  }

  describe "login/2" do
    test "Returns the token if the credentials are valid.", %{conn: conn} do
      {:ok, %User{email: email, password: password}} = Create.create_user(@user_default_params)

      response =
        conn
        |> post(~p"/api/login", %{"email" => email, "password" => password})
        |> json_response(:ok)

      assert %{"token" => _token} = response
    end

    test "Returns an error message when the email is incorrect.", %{conn: conn} do
      {:ok, %User{password: password}} = Create.create_user(@user_default_params)

      response =
        conn
        |> post(~p"/api/login", %{"email" => "wrong@example.com", "password" => password})
        |> json_response(:not_found)

      assert %{"error" => "Email not registred!"} == response
    end

    test "Returns an error message when the password is incorrect.", %{conn: conn} do
      {:ok, %User{email: email}} = Create.create_user(@user_default_params)

      response =
        conn
        |> post(~p"/api/login", %{"email" => email, "password" => "incorrect_password"})
        |> json_response(:unauthorized)

      assert %{"error" => "Invalid password!"} = response
    end
  end
end
