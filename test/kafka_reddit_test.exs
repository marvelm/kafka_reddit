defmodule KafkaRedditTest do
  use ExUnit.Case
  doctest KafkaReddit

  test "greets the world" do
    assert KafkaReddit.hello() == :world
  end
end
