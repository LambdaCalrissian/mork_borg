defmodule MorkBorg.Repo.Migrations.CreateEquipment do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :string
      add :count, :integer
      add :action, :string
      add :character_id, references(:characters, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:character_id])
  end
end
