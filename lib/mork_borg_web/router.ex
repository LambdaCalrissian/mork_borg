defmodule MorkBorgWeb.Router do
  use MorkBorgWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MorkBorgWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MorkBorgWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/characters", CharacterLive.Index, :index
    live "/characters/new", CharacterLive.Index, :new
    live "/characters/:id/edit", CharacterLive.Index, :edit

    live "/characters/:id", CharacterLive.Show, :show
    live "/characters/:id/show/edit", CharacterLive.Show, :edit

    live "/weapons", WeaponLive.Index, :index
    live "/weapons/new", WeaponLive.Index, :new
    live "/weapons/:id/edit", WeaponLive.Index, :edit

    live "/weapons/:id", WeaponLive.Show, :show
    live "/weapons/:id/show/edit", WeaponLive.Show, :edit

    live "/items", ItemLive.Index, :index
    live "/items/new", ItemLive.Index, :new
    live "/items/:id/edit", ItemLive.Index, :edit

    live "/items/:id", ItemLive.Show, :show
    live "/items/:id/show/edit", ItemLive.Show, :edit

    live "/armor", ArmorLive.Index, :index
    live "/armor/new", ArmorLive.Index, :new
    live "/armor/:id/edit", ArmorLive.Index, :edit

    live "/armor/:id", ArmorLive.Show, :show
    live "/armor/:id/show/edit", ArmorLive.Show, :edit

    live "/locations", LocationLive.Index, :index
    live "/locations/new", LocationLive.Index, :new
    live "/locations/:id/edit", LocationLive.Index, :edit

    live "/locations/:id", LocationLive.Show, :show
    live "/locations/:id/show/edit", LocationLive.Show, :edit

    live "/locales", LocaleLive.Index, :index
    live "/locales/new", LocaleLive.Index, :new
    live "/locales/:id/edit", LocaleLive.Index, :edit

    live "/locales/:id", LocaleLive.Show, :show
    live "/locales/:id/show/edit", LocaleLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", MorkBorgWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MorkBorgWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
