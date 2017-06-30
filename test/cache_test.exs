defmodule CacheTest do
  use ExUnit.Case
  alias Tleaog.Cache

  test "can store any valid Elixir term, given a key" do
    Cache.start_link
    stooges = ["Lary", "Curly", "Moe"]
    Cache.write(:stooges, stooges)
    assert Cache.read(:stooges) == stooges
  end

  test "can delete" do
    Cache.start_link
    stooges = ["Lary", "Curly", "Moe"]
    Cache.write(:stooges, stooges)
    assert Cache.read(:stooges) == stooges

    Cache.delete(:stooges)
    assert Cache.read(:stooges) == nil
  end

  test "can clear" do
    Cache.start_link
    stooges = ["Lary", "Curly", "Moe"]
    Cache.write(:stooges, stooges)
    assert Cache.read(:stooges) == stooges

    Cache.clear()
    assert Cache.read(:stooges) == nil
  end

  test "can check if exists" do
    Cache.start_link
    stooges = ["Lary", "Curly", "Moe"]
    Cache.write(:stooges, stooges)
    assert Cache.exists?(:stooges) == true
  end
end
