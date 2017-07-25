defmodule Chat.Web.AuthController do
  use Chat.Web, :controller

  plug Ueberauth
  alias Chat.Account

  def request(conn, _params) do
    conn
  end


  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{name: auth.info.name, email: auth.info.email,
     avatar: auth.info.image, token: auth.credentials.token} 
      
    case create_or_get_user(user_params) do
      {:ok, user} -> 
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "SignIn Successful")
        |> redirect(to: page_path(conn, :index))
      {:error, _changeset} -> 
        conn
        |> put_flash(:error, "Something Went Wrong")
        |> redirect(to: page_path(conn, :index))
    end
  end

  defp create_or_get_user(%{email: email} = user_params) do
    user = Account.get_user_by_email(email)
  
    cond do
      user -> {:ok, user}
      true -> Account.create_user(user_params)
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :index))
  end
end