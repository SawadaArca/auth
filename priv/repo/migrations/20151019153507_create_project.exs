defmodule Auth.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :body, :text
      add :state, :string

      timestamps
    end

  end
end
