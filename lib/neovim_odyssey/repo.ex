defmodule NeovimOdyssey.Repo do
  use Ecto.Repo,
    otp_app: :neovim_odyssey,
    adapter: Ecto.Adapters.SQLite3
end
