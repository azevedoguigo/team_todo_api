defmodule TeamTodoApiWeb.TeamsJSON do
  alias TeamTodoApi.Schemas.Team

  def create(%{team: team}) do
    %{
      message: "Team created!",
      team: data(team)
    }
  end

  defp data(%Team{} = team) do
    %{
      id: team.id,
      name: team.name,
      description: team.description,
      user_id: team.user_id,
      inserted_at: team.inserted_at,
      updated_at: team.updated_at
    }
  end
end
