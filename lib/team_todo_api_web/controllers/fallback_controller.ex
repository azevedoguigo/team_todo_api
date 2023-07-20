defmodule TeamTodoApiWeb.FallbackController do
  use TeamTodoApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: TeamTodoApiWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(TeamTodoApiWeb.ErrorJSON)
    |> render(:error, message: message)
  end
end
