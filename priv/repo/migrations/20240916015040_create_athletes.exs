defmodule Beepboop.Repo.Migrations.CreateAthletes do
  use Ecto.Migration

  def change do
    create table(:athletes) do
      add :name, :string
      add :emoji, :string
      add :sport, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
