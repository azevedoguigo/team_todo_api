defmodule TeamTodoApi.Teams.Todos.Get do
  @moduledoc """

  """

  import Ecto.Query
  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.TeamTodo

  def get_all(team_id) do
    todos =
      from(todo in TeamTodo, where: todo.team_id == ^team_id)
      |> Repo.all()

    check_todos_count(todos, Enum.count(todos))
  end

  defp check_todos_count(todos, todos_count) when todos_count > 0, do: {:ok, todos}

  defp check_todos_count(_todos, todos_count) when todos_count == 0 do
    {
      :error,
      %{
        message: "You don't have todos!",
        status: :not_found
      }
    }
  end
end
