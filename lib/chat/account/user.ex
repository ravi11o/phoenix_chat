defmodule Chat.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.Account.User


  schema "account_users" do
    field :avatar, :string
    field :email, :string
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :avatar, :token])
    |> validate_required([:name, :email, :avatar, :token])
    |> unique_constraint(:email)
  end
end
