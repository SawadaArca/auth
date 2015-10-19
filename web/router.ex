defmodule Auth.Router do
  use Auth.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Auth.Auth, repo: Auth.Repo
  end

  pipeline :authenticated do
    plug Auth.Authenticate, repo: Auth.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Auth do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create]
    resources "/users", UserController, only: [:new, :create]
  end

  scope "/", Auth do
    pipe_through [:browser, :authenticated]

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:delete]
    resources "/projects", ProjectController
  end


end
