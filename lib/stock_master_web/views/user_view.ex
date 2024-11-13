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
end
