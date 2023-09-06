defmodule TeamTodoApiWeb.TodosJSON do
  alias TeamTodoApi.Schemas.Todo

  def create(%{todo: todo}) do
    %{
      message: "ToDo Created!",
      data: data(todo)
    }
  end

  defp data(%Todo{} = todo) do
    %{
      id: todo.id,
      title: todo.title,
      description: todo.description,
      user_id: todo.user_id,
      completed: todo.completed,
      inserted_at: todo.inserted_at,
      updated_at: todo.updated_at
    }
  end
end
