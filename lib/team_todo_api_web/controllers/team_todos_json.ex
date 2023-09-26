defmodule TeamTodoApiWeb.TeamTodosJSON do
  alias TeamTodoApi.Schemas.TeamTodo

  def create(%{todo: todo}) do
    %{
      message: "ToDo Created!",
      data: data(todo)
    }
  end

  def get_all(%{todos: todos}) do
    %{
      todos: Enum.map(todos, fn todo -> data(todo) end)
    }
  end

  defp data(%TeamTodo{} = todo) do
    %{
      id: todo.id,
      title: todo.title,
      description: todo.description,
      team_id: todo.team_id,
      completed: todo.completed,
      inserted_at: todo.inserted_at,
      updated_at: todo.updated_at
    }
  end
end
