defmodule TeamTodoApi.Todos.Create do
  alias TeamTodoApi.Repo
  alias TeamTodoApi.Schemas.Todo

  def create_todo(params, user_id) do
    params = Map.put(params, "user_id", user_id)

    %Todo{}
    |> Todo.changeset(params)
    |> Repo.insert()
  end
end
