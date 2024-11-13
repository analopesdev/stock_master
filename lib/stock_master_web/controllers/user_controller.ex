defmodule StockMasterWeb.UserController do
  use StockMasterWeb, :controller
  use PhoenixSwagger

  # swagger_path :index do
  #   get("/api/v1/users")
  #   tag("Users")
  #   description("List Users")

  #   response(200, "OK", Schema.ref(:User))
  #   response(400, "Client Error")
  # end

  # def index(conn, _params) do
  # end

  swagger_path :create do
    post("/api/v1/users")
    tag("Users")
    description("Create User")
    response(200, "OK", Schema.ref(:User))
    response(400, "Client Error")
    response(500, "Client Error")
  end

  def create(conn, params) do
    case StockMaster.Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(StockMasterWeb.UserView, "show.json", user: user)

      {:error, error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: error})
    end
  end

  @spec swagger_definitions() :: %{User: any()}
  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("A user of the application")

          properties do
            id(:string, "Unique identifier", required: true)
            name(:string, "Users name", required: true)
            address(:string, "Home address")
            role(:string, "User role (admin/user)")
            active(:boolean, "If the user is active", default: true)
          end
        end
    }
  end
end
