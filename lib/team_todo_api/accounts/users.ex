defmodule TeamTodoApi.Accounts.Users do
  @moduledoc """
  This module provides functions for user profiles.
  """

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Repo

  def create(params) do
    %User{}
    |> User.chageset(params)
    |> Repo.insert()
  end
end
