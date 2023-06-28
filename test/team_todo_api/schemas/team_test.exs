defmodule TeamTodoApi.Schemas.TeamTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.{User, Team}
  alias TeamTodoApi.Users.Create

  @user_default_params %{
    name: "azevedoguigo",
    email: "test@gmail.com",
    password: "supersenha"
  }

  describe "changeset/2" do
    test "When all parameters are valid, returns a valid changeset." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      team_params = %{
        name: "Team name",
        description: "Team description.",
        user_id: user_id
      }

      valid_changeset = Team.changeset(%Team{}, team_params)

      assert %Ecto.Changeset{valid?: true} = valid_changeset
    end

    test "When the team name is missing, returns an invalid changeset with the error." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      team_params = %{
        name: "",
        description: "Team description.",
        user_id: user_id
      }

      invalid_changeset = Team.changeset(%Team{}, team_params)

      assert errors_on(invalid_changeset) == %{name: ["can't be blank"]}
    end

    test "When the team name is less than 2 characters, it returns an invalid changeset with an error message." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      team_params = %{
        name: "T",
        description: "Team description.",
        user_id: user_id
      }

      invalid_changeset = Team.changeset(%Team{}, team_params)

      assert errors_on(invalid_changeset) == %{name: ["should be at least 2 character(s)"]}
    end

    test "When the team name is longer than 20 characters, returns an invalid changeset with an error message ." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      team_params = %{
        name: "TeamTeamTeamTeamTeamTeam", # 24 characters.
        description: "Team description.",
        user_id: user_id
      }

      invalid_changeset = Team.changeset(%Team{}, team_params)

      assert errors_on(invalid_changeset) == %{name: ["should be at most 20 character(s)"]}
    end

    test "When the team description is less than 2 characters, it returns an invalid changeset with an error message." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      team_params = %{
        name: "Team",
        description: "T",
        user_id: user_id
      }

      invalid_changeset = Team.changeset(%Team{}, team_params)

      assert errors_on(invalid_changeset) == %{description: ["should be at least 2 character(s)"]}
    end

    test "When the team description is more than 100 characters, it returns an invalid changeset with an error." do
      {:ok, %User{id: user_id}} = Create.create_user(@user_default_params)

      team_params = %{
        name: "Team",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
          Duis tristique ex in mauris bibendum efficitur.
          Phasellus fringilla velit non diam placerat pharetra.",
        user_id: user_id
      }

      invalid_changeset = Team.changeset(%Team{}, team_params)

      assert errors_on(invalid_changeset) == %{description: ["should be at most 100 character(s)"]}
    end

    test "When the user id is missing, it returns an invalid changeset with an error message." do
      team_params = %{
        name: "Teste",
        description: "Team description.",
        user_id: ""
      }

      invalid_changeset = Team.changeset(%Team{}, team_params)

      assert errors_on(invalid_changeset) == %{user_id: ["can't be blank"]}
    end
  end
end
