defmodule StockMaster.Accounts do
  alias StockMaster.Repo
  alias StockMaster.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create_user(attrs \\ %{}) do
    try do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    rescue
      error -> {:error, %{message: error.message}}
    end
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end
