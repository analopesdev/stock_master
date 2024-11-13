defmodule StockMaster.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "user" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :role, Ecto.Enum, values: [:user, :admin], default: :user
    field :active, :boolean, default: true
    field :password, :string, virtual: true
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :role, :active])
    |> validate_required([:name, :email, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
    end
  end
end
