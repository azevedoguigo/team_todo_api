defmodule TeamTodoApi.Users.AuthTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Users.{Auth, Create}
  alias TeamTodoApi.Schemas.User

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@example.com",
    password: "supersenha"
  }

  describe "authenticate/1" do
    test "When credentials are valid, it returns a token." do
      {:ok, %User{email: email, password: password}} = Create.create_user(@user_default_params)

      assert {:ok, _token} = Auth.authenticate(%{"email" => email, "password" => password})
    end

    test "When the email is incorrect, it returns an error message." do
      {:ok, %User{password: password}} = Create.create_user(@user_default_params)

      auth_error_response = Auth.authenticate(%{"email" => "wrong_email@example.com", "password" => password})

      assert {:error, "Email not registred!"} == auth_error_response
    end

    test "When the password is incorrect, it returns an error message." do
      {:ok, %User{email: email}} = Create.create_user(@user_default_params)

      auth_error_response = Auth.authenticate(%{"email" => email, "password" => "wrong_password"})

      assert {:error, "Invalid password!"} == auth_error_response
    end
  end

  describe "validate_password/2" do
    test "Compares the password to the hash and returns a token if it's correct." do
      {:ok, %User{password: password} = user} = Create.create_user(@user_default_params)

      assert {:ok, _token} = Auth.validate_password(user, password)
    end

    test "When the password is incorrect, it returns an error message." do
      {:ok, user} = Create.create_user(@user_default_params)

      assert {:error, "Invalid password!"} == Auth.validate_password(user, "wrong_password")
    end
  end
end
