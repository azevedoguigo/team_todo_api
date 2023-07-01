defmodule TeamTodoApi.Teams.Members.Create do
  @moduledoc """
  Provides a function to add a new member to the team.
  """

  alias TeamTodoApi.Repo
  alias Ecto.Changeset
  alias TeamTodoApi.{Users, Teams}

  def create_team_member(user_id, team_id) do
    with {:ok, user} <- Users.Get.get_user(user_id),
        {:ok, team} <- Teams.Get.get_team(team_id) do
          handle_create_member(user, team)
        else
          {:error, message} -> {:error, message}
    end
  end

  defp handle_create_member(user, team) do
    user = Repo.preload(user, [:todos, :team, :teams])
    team = Repo.preload(team, [:user, :users])

    team_changeset = Changeset.change(team)
    team_with_member = Changeset.put_assoc(team_changeset, :users, [user])

    team = Repo.update!(team_with_member)

    {:ok, team}
  end
end
