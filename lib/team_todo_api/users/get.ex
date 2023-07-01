defmodule TeamTodoApi.Users.Get do
  @moduledoc """
  Provides useful functions for searching users.
  """

  alias Ecto.UUID
  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.User

  def get_user(user_id) do
    case validate_user_id(user_id) do
      {:ok, uuid} -> handle_get_user(uuid)

      {:error, message} -> {:error, message}
    end
  end

  defp validate_user_id(user_id) do
    case UUID.cast(user_id) do
      {:ok, uuid} -> {:ok, uuid}

      :error -> {:error, "Invalid user ID!"}
    end
  end

  defp handle_get_user(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, "This user does not exist!"}

      user -> {:ok, user}
    end
  end
end
