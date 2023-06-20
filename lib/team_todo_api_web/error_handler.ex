defmodule TeamTodoApiWeb.ErrorHandler do
  @moduledoc """
  Provides a function (humanize_errors/1 ) to more readably format changeset error messages to be
  returned to the user through the controller.
  """

  import Ecto.Changeset, only: [traverse_errors: 2]

  def humanize_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
