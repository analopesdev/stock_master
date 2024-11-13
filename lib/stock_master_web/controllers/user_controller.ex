defmodule StockMasterWeb.UserController do
  use StockMasterWeb, :controller
  use PhoenixSwagger

  swagger_path :index do
    get("/api/v1/users")
    description("List Users")
    response(400, "Client Error")
  end

  def index(conn, params) do
    case StockMaster.Accounts.list() do
      users ->
        conn
        |> put_status(200)
        |> render(StockMasterWeb.UserView, "index.json", users: users)

      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{})
    end
  end

  swagger_path :create do
    post("/api/v1/users")
    tag("Users")
    description("Create User")
    response(201, "OK", Schema.ref(:User))
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

  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/api/v1/users/{id}")
    tag("Users")
    description("Delete a User")
    response(204, "OK", Schema.ref(:User))
    response(400, "Client Error")
    response(500, "Client Error")

    parameters do
      id(:path, :string, "User ID", required: true)
    end
  end

  def delete(conn, %{"id" => id}) do
    case StockMaster.Accounts.delete_user(id) do
      {:ok, message} ->
        conn
        |> put_status(:no_content)
        |> json(%{message: message})

      {:error, error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: error})
    end
  end

  swagger_path(:update) do
    put("/api/v1/users/{id}")
    tag("Users")
    description("Delete a User")
    response(204, "OK", Schema.ref(:User))
    response(400, "Client Error")
    response(500, "Client Error")
  end

  def update(conn, params) do
    IO.inspect(params)

    case StockMaster.Accounts.update_user(params) do
      {:ok, user} ->
        conn
        |> put_status(200)
        |> render(StockMasterWeb.UserView, "show.json", user: user)

      {:error, error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: error})
    end
  end

  swagger_path(:show) do
    get("/api/v1/users/{id}")
    tag("Users")
    description("Get a User to Edit")
    response(204, "OK", Schema.ref(:User))
    response(400, "Client Error")
    response(500, "Client Error")

    parameters do
      id(:path, :string, "User ID", required: true)
    end
  end

  def show(conn, %{"id" => id}) do
    case StockMaster.Accounts.get_user!(id) do
      {:ok, user} ->
        conn
        |> put_status(200)
        |> render(StockMasterWeb.UserView, "show.json", user: user)

      {:error, error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: error})
    end
  end

  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("A user of the application")

          properties do
            name(:string, "User name", required: true)
            email(:string, "User email", required: true)
            role(:string, "User role (admin/user)")
            active(:boolean, "If the user is active", default: true)
          end
        end
    }
  end
end
