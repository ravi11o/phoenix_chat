defmodule Chat.Web.Plugs.AuthenticateUser do

  import Phoenix.Controller
  import Plug.Conn
  alias Chat.Web.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else 
      conn
      |> put_flash(:error, "You must login First")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end