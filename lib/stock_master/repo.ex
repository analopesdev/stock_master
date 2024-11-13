defmodule StockMaster.Repo do
  use Ecto.Repo,
    otp_app: :stock_master,
    adapter: Ecto.Adapters.Postgres
end
