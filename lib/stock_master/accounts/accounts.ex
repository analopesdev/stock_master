defmodule StockMaster.Accounts do
  alias StockMaster.Repo
  alias StockMaster.Accounts.User

  def list() do
    Repo.all(User)
  end

  def get_user(id) do
    case Repo.get(User, id) do
      nil ->
        {:error, %{message: "User not found"}}

      user ->
        {:ok, user}
    end
  end

  def create_user(attrs \\ %{}) do
    changeset =
      %User{}
      |> User.changeset(attrs)

    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, user}

      {:error, changeset} ->
        errors = format_changeset_errors(changeset)
        {:error, errors}
    end
  end

  def update_user(attrs) do
    case Repo.get(User, attrs["id"]) do
      nil ->
        {:error, "User not found"}

      user ->
        user
        |> User.update_changeset(attrs)
        |> Repo.update()
    end
  end

  def delete_user(id) do
    case Repo.get(User, id) do
      nil ->
        {:error, %{message: "User not found"}}

      user ->
        case Repo.delete(user) do
          {:ok, _deleted_user} ->
            {:ok, "User deleted successfully"}

          {:error, changeset} ->
            {:error, changeset}
        end
    end
  end

  defp format_changeset_errors(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {message, _}} -> %{field: field, message: message} end)
  end
end
