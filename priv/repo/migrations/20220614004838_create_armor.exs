defmodule MorkBorg.Repo.Migrations.CreateArmor do
  use Ecto.Migration

  def change do
    create table(:armor) do
      add :name, :string
      add :description, :string
      add :current_tier, :integer
      add :max_tier, :integer
      add :character_id, references(:characters, on_delete: :nothing)

      timestamps()
    end

    create index(:armor, [:character_id])
  end
end
