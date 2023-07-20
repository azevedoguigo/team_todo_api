defmodule TeamTodoApiWeb.AuthJSON do
  def auth(%{token: token}), do: %{token: token}
end
