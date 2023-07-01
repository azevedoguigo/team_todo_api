defmodule TeamTodoApi.Teams.Get do
  @moduledoc """
  Provides useful functions to search for teams.
  """

  alias Ecto.UUID
  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.Team

  def get_team(team_id) do
    case validate_team_id(team_id) do
      {:ok, uuid} -> handle_get_team(uuid)

      {:error, message} -> {:error, message}
    end
  end

  defp validate_team_id(team_id) do
    case UUID.cast(team_id) do
      {:ok, uuid} -> {:ok, uuid}

      :error -> {:error, "Invalid team ID!"}
    end
  end

  defp handle_get_team(uuid) do
    case Repo.get(Team, uuid) do
      nil -> {:error, "This team does not exist!"}

      team -> {:ok, team}
    end
  end
end
