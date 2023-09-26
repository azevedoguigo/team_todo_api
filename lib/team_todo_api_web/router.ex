defmodule TeamTodoApiWeb.Router do
  use TeamTodoApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug TeamTodoApiWeb.Auth.Pipeline
  end

  scope "/api", TeamTodoApiWeb do
    pipe_through :api

    post "/users", UsersController, :create

    post "/login", AuthController, :login
  end

  scope "/api", TeamTodoApiWeb do
    pipe_through [:api, :auth]

    get "/todos", TodosController, :get_all
    post "/todos", TodosController, :create

    resources "/teams", TeamsController, only: [:create, :index]
    post "/teams/todos", TeamTodosController, :create
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:team_todo_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TeamTodoApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
