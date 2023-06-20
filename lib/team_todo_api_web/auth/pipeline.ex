defmodule TeamTodoApiWeb.Auth.Pipeline do
  @moduledoc """
  Provides pipeline with Guardian plugs.
  """

  use Guardian.Plug.Pipeline, otp_app: :team_todo_api

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
