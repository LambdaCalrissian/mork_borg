defmodule MorkBorg.Repo do
  use Ecto.Repo,
    otp_app: :mork_borg,
    adapter: Ecto.Adapters.SQLite3
end
