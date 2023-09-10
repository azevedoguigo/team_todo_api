defmodule TeamTodoApi.Teams.Create do
  @moduledoc """
  This module provides the useful function to create a new team.
  """

  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.Team
  alias TeamTodoApi.Users.Get

  def create_team(params, user_id) do
    case Get.get_user(user_id) do
      {:ok, _user} ->
        params = Map.put(params, "user_id", user_id)

        %Team{}
        |> Team.changeset(params)
        |> Repo.insert()

      {:error, message} -> {:error, message}
    end
  end
end
