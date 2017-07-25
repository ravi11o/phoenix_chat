defmodule Chat.Web.RoomChannel do
  use Phoenix.Channel

  alias Chat.Account

  def join("room:lobby", _msg, socket) do
    {:ok, socket}
  end 

  def handle_in("new_message", msg, socket) do
    user = 
      if user_id = socket.assigns.user_id do
        Account.get_user!(user_id)
      end

    broadcast! socket, "new_message", %{name: first_name(user), text: msg["text"]}
    {:reply, {:ok, %{text: msg["text"]}}, assign(socket, :user, first_name(user))}
  end

  defp first_name(%{name: name} = user) do
    name
    |> String.split
    |> List.first
    |> String.downcase
    |> String.capitalize 
  end
end