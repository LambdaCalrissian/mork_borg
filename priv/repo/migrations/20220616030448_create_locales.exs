defmodule MorkBorg.Repo.Migrations.CreateLocales do
  use Ecto.Migration

  def change do
    create table(:locales) do
      add :name, :string
      add :description, :string

      timestamps()
    end

    alter table(:locations) do
      add :locale_id, references(:locales, on_delete: :nothing)
    end

    create index(:locations, [:locale_id])
  end
end
