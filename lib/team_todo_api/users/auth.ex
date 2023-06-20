defmodule TeamTodoApi.Users.Auth do
  @moduledoc """
  Provides useful functions for user authentication.
  """

  alias TeamTodoApiWeb.Auth.Guardian
  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Repo

  def authenticate(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, "Email not registred!"}
      user -> validate_password(user, password)
    end
  end

  def validate_password(%User{password_hash: hash} = user, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(user)
      false -> {:error, "Invalid password!"}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: {8, :hours})

    {:ok, token}
  end
end
