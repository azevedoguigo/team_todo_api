defmodule TeamTodoApiWeb.UsersJSON do

  alias TeamTodoApi.Schemas.User

  def create(%{user: user}) do
    %{
      message: "User created!",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
