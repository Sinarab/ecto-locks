# EctoLock
When running an application in multiple servers, we can end up have issues such as doubling our requests. That's the moment to recur to find a solution and here we are going to solve using **locking**. 

Based on: https://medium.com/flatiron-labs/database-locking-with-ecto-in-elixir-9804cdbd1866

Futher exploring: using `Ecto.Multi` to create larger transactions and optimizing lock. 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_lock` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_lock, "~> 0.1.0"}
  ]
end
```

```elixir
mix deps.get
mix ecto.gen.repo -r EctoLock.Repo
mix ecto.create
mix ecto.migrate

iex -S mix
```

On iex you can run:
```
EctoLock.Helper.create_invoices
EctoLock.Helper.bill_from_two_servers # true for loking
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ecto_lock>.

