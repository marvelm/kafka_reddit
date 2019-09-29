# KafkaReddit

A Kafka producer to fetch posts from Reddit and publish to a topic called `posts`.

## Usage
- Elixir should be installed
- Kafka should be installed and running
- Tweak the config at `config/config.exs`.

To run:
```bash
git clone https://github.com/marvel/kafka_reddit
cd kafka_reddit
mix deps.get
mix run --no-halt
```

