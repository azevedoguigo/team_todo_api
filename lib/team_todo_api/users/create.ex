defmodule TeamTodoApi.Users.Create do
  @moduledoc """
  Provides the function to register a user in the database.
  """

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Repo

  def create_user(params) do
    %User{}
    |> User.chageset(params)
    |> Repo.insert()
  end
end
