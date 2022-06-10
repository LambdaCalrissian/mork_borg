defmodule MorkBorg.Repo.Migrations.WeaponBelongsToCharacter do
  use Ecto.Migration

  def change do
    alter table(:weapons) do
      add :character_id, references(:characters)
    end
  end
end
