defmodule StateServer.MixProject do
  use Mix.Project

  defp description() do
    ~s"""
    Defines a GenServer with macros to prevent the GenServer's boilerplate.
    """
  end

  defp package do
    [
      name: "ax_stateserver",
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Andreas Altendorfer"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/iboard/state_server"}
    ]
  end

  def project do
    [
      app: :state_server,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      xref: [exclude: [:crypto]],

      # Hex 
      package: package(),
      description: description(),
      licence: ["MIT"],
      links: ["https://github.com/iboard/state_server"],

      # Docs 
      name: "Altex StateServer",
      source_url: "https://github.com/iboard/axrepo",
      homepage_url: "https://github.com/iboard/altex",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]

    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {StateServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.26", only: :dev, runtime: false}
    ]
  end
end
