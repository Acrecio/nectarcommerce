defmodule FavoriteProductsPhoenix.Router do
  use FavoriteProductsPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/favorites", FavoriteProductsPhoenix do
    pipe_through [:browser, :browser_auth] # Use the default browser stack
    resources "/", FavoriteController, only: [:index, :update]
  end
  # Other scopes may use custom stacks.
  # scope "/api", FavoriteProductsPhoenix do
  #   pipe_through :api
  # end
end
