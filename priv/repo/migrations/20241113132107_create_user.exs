defmodule StockMaster.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def up do
    execute "CREATE TYPE user_role AS ENUM ('user', 'admin')"

    create table(:user, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :name, :string, size: 255
      add :email, :string, size: 255
      add :password_hash, :string, size: 255
      add :role, :user_role, default: "user"
      add :active, :boolean, default: true

      timestamps()
    end

    create unique_index(:user, [:email])
  end

  def down do
    drop index(:user, [:email])
    drop table(:user)
    execute "DROP TYPE IF EXISTS user_role"
  end
end
