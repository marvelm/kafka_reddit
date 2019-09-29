use Mix.Config

config KafkaReddit,
  subreddit: "all"

config :kafka_ex,
  brokers: [
    {"localhost", 9092}
  ]
