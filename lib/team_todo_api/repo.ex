defmodule TeamTodoApi.Repo do
  use Ecto.Repo,
    otp_app: :team_todo_api,
    adapter: Ecto.Adapters.Postgres
end
