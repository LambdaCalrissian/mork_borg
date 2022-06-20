defmodule MorkBorg.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :description, :string
      add :adjoins, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:adjoins])
  end
end
