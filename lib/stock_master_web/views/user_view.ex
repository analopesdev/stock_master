defmodule StockMasterWeb.UserView do
  use StockMasterWeb, :view

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      active: user.active
    }
  end

  def render("index.json", %{users: users}) do
    %{users: render_many(users, StockMasterWeb.UserView, "show.json")}
  end
end
