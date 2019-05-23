defmodule AdWords.MixProject do
  use Mix.Project

  def project do
    [
      app: :ad_words,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls, test_task: "espec"],
      preferred_cli_env: [
        espec: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      compilers: [:phoenix_swagger] ++ Mix.compilers(),
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :soap, :inets, :oauth2, :httpoison],
      mod: {AdWords.Application, []}
    ]
  end

  defp deps do
    [
      {:soap, git: "https://github.com/bet365/soap", branch: "master"},
      {:oauth2, "~> 0.9"},
      {:poison, "~> 3.1"},
      {:plug_cowboy, "~> 2.0"},
      {:httpoison, "~> 1.0"},
      {:phoenix_swagger, "~> 0.8"},
      {:nimble_csv, "~> 0.3"},

      # TEST ENV
      {:excoveralls, "~> 0.8", only: :test},
      {:ex_machina, "~> 2.2", only: :test},
      {:espec, "~> 1.6.1", only: :test},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false}
    ]
  end

  # This makes sure your factory and any other modules in test/support are compiled
  # when in the test environment.
  defp elixirc_paths(:test),
    do: ["lib", "include", "src", "spec/support"]

  defp elixirc_paths(_), do: ["lib", "web"]
end
