defmodule KafkaReddit.Producer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  @impl true
  def init(_args) do
    send(self(), :tick)
    {:ok, nil}
  end

  @impl true
  def handle_info(:tick, state) do
    response = KafkaReddit.scrape!()

    new_pairs =
      response["data"]["children"]
      |> Enum.filter(fn it ->
        match?(
          {:ok, false},
          Cachex.exists?(:producer, it["data"]["id"]))
      end)

      |> Enum.map(fn it ->
        {it["data"]["id"], it}
      end)

    # It's okay to crash at this point.
    # The supervisor will restart the producer.
    {:ok, _} = Cachex.put_many(:producer, new_pairs)

    KafkaEx.produce(%KafkaEx.Protocol.Produce.Request{
      topic: "posts",
      partition: 0,
      required_acks: 0,
      messages:
        for {id, it} <- new_pairs do
          serialized = Jason.encode!(it)
          %KafkaEx.Protocol.Produce.Message{key: id, value: serialized}
        end
    })

    Process.send_after(self(), :tick, 30_000)
    {:noreply, state}
  end
end
