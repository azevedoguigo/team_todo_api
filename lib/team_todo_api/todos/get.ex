defmodule TeamTodoApi.Todos.Get do
  @moduledoc """
  Provides useful functions to fetch the todos.
  """

  import Ecto.Query

  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.Todo

  def get_all(user_id) do
    todos =
      from(todo in Todo, where: todo.user_id == ^user_id)
      |> Repo.all()

    check_todos_count(todos, Enum.count(todos))
  end

  defp check_todos_count(todos, todos_count) when todos_count > 0, do: {:ok, todos}
  defp check_todos_count(_todos, todos_count) when todos_count == 0, do: {:error, "You don't have todos!"}
end
