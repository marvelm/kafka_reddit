defmodule KafkaReddit.MixProject do
  use Mix.Project

  def project do
    [
      app: :kafka_reddit,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {KafkaReddit.Application, []},
      extra_applications: [:logger, :httpoison]
    ]
  end

  defp deps do
    [
      {:cachex, "~> 3.2"},
      {:httpoison, "~> 1.5"},
      {:jason, "~> 1.1"},
      {:kafka_ex, "~> 0.9.0"},
      {:snappy, git: "https://github.com/fdmanana/snappy-erlang-nif"}
    ]
  end
end
