defmodule StockMaster.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def up do
    create table("file", primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :name, :string, size: 255
      add :source_name, :string, size: 255
      add :content_type, :string, size: 255
      add :url, :string, size: 255

      timestamps()
    end
  end

  def down do
    drop table("file")
  end
end
