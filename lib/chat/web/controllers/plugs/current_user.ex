defmodule Chat.Web.Plugs.CurrentUser do
  
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = get_session(conn, :current_user)
    assign(conn, :current_user, current_user)
  end
end