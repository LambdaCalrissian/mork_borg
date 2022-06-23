defmodule :"Elixir.MorkBorg.Repo.Migrations.Add-location-to-item-armor-weapon-character" do
  use Ecto.Migration

  def change do
    alter table(:weapons) do
      add :location_id, references(:locations)
    end
    alter table(:characters) do
      add :location_id, references(:locations)
    end
    alter table(:items) do
      add :location_id, references(:locations)
    end
    alter table(:armor) do
      add :location_id, references(:locations)
    end
  end
end
