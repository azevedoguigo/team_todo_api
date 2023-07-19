defmodule TeamTodoApiWeb.FallbackController do
  use TeamTodoApiWeb, :controller

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: TeamTodoApiWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
