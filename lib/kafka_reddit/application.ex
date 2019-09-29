defmodule KafkaReddit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    children = [
      worker(Cachex, [:producer, [limit: 500]]),
      worker(KafkaReddit.Producer, [], restart: :permanent)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KafkaReddit.Supervisor, max_restarts: 1_000]
    Supervisor.start_link(children, opts)
  end
end
