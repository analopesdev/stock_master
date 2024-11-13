defmodule StockMaster.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def up do
    create table("product", primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :name, :string, size: 255
      add :description, :string, size: 1024
      add :quantity, :integer
      add :price, :decimal, precision: 10, scale: 2
      add :code, :char
      add :active, :boolean, default: true

      timestamps()
    end
  end

  def down do
    drop table("product")
  end
end
