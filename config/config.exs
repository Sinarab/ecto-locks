import Config

config :ecto_lock, EctoLock.Repo,
  database: "ecto_lock_repo",
  username: "postgres",
  password: "badcoffee",
  hostname: "localhost"

config :ecto_lock, ecto_repos: [EctoLock.Repo]
