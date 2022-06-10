defmodule MorkBorg.Repo.Migrations.CreateWeapons do
  use Ecto.Migration

  def change do
    create table(:weapons) do
      add :name, :string
      add :description, :string
      add :damage, :integer

      timestamps()
    end
  end
end
