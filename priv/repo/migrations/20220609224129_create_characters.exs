defmodule MorkBorg.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :description, :string
      add :hit_points_current, :integer
      add :hit_points_max, :integer
      add :strength, :integer
      add :agility, :integer
      add :presence, :integer
      add :toughness, :integer
      add :omens, :integer

      timestamps()
    end
  end
end
