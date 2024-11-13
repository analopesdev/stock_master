defmodule StockMasterWeb.Router do
  use StockMasterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {StockMasterWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StockMasterWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api" do
    forward "/swagger", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :stock_master,
      swagger_file: "swagger.json"
  end

  scope "/api/v1", StockMasterWeb do
    pipe_through :api
    resources "/users", UserController
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Stock Master"
      }
    }
  end

  # Defines "RESTful" routes for a resource.
  # GET /users => :index
  # GET /users/new => :new
  # POST /users => :create
  # GET /users/:id => :show
  # GET /users/:id/edit => :edit
  # PATCH /users/:id => :update
  # PUT /users/:id => :update
  # DELETE /users/:id => :delete

  # Other scopes may use custom stacks.
  # scope "/api", StockMasterWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:stock_master, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: StockMasterWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
