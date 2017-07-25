defmodule Chat.Repo.Migrations.CreateChat.Account.User do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :name, :string
      add :email, :string
      add :avatar, :string
      add :token, :string

      timestamps()
    end
    create unique_index(:account_users, [:email])

  end
end
