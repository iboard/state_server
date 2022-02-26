# StateServer

A simple wrapper around GenServer.

There is a lot of annoying boilerplate when you're about to use GenServer. This project
brings you some macro-sugar to simplify your GenServers and get rid of all that boilerplate.

## Installation

It's [available in Hex][1], the package can be installed
by adding `ax_stateserver` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:state_server, "~> 0.1.0", hex: :ax_stateserver}
  ]
end
```

## Hex package

- <https://hex.pm/packages/ax_stateserver>
- Notice: the hex-package is named `ax_stateserver` where the mix-project is named just
  `StateServer`. This is because of a name clash of `state_server` on hex.pm.

[1]: https://hex.pm/docs/publish
