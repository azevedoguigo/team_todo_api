defmodule TeamTodoApi.Teams.Create do
  @moduledoc """
  This module provides the useful function to create a new team.
  """

  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.Team

  def create_team(params, user_id) do
    params = Map.put(params, "user_id", user_id)

    %Team{}
    |> Team.changeset(params)
    |> Repo.insert()
  end
end
