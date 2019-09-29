defmodule KafkaReddit do
  def scrape!() do
    subreddit = Application.get_env(KafkaReddit, :subreddit, "all")
    resp = HTTPoison.get!("https://www.reddit.com/r/#{subreddit}.json")
    resp.body |> Jason.decode!()
  end
end
