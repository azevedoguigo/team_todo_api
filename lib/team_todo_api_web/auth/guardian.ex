defmodule TeamTodoApiWeb.Auth.Guardian do
  @moduledoc """
  Implementation module that provides functions for the Guardian to encode and decode token values.
  """

  use Guardian, otp_app: :team_todo_api

  alias TeamTodoApi.Schemas.User
  alias TeamTodoApi.Repo

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = Repo.get(User, id)
    {:ok, resource}
  end
end
